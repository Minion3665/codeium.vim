let s:language_enum = {
      \ 'unspecified': 0,
      \ 'c': 1,
      \ 'clojure': 2,
      \ 'coffeescript': 3,
      \ 'cpp': 4,
      \ 'csharp': 5,
      \ 'css': 6,
      \ 'cudacpp': 7,
      \ 'dockerfile': 8,
      \ 'go': 9,
      \ 'groovy': 10,
      \ 'handlebars': 11,
      \ 'haskell': 12,
      \ 'hcl': 13,
      \ 'html': 14,
      \ 'ini': 15,
      \ 'java': 16,
      \ 'javascript': 17,
      \ 'json': 18,
      \ 'julia': 19,
      \ 'kotlin': 20,
      \ 'latex': 21,
      \ 'less': 22,
      \ 'lua': 23,
      \ 'makefile': 24,
      \ 'markdown': 25,
      \ 'objectivec': 26,
      \ 'objectivecpp': 27,
      \ 'perl': 28,
      \ 'php': 29,
      \ 'plaintext': 30,
      \ 'protobuf': 31,
      \ 'pbtxt': 32,
      \ 'python': 33,
      \ 'r': 34,
      \ 'ruby': 35,
      \ 'rust': 36,
      \ 'sass': 37,
      \ 'scala': 38,
      \ 'scss': 39,
      \ 'shell': 40,
      \ 'sql': 41,
      \ 'starlark': 42,
      \ 'swift': 43,
      \ 'tsx': 44,
      \ 'typescript': 45,
      \ 'visualbasic': 46,
      \ 'vue': 47,
      \ 'xml': 48,
      \ 'xsl': 49,
      \ 'yaml': 50,
      \ 'svelte': 51,
      \ }

let s:filetype_aliases = {
      \ 'bash': 'shell',
      \ 'coffee': 'coffeescript',
      \ 'cs': 'csharp',
      \ 'cuda': 'cudacpp',
      \ 'dosini': 'ini',
      \ 'make': 'makefile',
      \ 'objc': 'objectivec',
      \ 'objcpp': 'objectivecpp',
      \ 'proto': 'protobuf',
      \ 'raku': 'perl',
      \ 'sh': 'shell',
      \ 'text': 'plaintext',
      \ }

function! codeium#doc#GetCurrentDocument() abort
  let lines = getline(1, '$')
  if &endofline
    call add(lines, '')
  endif

  let filetype = substitute(&filetype, '\..*', '', '')
  let language = get(s:filetype_aliases, empty(filetype) ? 'text' : filetype, filetype)

  let doc = {
        \ 'text': join(lines, codeium#util#LineEndingChars()),
        \ 'editor_language': &filetype,
        \ 'language': get(s:language_enum, language, 0),
        \ 'cursor_offset': codeium#util#PositionToOffset('.', '.'),
        \ }

  let line_ending = codeium#util#LineEndingChars(v:null)
  if line_ending isnot# v:null
    let doc.line_ending = line_ending
  endif

  return doc
endfunction

function! codeium#doc#GetEditorOptions() abort
  return {
      \ 'tab_size': shiftwidth(),
      \ 'insert_spaces': &expandtab ? v:true : v:false,
      \ }
endfunction
