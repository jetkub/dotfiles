"if v:version < 902
"    finish
"endif
vim9script

def InsComplete()
    if getcharstr(1) == '' && getline('.')->strpart(0, col('.') - 1) =~ '\k$'
        SkipTextChangedIEvent()
        feedkeys("\<c-n>", "n")
    endif
enddef

def SkipTextChangedIEvent(): string
    # Suppress next event caused by <c-e> (or <c-n> when no matches found)
    set eventignore+=TextChangedI
    timer_start(1, (_) => {
        set eventignore-=TextChangedI
    })
    return ''
enddef

def AcceptCompletion(): string 
    if pumvisible()
        SkipTextChangedIEvent()
        return "\<c-y>"
    else
        return "\<cr>"
    endif 
enddef 

autocmd TextChangedI * InsComplete()

inoremap <silent> <c-e> <c-r>=<SID>SkipTextChangedIEvent()<cr><c-e>
inoremap <expr> <cr> <SID>AcceptCompletion()
inoremap <expr> <Tab> pumvisible() ? "\<c-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<c-p>" : "\<S-Tab>")
