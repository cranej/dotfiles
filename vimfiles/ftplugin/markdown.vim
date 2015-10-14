function! s:Toc(...)
    try
        silent lvimgrep /\(^\S.*\(\n[=-]\+\n\)\@=\|^#\+\)/ %
    catch /E480/
        echom "Toc: No headers."
        return
    endtry

    vertical lopen
    let &winwidth=(&columns/3)

    setlocal modifiable
    for i in range(1, line('$'))
        " this is the location-list data for the current item
        let d = getloclist(0)[i-1]
        " atx headers
        if match(d.text, "^#") > -1
            let l:level = len(matchstr(d.text, '#*', 'g'))-1
            let d.text = substitute(d.text, '\v^#*[ ]*', '', '')
            let d.text = substitute(d.text, '\v[ ]*#*$', '', '')
            " setex headers
        else
            let l:next_line = getbufline(bufname(d.bufnr), d.lnum+1)
            if match(l:next_line, "=") > -1
                let l:level = 0
            elseif match(l:next_line, "-") > -1
                let l:level = 1
            endif
        endif
        call setline(i, repeat('  ', l:level). d.text)
    endfor
    setlocal nomodified
    setlocal nomodifiable
    normal! gg
endfunction

command! -buffer Toc call s:Toc()
