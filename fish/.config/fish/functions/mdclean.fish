
function mdclean
    set -l target_dir (test -n "$argv[1]"; and echo $argv[1]; or echo ".")

    if not test -f ~/.replace_rules.txt
        echo "❌ Rules file not found at ~/.replace_rules.txt"
        return 1
    end

    # File extensions to include
    set -l include_ext md txt markdown html js ts vue json css yml yaml xml

    # Folders to ignore
    set -l ignore_dirs node_modules .git dist build vendor __pycache__

    # File extensions to ignore (optional)
    set -l ignore_ext min.js lock bin exe jpg png svg ico pdf

    echo "📂 Cleaning Markdown/Text files in: $target_dir"
    echo ""

    for line in (cat ~/.replace_rules.txt)
        set find (string split "|" -- $line)[1]
        set replace (string split "|" -- $line)[2]

        if test -n "$find"
            set -l count 0

            for ext in $include_ext
                # Build grep exclude args
                set -l exclude_args
                for dir in $ignore_dirs
                    set -a exclude_args "--exclude-dir=$dir"
                end
                for ext_ignore in $ignore_ext
                    set -a exclude_args "--exclude=*.{$ext_ignore}"
                end

                # Count matches
                set -l result (grep -oR $exclude_args --include "*.$ext" "$find" "$target_dir" 2>/dev/null | wc -l | string trim)
                set count (math "$count + $result")
            end

            echo "🔁 [$find] → [$replace]: $count occurrence(s)"

            for ext in $include_ext
                for dir in $ignore_dirs
                    set -a prune_args -path "*/$dir" -prune -o
                end

                # Build and run find with pruning
                find $target_dir $prune_args -type f -name "*.$ext" -print | while read -l file
                    sed -i.bak "s|$find|$replace|g" "$file"
                end
            end
        end
    end

    find $target_dir -type f -name "*.bak" -delete

    echo ""
    echo "✅ mdclean complete!"
end
