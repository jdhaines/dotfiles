#!/usr/bin/env bash
set -euo pipefail

RULES_FILE="${HOME}/.replace_rules.txt"
TARGET_DIR="."
DRY_RUN=false

# Parse arguments
while [[ $# -gt 0 ]]; do
  case "$1" in
  -d | --dry-run)
    DRY_RUN=true
    shift
    ;;
  -*)
    echo "❌ Unknown option: $1"
    exit 1
    ;;
  *)
    TARGET_DIR="$1"
    shift
    ;;
  esac
done

INCLUDE_EXT=("md" "markdown" "txt" "html" "js" "ts" "vue" "json" "css" "yml" "yaml" "xml")
IGNORE_DIRS=("node_modules" ".git" "dist" "build" "__pycache__" ".cache" "cache" ".temp")
IGNORE_EXT=("lock" "min.js" "bin" "exe" "jpg" "png" "svg" "ico" "pdf")

CHANGED_FILES=()

if [[ ! -f "$RULES_FILE" ]]; then
  echo "❌ Rules file not found: $RULES_FILE"
  exit 1
fi

echo -e "📂 Cleaning Markdown/Text in: \033[1m$TARGET_DIR\033[0m"
$DRY_RUN && echo "🔍 Running in dry-run mode (no files will be modified)"
echo ""

while IFS= read -r rule || [[ -n "$rule" ]]; do
  [[ -z "$rule" || "$rule" =~ ^# ]] && continue

  IFS='|' read -r FIND REPLACE <<<"$rule"

  echo "🔁 [$FIND → $REPLACE]..."

  TOTAL_MATCHES=0
  MODIFIED_FILES=()

  for ext in "${INCLUDE_EXT[@]}"; do
    # Build find command with prune for ignored dirs
    FIND_CMD=(find "$TARGET_DIR")
    for dir in "${IGNORE_DIRS[@]}"; do
      FIND_CMD+=(-path "*/$dir" -prune -o)
    done
    FIND_CMD+=(-type f -name "*.$ext" -print)

    # Execute find and iterate files
    mapfile -t FILES < <("${FIND_CMD[@]}")

    for file in "${FILES[@]}"; do
      for ign in "${IGNORE_EXT[@]}"; do
        [[ "$file" == *.$ign ]] && continue 2
      done

      MATCHES=$(grep -o "$FIND" "$file" 2>/dev/null | wc -l | tr -d '[:space:]' || true)
      [[ "$MATCHES" -gt 0 ]] || continue

      if [[ "$DRY_RUN" == true ]]; then
        echo "  Would replace $MATCHES × [$FIND] in $file"
      else
        sed -i.bak "s|$FIND|$REPLACE|g" "$file"
        rm "$file.bak"
      fi

      TOTAL_MATCHES=$((TOTAL_MATCHES + MATCHES))
      MODIFIED_FILES+=("$file")
      CHANGED_FILES+=("$file")
    done
  done

  echo "  → $TOTAL_MATCHES changes in ${#MODIFIED_FILES[@]} file(s)"
done <"$RULES_FILE"

# Unique file list
UNIQUE_CHANGED=($(printf "%s\n" "${CHANGED_FILES[@]}" | sort -u))

echo ""
$DRY_RUN && echo -e "🟡 \033[1mdry-run complete:\033[0m ${#UNIQUE_CHANGED[@]} file(s) would be updated." ||
  echo -e "✅ \033[1mmdclean complete:\033[0m ${#UNIQUE_CHANGED[@]} file(s) updated."

# Show file list if gum is installed and user agrees
if command -v gum &>/dev/null && gum confirm "Show list of changed files?"; then
  for f in "${UNIQUE_CHANGED[@]}"; do
    echo " • $f"
  done
fi
