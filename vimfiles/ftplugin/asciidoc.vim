" Note: no two line title support, only support one line titles
function! s:Toc()
    try
        silent lvimgrep /\(^=\+ \+.*\)/ %
    catch /E480/
        echom "Toc: No headers."
        return
    endtry

    vert lopen
    let &winwidth=(&columns/3)

    setlocal modifiable
    for i in range(1, line('$'))
        let d = getloclist(0)[i-1]
        let l:level = len(matchstr(d.text, '^=*', 'g')) - 1
        let d.text = substitute(d.text, '^=* *', '', '')
        call setline(i, repeat('  ', l:level). d.text)
    endfor
    setlocal nomodified
    setlocal nomodifiable
    normal! gg
endfunction

command! -buffer Toc call s:Toc()
