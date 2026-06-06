function command_notifier --on-event fish_postexec
    set -l exit_status $status
    if test $CMD_DURATION -lt 5000 # 5 seconds
        return
    end

    if test $exit_status -eq 0
        set icon '✅'
    else
        set icon '❌'
    end

    if test (count $argv) -gt 0
        set cmd $argv[1]
    else
        set cmd command
    end

    set -l ignore_commands cat less man vi nvim ssh claude "uvx ipython" "uv run --with ipython ipython"
    for ignore_cmd in $ignore_commands
        if string match -q "$ignore_cmd*" "$cmd"
            return
        end
    end

    if test -w /dev/tty
        set title "$icon $cmd"
        set message "Finished with exit code $exit_status"
        printf '\033]777;notify;%s;%s\033\a' "$title" "$message" >/dev/tty
    end
end
