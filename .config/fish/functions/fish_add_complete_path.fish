function fish_add_complete_path --description 'Safe addition to fish_complete_path'
    if test -d $argv[1]
        if not contains $argv[1] $fish_complete_path
            set -gp fish_complete_path $argv[1]
        end
    end
end
