#!/bin/sh

# Fixed-width frames keep the tmux status panel from shifting while the fish swims.
case $(( $(date +%s) % 6 )) in
  0) printf "~. }><(((o>    " ;;
  1) printf "o.  }><(((o>   " ;;
  2) printf "O.   }><(((o>  " ;;
  3) printf "    <o)))><{ .~" ;;
  4) printf "   <o)))><{  .o" ;;
  5) printf "  <o)))><{   .O" ;;
esac
