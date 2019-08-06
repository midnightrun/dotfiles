alias cat bat
alias gaa "git add ."
alias gc "git commit -m"

set -gx BAT_THEME DarkNeon 
set -gx PATH /usr/local/bin/fzf $PATH
set -gx PATH $PATH /usr/local/sbin
set -gx PATH $PATH /usr/local/bin
set -gx PATH $PATH /Users/camal/flutter/bin 
set -gx PATH $PATH /Users/camal/go/bin 
set -gx PATH $PATH /Users/camal/.nix-profile/etc/profile.d/nix.sh
set -gx GOBIN /Users/camal/go/bin
set -gx ERL_AFLAGS "-kernel shell_history enabled"
set -gx fish_user_paths "/usr/local/sbin" $fish_user_paths
set -gx theme_display_vi no
set -gx EDITOR vim

set  theme_color_scheme dracula

if test -e '/Users/camal/.nix-profile/etc/profile.d/nix.sh'
  fenv source '/Users/camal/.nix-profile/etc/profile.d/nix.sh'
end

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[ -f /Users/camal/source/node_modules/tabtab/.completions/serverless.fish ]; and . /Users/camal/source/node_modules/tabtab/.completions/serverless.fish
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[ -f /Users/camal/source/node_modules/tabtab/.completions/sls.fish ]; and . /Users/camal/source/node_modules/tabtab/.completions/sls.fish
# tabtab source for slss package
# uninstall by removing these lines or running `tabtab uninstall slss`
[ -f /Users/camal/source/node_modules/tabtab/.completions/slss.fish ]; and . /Users/camal/source/node_modules/tabtab/.completions/slss.fish
