#!/bin/bash
set -euo pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "$0")" && pwd)
DOTFILES_ROOT=$(cd -- "$SCRIPT_DIR/.." && pwd)

profile=${DOTFILES_HOST_PROFILE:-}
if [ -z "$profile" ]; then
  case "$(uname -s)" in
    Darwin) profile=macbook-pro ;;
    Linux) profile=ufam-notebook ;;
    *) echo "Unsupported host; set DOTFILES_HOST_PROFILE explicitly." >&2; exit 1 ;;
  esac
fi

case "$profile" in
  macbook-pro|ufam-notebook) ;;
  *) echo "Unknown DOTFILES_HOST_PROFILE: $profile" >&2; exit 1 ;;
esac

target_root="${XDG_CONFIG_HOME:-$HOME/.config}/opencode"
backup_root="$HOME/.cache/dotfiles/opencode-backups/$(date +%Y%m%d-%H%M%S)"
mkdir -p "$target_root"
updated=0

link_tree() {
  local source_root=$1
  [ -d "$source_root" ] || return 0

  while IFS= read -r -d '' source; do
    local relative=${source#"$source_root"/}
    local destination="$target_root/$relative"
    local existing
    mkdir -p "$(dirname -- "$destination")"

    if [ -L "$destination" ]; then
      existing=$(readlink "$destination")
      if [ "$existing" = "$source" ]; then
        continue
      fi
      local backup="$backup_root/$relative"
      mkdir -p "$(dirname -- "$backup")"
      cp -pP "$destination" "$backup"
    elif [ -e "$destination" ]; then
      if [ -d "$destination" ]; then
        echo "Refusing to replace directory with file: $destination" >&2
        return 1
      fi
      local backup="$backup_root/$relative"
      mkdir -p "$(dirname -- "$backup")"
      cp -p "$destination" "$backup"
    fi

    ln -sfn "$source" "$destination"
    updated=$((updated + 1))
  done < <(find "$source_root" -type f ! -path '*/node_modules/*' -print0)
}

link_tree "$DOTFILES_ROOT/dotconfig/opencode/common"
link_tree "$DOTFILES_ROOT/dotconfig/opencode/$profile"

echo "Installed global OpenCode preferences for '$profile' into $target_root."
echo "Updated $updated file link(s); replaced files were backed up under $backup_root."
