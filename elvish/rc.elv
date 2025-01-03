use github.com/zzamboni/elvish-modules/terminal-title

set edit:rprompt = (constantly ())
set edit:-prompt-eagerness = 10
set edit:insert:binding[Ctrl-Backspace] = { edit:kill-word-left }
set edit:insert:binding[Alt-Backspace] = { edit:kill-small-word-left }

eval (zoxide init --cmd cd elvish | slurp)
eval (carapace _carapace|slurp)

fn ls { |@a| e:eza $@a }
fn cat { |@a| bat --paging=never $@a }
fn fzf { |@a| sk $@a }
fn lzd { |@a| lazydocker $@a }
fn lzg { |@a| lazygit $@a }
fn vi { |@a| nvim $@a }
fn yy { |@a| yazi $@a }
