#!/bin/bash

USERNAME="${1}"

# Check and add to ~/.bashrc
if ! grep -q "__bash_prompt" ~/.bashrc; then
    cat >> ~/.bashrc << 'EOF'

# Custom bash prompt theme
__bash_prompt() {
    local userpart='`export XIT=$? \
        && [ ! -z "${GITHUB_USER:-}" ] && echo -n "\[\033[0;31m\]@${GITHUB_USER:-} " || echo -n "\[\033[0;31m\]__USERNAME_PLACEHOLDER__ " \
        && [ "$XIT" -ne "0" ] && echo -n "\[\033[1;31m\]➜" || echo -n "\[\033[0m\]➜"`'
    local gitbranch='`\
        if [ "$(git config --get devcontainers-theme.hide-status 2>/dev/null)" != 1 ] && [ "$(git config --get codespaces-theme.hide-status 2>/dev/null)" != 1 ]; then \
            export BRANCH="$(git --no-optional-locks symbolic-ref --short HEAD 2>/dev/null || git --no-optional-locks rev-parse --short HEAD 2>/dev/null)"; \
            if [ "${BRANCH:-}" != "" ]; then \
                echo -n "\[\033[1;33m\](\[\033[1;33m\]${BRANCH:-}" \
                && if [ "$(git config --get devcontainers-theme.show-dirty 2>/dev/null)" = 1 ] && \
                    git --no-optional-locks ls-files --error-unmatch -m --directory --no-empty-directory -o --exclude-standard ":/*" > /dev/null 2>&1; then \
                        echo -n " \[\033[1;33m\]✗"; \
                fi \
                && echo -n "\[\033[1;33m\]) "; \
            fi; \
        fi`'
    local color='\[\033[1;35m\]'
    local removecolor='\[\033[0m\]'
    PS1="${userpart} ${color}\w ${gitbranch}${removecolor}\$ "
    unset -f __bash_prompt
}
__bash_prompt
export PROMPT_DIRTRIM=4
EOF

# Replace placeholder with actual username
sed -i "s|__USERNAME_PLACEHOLDER__|${USERNAME}|g" ~/.bashrc
fi