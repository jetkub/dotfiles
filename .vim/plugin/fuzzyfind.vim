vim9script

if !has('patch-9.1.1329')
    finish
endif

var selected_match = null_string
var allfiles: list<string>

def GrepComplete(arglead: string, cmdline: string, cursorpos: number): list<any>
    if arglead->len() < 2 
        return []
    endif 

    var root = get(g:, 'grep_root', '.')

	if root == '.'
		var dangerous_dir = [$HOME, '/', '/Users', '/home', expand('~')]
		if index(dangerous_dir, getcwd()) >= 0
			return ['⚠️  CWD is ' .. getcwd() 
                .. ' - too broad. Use :cd first.']
	   	endif 
	endif

    if executable('rg')
        return systemlist($'rg --hidden --vimgrep'
            .. $' --max-depth 10 -S "{arglead}" {root} | head -200')
    else
        var cmd = $'grep -REIHnsi "{arglead}" --exclude-dir=.git'
            .. $' --exclude="tags" --exclude="*.swap" {root}'
        return systemlist(cmd)
    endif 
enddef

def VisitFile()
    if (selected_match != null_string)
        var qfitem = getqflist({lines: [selected_match]}).items[0]
        if qfitem->has_key('bufnr') && qfitem.lnum > 0
            var pos = qfitem.vcol > 0 ? 'setcharpos' : 'setpos'
            exec $':b +call\ {pos}(".",\ [0,\ {qfitem.lnum},\ {qfitem.col},\ 0]) {qfitem.bufnr}'
            setbufvar(qfitem.bufnr, '&buflisted', 1)
        endif
    endif
enddef

def FuzzyFind(arglead: string, _: string, _: number): list<string>
    if allfiles == null_list
        var root = get(g:, "fzfind_root", ".")
        if executable('rg')
            allfiles = systemlist($'rg --files {root}')
        else 
            var cmd = $'find {root}'
                .. ' \! \( -path "*/.git" -prune -o -name "*.swp" \)'
                .. ' -type f -follow'
            allfiles = systemlist(cmd)
        endif 
    endif
    return arglead == '' ? allfiles : allfiles->matchfuzzy(arglead)
enddef

def FuzzyBuffer(arglead: string, _: string, _: number): list<string>
    var bufs = execute('buffers', 'silent!')->split("\n")
    var altbuf = bufs->indexof((_, v) => v =~ '^\s*\d\+\s\+#')
    if altbuf != -1
        [bufs[0], bufs[altbuf]] = [bufs[altbuf], bufs[0]]
    endif
    return arglead == '' ? bufs : bufs->matchfuzzy(arglead)
enddef

def SelectItem()
    selected_match = ''
    if getcmdline() =~ '^\s*\%(Grep\|Find\|Buffer\)\s'
        var info = cmdcomplete_info()
        if info != {} && info.pum_visible && !info.matches->empty()
            selected_match = info.selected != -1 ? info.matches[info.selected] : info.matches[0]
            setcmdline(info.cmdline_orig) # Preserve search pattern in history
        endif
    endif
enddef

command! -nargs=+ -complete=customlist,GrepComplete Grep VisitFile()
command! -nargs=* -complete=customlist,FuzzyBuffer Buffer exe 'b ' .. selected_match->matchstr('\d\+')
command! -nargs=* -complete=customlist,FuzzyFind Find exe !empty(selected_match) ? $'e {selected_match}' : ''

nnoremap <leader>g :Grep<space>
nnoremap <leader>G :Grep <c-r>=expand("<cword>")<cr>
nnoremap <leader>gz :<c-r>=execute('let g:grep_root = "$HOME/.zshrc $HOME/.zshenv $HOME/.zprofile $HOME/.zsh/zsh_key_binds $HOME/.zsh/zsh_completions $HOME/.zsh/zsh_aliases"')\|''<cr>Grep<space>

nnoremap <leader><space> :<c-r>=execute('let fzfind_root="."')\|''<cr>Find<space><c-@>
nnoremap <leader>fv :<c-r>=execute('let fzfind_root="$HOME/.vim"')\|''<cr>Find<space><c-@>
nnoremap <leader>fV :<c-r>=execute('let fzfind_root="$VIMRUNTIME"')\|''<cr>Find<space><c-@>
nnoremap <leader><bs> :Buffer <c-@>

autocmd CmdlineEnter : allfiles = null_list | g:grep_root = '.'
autocmd CmdlineLeavePre : SelectItem() 
