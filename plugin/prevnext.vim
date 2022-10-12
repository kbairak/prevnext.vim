if exists("g:turboprevnext_loaded")
    finish
endif
let g:turboprevnext_loaded = 1

function s:move(step)
    let l:head = expand('%:h')
    let l:tail = expand('%:t')
    let l:ls = systemlist("find " . l:head . " -maxdepth 1 -type f -printf '%f\n' | sort")
    let l:place = index(l:ls, l:tail)
    let l:new_place = l:place + a:step
    if l:new_place < 0
        let l:new_place = len(l:ls) - 1
    endif
    if l:new_place >= len(l:ls)
        let l:new_place = 0
    endif
    let l:new_tail = l:ls[l:new_place]
    execute 'edit ' . l:head . '/' . l:new_tail
endfunction

function s:next()
    call s:move(1)
endfunction

function s:prev()
    call s:move(-1)
endfunction

command TurboNext call s:next()
command TurboPrev call s:prev()

if !hasmapto('TurboNext')
    noremap <Leader>] :TurboNext<CR>
endif
if !hasmapto('TurboPrev')
    noremap <Leader>[ :TurboPrev<CR>
endif
