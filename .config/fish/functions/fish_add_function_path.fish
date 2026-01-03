function fish_add_function_path --description 'Safe addition to fish_function_path'
    if test -d $argv[1]
        if not contains $argv[1] $fish_function_path
            set -gp fish_function_path $argv[1]
        end
    end
end
