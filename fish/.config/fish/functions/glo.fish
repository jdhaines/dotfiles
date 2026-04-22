function glo
    set count 10
    if test (count $argv) -gt 0
        set count $argv[1]
    end

    git log \
        --graph \
        --pretty=format:'%C(auto)%h %C(blue)%ad %C(reset)%s %C(green)(%an)%C(auto)%d' \
        --date=short \
        -n $count
end
