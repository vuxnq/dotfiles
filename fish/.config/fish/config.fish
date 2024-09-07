if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -Ux FZF_DEFAULT_OPTS "\
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

set -gx EDITOR hx
set -gx PATH $PATH ~/.local/bin
set -gx PATH $PATH ~/.spicetify # spicetify
set -gx PATH $PATH ~/.cargo/bin # rust cargo

zoxide init --cmd cd fish | source

fish_add_path /home/vuxnq/.spicetify
