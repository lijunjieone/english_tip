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

if !hasmapto('<Plug>LearnengMain')
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


func s:Main()
    let l:file_path=input("please input your file path:")
    let s:mycontent=GetContentList(l:file_path)
    "echo s:mycontent
endf

func s:ReadAnswerAndQuestion()
    let line=line(".")
    "echo line
    if line == 1
        call setline(line,s:mycontent[s:index][2])
    else
        call setline(line+1,s:mycontent[s:index][1])
        call setline(line+2,s:mycontent[s:index+1][2])
        let s:index=s:index+1
    endif
    "echo s:index
endf

func s:ReadQuestion()
    call setline(".",s:mycontent[s:index][2])
    let s:index=s:index+1
endf
func s:ReadAnswer()
    call setline(".",s:mycontent[s:index-1][1])
endf


func GetContentList(file_path)

    let l:content=ReadFile(a:file_path)
    "let l:content=ReadFile("/tmp/my/2.lrc")
    let l:content_list=split(l:content,"\n")
    let l:result_list=[]
    let l:index=0
    while l:index<len(l:content_list)
        let l:item=l:content_list[l:index]
        "echo l:item
        let l:tmp=MySplit(l:item)
        "echo l:tmp
        " l:result_list[l:index]=l:tmp
        call add(result_list,l:tmp)
        let l:index=l:index+1
    endwhile
    "echo l:result_list

    return l:result_list
endfunc

func MySplit(content)
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

   



func ReadFile(filename)
    let l:content=system("cat ".a:filename)
    "echo l:content
    return l:content
endf

let &cpo=s:save_cpo

