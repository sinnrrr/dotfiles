codi() {
    local syntax="${1:-python}"
    lvim -c \
        "set bt=nofile ls=0 noru nonu nornu |\
    hi ColorColumn ctermbg=NONE |\
    hi VertSplit ctermbg=NONE |\
    hi NonText ctermfg=0 |\
        Codi $syntax" "$@"
}
