"Vim global plugin for learn your english
"It can show the chinese when you write the english.
"It can check your answer.
"Last Change 2013-04-13
"Maintainer: Lijunjie <lijunjieone@gmail.com>
"License: This file is placed in the public domain.
"读取一个文件中的内容，转化为列表数据
"显示某一条数据到当前行中
"获取当前行数据跟列表中某条数据进行比较


"avoid load script twice
if exists("g:loaded_learneng")
    finish
endif
let g:loaded_learneng=1
"change the vim config at this script,but finish the script can revert the
"config

let s:save_cpo = &cpo
"let s:tmpfile="/tmp/my/2.txt"
set cpo&vim

if !hasmapto('<Plug>LearnengTest')
    map <unique> <Leader>l <Plug>LearnengTest
endif
noremap <unique> <script> <Plug>LearnengTest <SID>Test
noremap <SID>Test :call <SID>Test()<CR>

function s:Test3()
    let s:file_path=input("please input your file path:")
    "read file_path
    let s:cmd= "cat ". s:file_path ." | grep \"(\" | awk -F\"]\" '{print $2}' | awk -F\"(\" '{print $2,\"\", $1}' >" . s:tmpfile
    echo s:cmd
    "read s:tmpfile
endfunction

function s:Test()
    let input_str=input("please input your answer:")
    echo input_str
endfunction

let &cpo=s:save_cpo

