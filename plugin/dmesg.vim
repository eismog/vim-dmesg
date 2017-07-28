" Trivial utility for dmesg.
" Version: 0.0.1
" Author : eismog <eismog@163.com>
" License: zlib License

if exists('g:loaded_dmesg')
  finish
endif
let g:loaded_dmesg = 1

let s:save_cpo = &cpo
set cpo&vim

if globpath(&runtimepath, 'plugin/vimshell.vim') !=# ''
  command! -nargs=* -bang AdbDmesg execute <bang>0 ? 'AdbDmesgClear' : ''
  \        | VimShellInteractive --encoding=utf-8 adb shell dmesg -r <args>
endif

if globpath(&runtimepath, 'autoload/vimproc.vim') != ''
  command! -nargs=0 LogcatClear VimProcBang adb shell dmesg -c
else
  command! -nargs=0 LogcatClear !adb shell dmesg -c
endif

let &cpo = s:save_cpo
unlet s:save_cpo
