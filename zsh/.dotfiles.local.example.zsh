# Machine-local shell config. Copy to ~/.dotfiles.local.zsh and edit per machine:
#   cp zsh/.dotfiles.local.example.zsh ~/.dotfiles.local.zsh
# Only the copy in $HOME is sourced (by zsh/.zshrc); this example never runs.
# Rule of thumb: anything with a hostname, IP, volume, or username belongs here.

# --- Claude Code -> local Ollama (Anthropic-compatible API) ---
# Bare `claude` always uses the cloud; opt in to local with `cl` / `claude-pick`.
# MacBook (Ollama runs on the Mac Studio):
export CLAUDE_LOCAL_URL="http://studio-ai.local:11434"
# AISTUDIO (Ollama runs locally):
# export CLAUDE_LOCAL_URL="http://localhost:11434"
# Optional default model (claude-pick overrides it per run):
export CLAUDE_LOCAL_MODEL="gemma4:latest"

claude-local() {
  if [ -z "${CLAUDE_LOCAL_URL:-}" ]; then
    echo "claude-local: CLAUDE_LOCAL_URL is not set in ~/.dotfiles.local.zsh" >&2
    return 1
  fi
  local -a model_args
  model_args=()
  [ -n "${CLAUDE_LOCAL_MODEL:-}" ] && model_args=(--model "$CLAUDE_LOCAL_MODEL")
  ANTHROPIC_BASE_URL="$CLAUDE_LOCAL_URL" \
  ANTHROPIC_AUTH_TOKEN="ollama" \
  ANTHROPIC_API_KEY="" \
  CLAUDE_CODE_ATTRIBUTION_HEADER="0" \
    command claude "${model_args[@]}" "$@"
}

claude-pick() {
  if [ -z "${CLAUDE_LOCAL_URL:-}" ]; then
    echo "claude-pick: CLAUDE_LOCAL_URL is not set in ~/.dotfiles.local.zsh" >&2
    return 1
  fi
  local tags model
  tags="$(curl -fsS --max-time 5 "${CLAUDE_LOCAL_URL%/}/api/tags")" || {
    echo "claude-pick: cannot reach ${CLAUDE_LOCAL_URL} (is Ollama running?)" >&2
    return 1
  }
  model="$(printf '%s' "$tags" \
    | command grep -o '"name":"[^"]*"' \
    | sed 's/^"name":"//;s/"$//' \
    | fzf --prompt='model> ')"
  [ -z "$model" ] && return 0
  CLAUDE_LOCAL_MODEL="$model" claude-local "$@"
}

alias cl='claude-local'

# --- AISTUDIO only: Ollama model storage on the external volume ---
# export OLLAMA_MODELS="/Volumes/AISTORE/ollama/models"

# --- MacBook only: Android SDK / Java for Expo Android preview ---
# Pin JDK 21 — Gradle 8.x + AGP + RN work reliably here; JDK 25 often triggers
# "Unsupported class file major version 69" during Gradle semantic analysis.
# export JAVA_HOME="/opt/homebrew/opt/openjdk@21/libexec/openjdk.jdk/Contents/Home"
# export ANDROID_HOME="$HOME/Library/Android/sdk"
# export ANDROID_SDK_ROOT="$ANDROID_HOME"
# export PATH="$JAVA_HOME/bin:$ANDROID_HOME/platform-tools:$ANDROID_HOME/emulator:$ANDROID_HOME/cmdline-tools/latest/bin:$PATH"
