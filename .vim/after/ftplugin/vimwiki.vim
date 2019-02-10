nnoremap <leader>nc :set conceallevel=0<cr>
nnoremap <leader>nem :split ~/.vim/after/ftplugin/vimwiki.vim<cr>/mappings<cr>n/"<cr>n

set timeoutlen=500

let mappings = "
\:¬ not no
\:∧ and an
\:∨ or
\:⊕ exclusiveor xor
\:⊩ modelof model mod
\:⊨ consequence conseq cons therefore tf
\:⊭ notconsequence nconseq ncons nottherefore ntf
\:⊦ derived dvd dv
\:∀ forall fa
\:∀x∈ forallxin faxin
\:∃ exists te
\:∃x∈ existsxin texin
\:∄ notexists nexists nte nex
\:∈ belongsto bt in
\:∉ notbelongsto nbt notin nin
\:∅ empty 0/ es se
\:⊂ propersubset pss
\:⊄ notsubset nsubset nss
\:⊆ subset ss
\:∪ union su
\:∩ intersection inter si
\:≡ equivalent equiv eq === =3
\:≠ notequal noteq neq !=
\:∞ infinity inf
\:√ root sqrt rt
\:τ tau
\:π pi halftau
\:∑ epsilon eps sum +
\:∏ Pi product prod *
\:ℕ naturals nat sn
\:ℝ reals real sr
\:ℚ rationals rats sq srat
\:ℂ complexes comps sc scomp
\:ℤ integers ints sz sint
\:≤ <= lte le
\:≥ >= gte ge
\:ε emptyword ew greeke gre epsilon .e
\:λ lambda greekl grl .l
\:Ω uomega greekO grO .O
\:ϴ utheta greekT grT .T
\ "

let maptypes = ['inoremap', 'cnoremap']
for str in split(mappings, ":")
  let bySpace = split(str, " ")
  let result = bySpace[0]
  for word in bySpace[1:]
    let inputs = [word, word.';', word.'-', word.'`']
    for input in inputs
      for maptype in maptypes
        execute maptype . ' ;' . input . ' ' . result 
      endfor
    endfor
  endfor
endfor
