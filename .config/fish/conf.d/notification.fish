function command_notifier --on-event fish_postexec
    set -l exit_status $status
    if test $CMD_DURATION -lt 5000 # 5 seconds
        return
    end

    if test $exit_status -eq 0
        set icon '✅'
        set macos_sound Blow
    else
        set icon '❌'
        set macos_sound Basso
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

    switch (uname -s)
        case Darwin
            set title "$icon $cmd"
            set message "Finished with exit code $exit_status"

            osascript \
                -e 'on run argv' \
                -e 'set msg to item 1 of argv' \
                -e 'set ttl to item 2 of argv' \
                -e 'set soundName to item 3 of argv' \
                -e 'display notification msg with title ttl sound name soundName' \
                -e 'end run' \
                "$message" "$title" "$macos_sound"
            # osascript -e "display notification \"Finished with exit code $exit_status\" with title \"$icon $cmd\" sound name \"$macOS_sound\""
        case Linux
            if type -q notify-send
                notify-send "$icon $cmd" "Finished with exit code $exit_status"
            end
    end
end
