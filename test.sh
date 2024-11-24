#!/nix/store/306znyj77fv49kwnkpxmb0j2znqpa8bj-bash-5.2p26/bin/bash
#!/usr/bin/env bash
format='{1}:{2}:{3}'
if [ "$EDITOR" == 'nvim' ];then
  format="+'call cursor({2},{3})' {1}"
fi
echo "$format"
rg_prefix="rg --column --line-number --no-heading --color=always --smart-case $*"
fzf --bind 'start:reload:'"$rg_prefix" \
  --bind "change:reload:$rg_prefix {q} || true" \
  --ansi --disabled \
  --delimiter : \
  --bind "enter:become($EDITOR $format)" \
  --preview 'bat --color=always --style=numbers,changes --highlight-line {2} {1}' \
  --bind "shift-up:preview-page-up,shift-down:preview-page-down" \
  --bind "alt-up:preview-up,alt-down:preview-down"
