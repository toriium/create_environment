if status is-interactive
    # Commands to run in interactive sessions can go here
    starship init fish | source
    mise activate fish | source

end


alias la="eza -lah  --icons --sort extension --group-directories-first"
alias ls="eza -lh  --icons --sort extension --group-directories-first"
