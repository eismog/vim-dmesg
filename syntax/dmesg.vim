" Vim syntax file
" Language: dmesg log
" Version: 0.0.1
" Author : eismog <eismog@163.com>
" License: zlib License

if exists("b:current_syntax")
  finish
endif

let s:cpo_save = &cpo
set cpo&vim

"#define KERN_EMERG    "<0>"    /* system is unusable */
"#define KERN_ALERT    "<1>"    /* action must be taken immediately */
"#define KERN_CRIT     "<2>"    /* critical conditions */
"#define KERN_ERR      "<3>"    /* error conditions */
"#define KERN_WARNING  "<4>"    /* warning conditions */
"#define KERN_NOTICE   "<5>"    /* normal but significant */
"#define KERN_INFO     "<6>"    /* informational */
"#define KERN_DEBUG    "<7>"    /* debug-level messages */

let s:levels = [
\   '_0_EMERG',
\   '_1_ALERT',
\   '_2_CRIT',
\   '_3_ERR',
\   '_4_WARNING',
\   '_5_NOTICE',
\   '_6_INFO',
\   '_7_DEBUG',
\ ]

function! s:define_color()
    if &background is 'dark'
        highlight   default   logLevel_7_DEBUG     guifg=Gray         ctermfg=Gray
        "highlight   default   logLevel_6_INFO      guifg=Cyan         ctermfg=Cyan
        highlight   default   logLevel_5_NOTICE    guifg=Green        ctermfg=Green
        highlight   default   logLevel_4_WARNING   guifg=Yellow       ctermfg=Yellow
        highlight   default   logLevel_3_ERR       guifg=Red          ctermfg=Red
    else
        highlight   default   logLevel_7_DEBUG     guifg=DarkGray     ctermfg=DarkGray
        "highlight   default   logLevel_6_INFO      guifg=DarkCyan     ctermfg=DarkCyan
        highlight   default   logLevel_5_NOTICE    guifg=DarkGreen    ctermfg=DarkGreen
        highlight   default   logLevel_4_WARNING   guifg=DarkYellow   ctermfg=DarkYellow
        highlight   default   logLevel_3_ERR       guifg=DarkRed      ctermfg=DarkRed
    endif
    highlight   default   logLevel_2_CRIT      guifg=White        ctermfg=White        guibg=Red   ctermbg=Red
    highlight   default   logLevel_1_ALERT     guifg=White        ctermfg=White        guibg=Red   ctermbg=Red
    highlight   default   logLevel_0_EMERG     guifg=White        ctermfg=White        guibg=Red   ctermbg=Red
endfunction

highlight default link logTag Tag
highlight default link logTime logLevel_5_NOTICE

function! s:define_level(pattern)
  for level in s:levels
    execute printf('syntax match logLevel%s @%s@ contains=@logItem',
    \              level, printf(a:pattern, level[1]))
  endfor
endfunction

call s:define_level('^<%s>.*$')
syntax match logTag '^<\d>' contained
syntax match logTime '\[[0-9\. ]\+\]' contained
syntax cluster logItem add=logTag
syntax cluster logItem add=logTime

call s:define_color()
augroup syntax-dmesg
  autocmd! ColorScheme * call s:define_color()
augroup END

let b:current_syntax = 'dmesg'

let &cpo = s:cpo_save
unlet s:cpo_save

finish
