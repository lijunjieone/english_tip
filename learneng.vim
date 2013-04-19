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
let s:tmpfile="/tmp/my/2.txt"
let s:index=0
set cpo&vim

if !hasmapto('<Plug>LearnengTest')
    map <unique> <Leader>l <Plug>LearnengMain
    map <unique> <Leader>lq <Plug>LearnengReadQuestion
    map <unique> <Leader>la <Plug>LearnengReadAnswer
    map <unique> <Leader>lf <Plug>LearnengReadAnswerAndQuestion
endif
noremap <unique> <script> <Plug>LearnengMain <SID>Main
noremap <SID>Main :call <SID>Main()<CR>

noremap <unique> <script> <Plug>LearnengReadQuestion <SID>ReadQuestion
noremap <SID>ReadQuestion :call <SID>ReadQuestion()<CR>
noremap <unique> <script> <Plug>LearnengReadAnswer <SID>ReadAnswer
noremap <SID>ReadAnswer :call <SID>ReadAnswer()<CR>

noremap <unique> <script> <Plug>LearnengReadAnswerAndQuestion <SID>ReadAnswerAndQuestion
noremap <SID>ReadAnswerAndQuestion :call <SID>ReadAnswerAndQuestion()<CR>


function s:Main()
    let l:file_path=input("please input your file path:")
    let s:mycontent=GetContentList(l:file_path)
    "echo s:mycontent
endf

func s:ReadAnswerAndQuestion()
    let line=line(".")
    echo line
    call setline(line+1,s:mycontent[s:index][1])
    call setline(line+2,s:mycontent[s:index+1][2])
    let s:index=s:index+1
    "echo s:index
endf

function s:ReadQuestion()
    call setline(".",s:mycontent[s:index][2])
    let s:index=s:index+1
endf
func s:ReadAnswer()
    call setline(".",s:mycontent[s:index-1][1])
endf


function GetContentList(file_path)

    let l:content=ReadFile(a:file_path)
    "let l:content=ReadFile("/tmp/my/2.lrc")
    let l:content_list=split(l:content,"\n")
    let l:result_list=[]
    let l:index=0
    while l:index<len(l:content_list)
        let l:item=l:content_list[l:index]
        "echo l:item
        let l:tmp=MySplit2(l:item)
        "echo l:tmp
        " l:result_list[l:index]=l:tmp
        call add(result_list,l:tmp)
        let l:index=l:index+1
    endwhile
    "echo l:result_list

    return l:result_list
endfunction

func MySplit2(content)
    "echo a:content
    "echo type(a:content)
    let l:good_content=split(a:content,"]")
    "echo l:good_content
    if   type(l:good_content)!=3 || len(l:good_content)==1
        return [0,"",""]
    endif
    "echo "good_content",good_content,type(good_content)
    let good_word=l:good_content[1]
    "echo good_word
    let words=split(good_word,"(")
    let first_word=string(words[0:-2])
    let second_word=words[-1]
    "echo first_word
    "echo second_word
    return [1,first_word,second_word]
endf

   

function s:Test2()
    let s:file_path=input("please input your file path:")
    "echo s:file_path
    "read file_path
    "let s:cmd= " !cat ". s:file_path ." | grep \"(\" | awk -F\"]\" '{print $2}' | awk -F\"(\" '{print $2,\"\", $1}' >" . s:tmpfile
    "echo s:cmd
    "exe s:cmd
    "let s:cmd_test=" !ls > /tmp/my/3.txt"
    "exe s:cmd_test
    "echo s:tmpfile
    "read /tmp/my/2.txt
    "call Myread("/tmp/my/2.txt",3)
    "call ReadFileToVariable()
    "let l:content=ReadFile("/tmp/my/2.txt")
    let l:content=ReadFile(s:file_path)
    let l:content_list=split(l:content,"\n")
    let l:index =0
    while l:index<len(l:content_list)

        let l:item=l:content_list[l:index]
        "echo l:item
        "echo l:index
        "call MySplit(l:item)

        if l:index==10
            call setline(l:index,l:item)
            "call MySplit(l:item)
            "echo l:item
            "if mylist[0]
               "call setline(l:index,mylist[2])
               "let l:index=l:index+1
               "call setline(l:index,mylist[1])
            "endif
        else
            call setline(l:index,l:item)
        endif
        let l:index = l:index + 1
    endwhile
        

    "call setline(".",l:content_list)

endfunction
func MySplit(content)
    echo a:content
endf

function Myread(filename,linenumber)
    let l:cmd="r! sed -n ".a:linenumber.",".a:linenumber."p ".a:filename
    echo l:cmd
    let l:text=exe l:cmd
endfunction

function MyCurrentLine()
    echo getline(".")
endf

func ReadFile(filename)
    let l:content=system("cat ".a:filename)
    "echo l:content
    return l:content
endf
func ReadFileToVariable()
    let a=system("cat /tmp/my/1.lrc")
    echo a
endf

function s:Test3()
    let input_str=input("please input your answer:")
    echo input_str
endfunction

let &cpo=s:save_cpo

