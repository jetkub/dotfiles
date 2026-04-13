"if v:version < 902
"    finish
"endif
vim9script

def CmdComplete()
    var [cmdline, curpos, cmdmode] = [getcmdline(), getcmdpos(), expand('<afile>') == ':']
    var trigger_char = '\%(\w\|[*/:.-]\)$'
    var not_trigger_char = '^\%(\d\|,\|+\|-\)\+$'
    if getchar(1, {number: true}) == 0 && !wildmenumode() && curpos == cmdline->len() + 1
            && (!cmdmode || (cmdline =~ trigger_char && cmdline !~ not_trigger_char))
        SkipCmdlineChanged()
        feedkeys("\<C-@>", "t")
        timer_start(0, (_) => getcmdline()->substitute('\%x00', '', 'ge')->setcmdline())
    endif
enddef

def SkipCmdlineChanged(key = ''): string
    set ei+=CmdlineChanged
    timer_start(0, (_) => execute('set ei-=CmdlineChanged'))
    return key == '' ? '' : ((wildmenumode() ? "\<C-E>" : '') .. key)
enddef

set wildmode=noselect:lastused,full wildoptions=pum wildcharm=<C-@> wildmenu

autocmd CmdlineChanged :,/,? CmdComplete()
cnoremap <expr> <Up> SkipCmdlineChanged("\<Up>")
cnoremap <expr> <Down> SkipCmdlineChanged("\<Down>")

# Optional: Customize popup height
autocmd CmdlineEnter : set belloff+=error | exec $'set pumheight={max([10, winheight(0) - 4])}'
autocmd CmdlineEnter /,? set belloff+=error pumheight=8
autocmd CmdlineLeave :,/,? set belloff-=error

