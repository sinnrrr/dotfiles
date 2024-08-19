# sudo mkdir /opt/hack_path
# sudo ln -s /bin/date /opt/hack_path/date
export PATH="/opt/hack_path:$PATH"
export EE_DOCKER_BUILD_ARCH="linux/arm64"

# The next line updates PATH for the Google Cloud SDK.
# if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/google-cloud-sdk/path.zsh.inc"; fi
# The next line enables shell command completion for gcloud.
# if [ -f '/Users/nickyasnogorodskyi/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/nickyasnogorodskyi/google-cloud-sdk/completion.zsh.inc'; fi

apisec_topics=("web-api-data-discovered.v2" "web-api-entity-proccessed.v2" "web-api-entity-enriched.v2")

pick_apisec_topic() {
    printf "$ORCA_ENV.apisec.%s\n" "${apisec_topics[@]}" | fzf --header "Pick topic"
}


orca_kafka() {
    _usage() {
        printf "
    Usage:
      orca_kafka [ARGS]

    [ARGS]:
      -t <name>       specify full topic name
      -p <filepath>   produce kafka messages from a file
      -d              drop topic
      -c <count>     consume from kafka, specify 0 to consume all
      -h              show help
        \n"
    }
    if [[ $# -eq 0 ]] ; then
        _usage
        return 1
    fi

    while getopts 'dp:t:hc:' flag; do
        case $flag in
            p)
                local messages_file="${OPTARG}" ;;
            c)
                local consume_mode=true
                local consume_count="${OPTARG}"
                ;;
            d)
                local clean_topic=true ;;
            t)
                local topic="${OPTARG}" ;;
            h)
                _usage
                return 1 ;;
            *)
                _usage
                return 1 ;;
        esac
    done

    if [ "$clean_topic" = true ]; then
        kafkactl delete topic "$topic"
    fi

    if [ -z "$topic" ]; then
        echo "Specify topic name: -t <name>"
        return 1
    fi
    kafkactl create topic "$topic"

    if [ -n "$messages_file" ]; then
        kcat -b kafka:9092 -P -t "$topic" -l "$messages_file"
    fi

    if [ "$consume_mode" = true ]; then
        kcat -b kafka:9092 -C -t "$topic" -c$consume_count
    fi
}

# zinit id-as"work" wait lucid nocompile \
    #     atload="if [ -f  "${SRC_ROOT}/cli/op/shell_rc/bashrc" ]; then source "${SRC_ROOT}/cli/op/shell_rc/bashrc" >/dev/null 2>&1; fi" for \
    #     zdharma-continuum/null
