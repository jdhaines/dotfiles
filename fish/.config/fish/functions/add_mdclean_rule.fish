function add_mdclean_rule
    if test (count $argv) -ne 2
        echo "Usage: add_mdclean_rule 'find' 'replace'"
        return 1
    end

    echo "$argv[1]|$argv[2]" >>~/.replace_rules.txt
    echo "✅ Rule added: '$argv[1]' → '$argv[2]'"
end
