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

"// clang-format off
"static constexpr int kLogSeverityToKernelLogLevel[] = {
"[android::base::VERBOSE]             = 7, // KERN_DEBUG   (there is no verbose kernel log level)
"[android::base::DEBUG]               = 7, // KERN_DEBUG
"[android::base::INFO]                = 6, // KERN_INFO
"[android::base::WARNING]             = 4, // KERN_WARNING
"[android::base::ERROR]               = 3, // KERN_ERROR
"[android::base::FATAL_WITHOUT_ABORT] = 2, // KERN_CRIT
"[android::base::FATAL]               = 2, // KERN_CRIT
"};
"
"#define KERN_EMERG    "<0>"    /* system is unusable */
"#define KERN_ALERT    "<1>"    /* action must be taken immediately */
"#define KERN_CRIT     "<2>"    /* critical conditions */
"#define KERN_ERR      "<3>"    /* error conditions */
"#define KERN_WARNING  "<4>"    /* warning conditions */
"#define KERN_NOTICE   "<5>"    /* normal but significant */
"#define KERN_INFO     "<6>"    /* informational */
"#define KERN_DEBUG    "<7>"    /* debug-level messages */
"
"/* Facilities are currently ignored on Android. */
"#define LOG_KERN     0000   // kernel log level
"#define LOG_USER     0010   // init log level
"#define LOG_MAIL     0020
"#define LOG_DAEMON   0030
"#define LOG_AUTH     0040   // avc log level
"#define LOG_SYSLOG   0050
"#define LOG_LPR      0060
"#define LOG_NEWS     0070
"#define LOG_UUCP     0100
"#define LOG_CRON     0110
"#define LOG_AUTHPRIV 0120
"#define LOG_FTP      0130
"#define LOG_LOCAL0   0200
"#define LOG_LOCAL1   0210
"#define LOG_LOCAL2   0220
"#define LOG_LOCAL3   0230
"#define LOG_LOCAL4   0240
"#define LOG_LOCAL5   0250
"#define LOG_LOCAL6   0260
"#define LOG_LOCAL7   0270

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
        highlight    default   logLevel_7_DEBUG     guifg=Gray         ctermfg=Gray
        "highlight   default   logLevel_6_INFO      guifg=Cyan         ctermfg=Cyan
        highlight    default   logLevel_5_NOTICE    guifg=Green        ctermfg=Green
        highlight    default   logLevel_4_WARNING   guifg=Yellow       ctermfg=Yellow
        highlight    default   logLevel_3_ERR       guifg=Red          ctermfg=Red
    else
        highlight    default   logLevel_7_DEBUG     guifg=DarkGray     ctermfg=DarkGray
        "highlight   default   logLevel_6_INFO      guifg=DarkCyan     ctermfg=DarkCyan
        highlight    default   logLevel_5_NOTICE    guifg=DarkGreen    ctermfg=DarkGreen
        highlight    default   logLevel_4_WARNING   guifg=DarkYellow   ctermfg=DarkYellow
        highlight    default   logLevel_3_ERR       guifg=DarkRed      ctermfg=DarkRed
    endif
    highlight   default   logLevel_2_CRIT    guifg=White   ctermfg=White   guibg=Red   ctermbg=Red
    highlight   default   logLevel_1_ALERT   guifg=White   ctermfg=White   guibg=Red   ctermbg=Red
    highlight   default   logLevel_0_EMERG   guifg=White   ctermfg=White   guibg=Red   ctermbg=Red
endfunction

syntax match logTag '^<\d.\{-}>' contained
syntax cluster logItem add=logTag
highlight default link logTag Tag

syntax match logTime "\[[0-9\. ]\{-}\]" contained
syntax cluster logItem add=logTime
highlight default link logTime logLevel_5_NOTICE

function! s:define_level(pattern, facility)
    for s:level in s:levels
        let s:pri = s:level[1] + a:facility
        "echo s:pri
        "echo printf('syntax match logLevel%s @%s@ contains=@logItem',
                    "\              s:level, printf(a:pattern, s:pri))
        execute printf('syntax match logLevel%s @%s@ contains=@logItem',
                    \              s:level, printf(a:pattern, s:pri))
    endfor
endfunction

for i in range(0, 56, 8)
    call s:define_level('^<%s>.*$', i)
endfor

call s:define_color()
augroup syntax-dmesg
    autocmd! ColorScheme * call s:define_color()
augroup END

let b:current_syntax = 'dmesg'

let &cpo = s:cpo_save
unlet s:cpo_save

finish
