# Set neovim as standard editor
set -Ux EDITOR nvim

# Solarized for bobthefish theme
set -g theme_color_scheme nord

# Install fisher packages every start
if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
end

# After every cd command execute ll
function cd
    if count $argv > /dev/null
        builtin cd "$argv"; and ll
    else
        builtin cd ~; and ll
    end
end

# Fuck setup
thefuck --alias | source
