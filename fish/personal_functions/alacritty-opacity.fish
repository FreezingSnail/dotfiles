# Reads exactly one byte from stdin and prints its decimal code, or nothing at
# EOF. `read --nchars 1` cannot be used: it does not reliably surface the raw
# escape bytes that arrow keys send, so ←/→ were silently swallowed.
function __alacritty_opacity_byte --description 'Read one byte from stdin as a decimal code'
    # od emits padding and a trailing blank element, which command substitution
    # turns into a multi-element list; only the first numeric token is the byte.
    set -l fields (dd bs=1 count=1 2>/dev/null | od -An -tu1 | string split -n ' ')
    if test (count $fields) -gt 0
        echo $fields[1]
    end
end

function alacritty-opacity --description 'Live slider for Alacritty opacity'
    set -l alacritty /Applications/Alacritty.app/Contents/MacOS/alacritty
    set -l config $HOME/.config/alacritty/alacritty.toml
    # Alacritty has no IPC query for current opacity, so the last applied value
    # is cached here; it is the only way to reopen at what is on screen rather
    # than at the last saved config value.
    set -l state_dir $HOME/.cache/alacritty-opacity
    set -l state_file $state_dir/current
    set -l opacity_pattern '^[[:space:]]*opacity[[:space:]]*=[[:space:]]*[0-9.]+[[:space:]]*$'

    if not test -x "$alacritty"
        printf 'Alacritty not found: %s\n' "$alacritty" >&2
        return 1
    end
    if not isatty stdin; or not isatty stdout
        printf 'Run alacritty-opacity in an interactive terminal.\n' >&2
        return 1
    end

    set -l percent
    if test -r "$state_file"
        set -l cached (string trim -- (cat "$state_file"))
        if string match --quiet --regex '^[0-9]{1,3}$' -- "$cached"
            set percent $cached
        end
    end
    if test -z "$percent"; and test -r "$config"
        while read --line line
            set -l match (string match --regex --groups-only '^[[:space:]]*opacity[[:space:]]*=[[:space:]]*([0-9.]+)[[:space:]]*$' -- "$line")
            if test -n "$match"
                set percent (math -s0 "round($match[1] * 100)")
                break
            end
        end < "$config"
    end
    test -n "$percent"; or set percent 75
    set percent (math "max(0, min(100, $percent))")

    set -l tty_state (stty -g)
    stty -echo -icanon min 1 time 0
    printf '\e[?25l'

    set -l message 'Live only — s persists to config; q exits.'
    while true
        set -l filled (math -s0 "round($percent / 2)")
        set -l empty (math "50 - $filled")
        set -l filled_bar (string repeat --count $filled '█')
        set -l empty_bar (string repeat --count $empty '░')
        printf '\e[H\e[2J'
        printf '\e[1;36mAlacritty opacity\e[0m  \e[1m%3d%%\e[0m\n\n' $percent
        printf '  \e[36m╞%s%s╡\e[0m\n\n' "$filled_bar" "$empty_bar"
        printf '  ←/→  ±5%%     h/l  ±1%%     H/L  ±10%%\n'
        printf '  Hold adjustment keys for repeated live updates.\n'
        printf '  s  save     q  quit\n\n'
        printf '\e[2K%s\e[J' "$message"

        set -l key
        set -l code (__alacritty_opacity_byte)
        switch "$code"
            case ''
                set key QUIT
            case 27
                # Bare Escape must not block waiting for a sequence that will
                # never arrive, so drop to a 0.1s read timeout for the tail.
                stty min 0 time 1
                set -l introducer (__alacritty_opacity_byte)
                set -l final (__alacritty_opacity_byte)
                stty min 1 time 0
                if test "$introducer" = 91
                    switch "$final"
                        case 68
                            set key LEFT
                        case 67
                            set key RIGHT
                        case 66
                            set key LEFT
                        case 65
                            set key RIGHT
                    end
                else
                    set key QUIT
                end
            case 3 113 81
                set key QUIT
            case 115 83
                set key SAVE
            case 104
                set key MINUS_ONE
            case 108
                set key PLUS_ONE
            case 72
                set key MINUS_TEN
            case 76
                set key PLUS_TEN
        end

        switch "$key"
            case QUIT
                break
            case SAVE
                set -l opacity (math -s2 "$percent / 100")
                set -l original (cat "$config" | string collect)
                # Every guard below exists because a bad save silently truncates
                # the only Alacritty config; never write without a verified body.
                if test -z "$original"
                    set message 'Save skipped: config unreadable or empty.'
                    continue
                end
                if not string match --quiet --regex "(?m)$opacity_pattern" -- "$original"
                    set message 'Save skipped: no opacity setting in config.'
                    continue
                end
                set -l updated (string replace --regex "(?m)$opacity_pattern" "opacity = $opacity" -- "$original" | string collect)
                if test -z "$updated"
                    set message 'Save aborted: rewrite produced no content.'
                    continue
                end
                if not string match --quiet --regex "(?m)^opacity = $opacity\$" -- "$updated"
                    set message 'Save aborted: rewrite did not apply.'
                    continue
                end
                cp -p "$config" "$config.bak"
                # Truncate-and-write in place keeps the original inode, owner and
                # mode; mv from mktemp would leave the config 0600.
                if printf '%s\n' "$updated" > "$config"
                    set message "Saved $percent% (backup: alacritty.toml.bak)."
                else
                    cp -p "$config.bak" "$config"
                    set message 'Save failed: config restored from backup.'
                end
                continue
            case LEFT
                set percent (math "max(0, $percent - 5)")
            case RIGHT
                set percent (math "min(100, $percent + 5)")
            case MINUS_ONE
                set percent (math "max(0, $percent - 1)")
            case PLUS_ONE
                set percent (math "min(100, $percent + 1)")
            case MINUS_TEN
                set percent (math "max(0, $percent - 10)")
            case PLUS_TEN
                set percent (math "min(100, $percent + 10)")
            case '*'
                continue
        end

        set -l opacity (math -s2 "$percent / 100")
        if "$alacritty" msg config --window-id -1 "window.opacity=$opacity" >/dev/null 2>&1
            set message "Live: $percent%  (config unchanged until s)"
            mkdir -p "$state_dir"; and printf '%s\n' $percent > "$state_file"
        else
            set message 'Live update failed: no running Alacritty IPC target?'
        end
    end

    stty "$tty_state"
    printf '\e[?25h'
end
