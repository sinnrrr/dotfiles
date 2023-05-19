lvim_restore_session_for_curr_dir() {
    lvim +"lua require('persistence').load()" # pwd is current lf dir
}

lvim_restore_last_session() {
    lvim +"lua require('persistence').load({ last = true })"
}

_zinit_lvim() {
    zle -N lvim_restore_session_for_curr_dir
    bindkey -M emacs '^O' lvim_restore_session_for_curr_dir
    bindkey -M vicmd '^O' lvim_restore_session_for_curr_dir
    bindkey -M viins '^O' lvim_restore_session_for_curr_dir

    bindkey -r '^P'
    zle -N lvim_restore_last_session
    bindkey -M emacs '^P' lvim_restore_last_session
    bindkey -M vicmd '^P' lvim_restore_last_session
    bindkey -M viins '^P' lvim_restore_last_session
}
