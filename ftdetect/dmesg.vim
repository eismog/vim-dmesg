" Language: dmesg log
" Author : eismog <eismog@163.com>
" License: zlib License

autocmd BufReadPost,BufNewFile *.dmesg setlocal filetype=dmesg
autocmd BufReadPost,BufNewFile *dmesg* setlocal filetype=dmesg

autocmd BufReadPost,BufNewFile *.kmsg setlocal filetype=dmesg
autocmd BufReadPost,BufNewFile *kmsg* setlocal filetype=dmesg

autocmd BufReadPost,BufNewFile * for i in range(1, 33)
\                                   |if getline(i) =~# '^<.\{-}Initializing cgroup subsys cpu.*$'
\                                       |set filetype=dmesg
\                                   |endif
\                               |endfor
