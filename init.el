;;; init.el -*- lexical-binding: t; -*-

;; This file controls what Doom modules are enabled and what order they load
;; in. Remember to run 'doom sync' after modifying it!

(doom! :completion
       company           ; the ultimate code completion backend
       ivy               ; a search engine for love and life

       :ui
       doom              ; what makes DOOM look the way it does
       fill-column       ; a `fill-column' indicator
       hl-todo           ; highlight TODO/FIXME/NOTE/DEPRECATED/HACK/REVIEW
       hydra
       indent-guides     ; highlighted indent columns
       (ligatures +fira)         ; ligatures and symbols to make your code pretty again
       (emoji +unicode)  ; 🙂
       modeline          ; snazzy, Atom-inspired modeline, plus API
       ;;neotree           ; a project drawer, like NERDTree for vim
       (popup +all)   ; tame sudden yet inevitable temporary windows
       tabs              ; a tab bar for Emacs
       ;;treemacs          ; a project drawer, like neotree but cooler
       ;;unicode           ; extended unicode support for various languages
       vc-gutter         ; vcs diff in the fringe
       workspaces        ; tab emulation, persistence & separate workspaces
       ;;zen               ; distraction-free coding or writing

       :editor
       ;;(evil +everywhere); come to the dark side, we have cookies
       file-templates    ; auto-snippets for empty files
       fold              ; (nigh) universal code folding
       (format +onsave)  ; automated prettiness
       ;;lispy             ; vim for lisp, for people who don't like vim
       multiple-cursors  ; editing in many places at once
       ;;objed             ; text object editing for the innocent
       ;;parinfer          ; turn lisp into python, sort of
       snippets          ; my elves. They type so I don't have to
       ;;word-wrap         ; soft wrapping with language-aware indent

       :emacs
       (dired +ranger +icons)             ; making dired pretty [functional]
       electric          ; smarter, keyword-based electric-indent
       undo              ; persistent, smarter undo for your inevitable mistakes
       vc                ; version-control and Emacs, sitting in a tree

       :term
       ;vterm             ; the best terminal emulation in Emacs

       :checkers
       syntax              ; tasing you for every semicolon you forget
       (spell +flyspell +hunspell)    ; tasing you for misspelling mispelling

       :tools
       ;;debugger          ; FIXME stepping through code, to help you add bugs
       ;;direnv
       docker
       ;;ein               ; tame Jupyter notebooks with emacs
       (eval +overlay)     ; run code, run (also, repls)
       ;;gist              ; interacting with github gists
       lookup              ; navigate your code and its documentation
       ;;lsp
       magit             ; a git porcelain for Emacs
       ;;make              ; run make tasks from Emacs
       ;;pass              ; password manager for nerds
       ;;rgb               ; creating color strings
       ;;taskrunner        ; taskrunner for all your projects

       :lang
       ;;cc                ; C/C++/Obj-C madness
       ;;clojure           ; java with a lisp
       csharp            ; unity, .NET, and mono shenanigans
       data              ; config/data formats
       ;;(dart +flutter)   ; paint ui and not much else
       emacs-lisp        ; drown in parentheses
       ;;ess               ; emacs speaks statistics
       ;;fsharp            ; ML stands for Microsoft's Language
       ;;(go +lsp)         ; the hipster dialect
       ;;hy                ; readability of scheme w/ speed of python
       json              ; At least it ain't XML
       (java +meghanada) ; the poster child for carpal tunnel syndrome
       javascript        ; all(hope(abandon(ye(who(enter(here))))))
       ;;julia             ; a better, faster MATLAB
       ;;kotlin            ; a better, slicker Java(Script)
       ;;latex             ; writing papers in Emacs has never been so fun
       ;;lua               ; one-based indices? one-based indices
       markdown          ; writing docs for people to ignore
       ;;nim               ; python + lisp at the speed of c
       ;;nix               ; I hereby declare "nix geht mehr!"
       (org +dragndrop +pandoc +pretty) ; organize your plain life in plain text
       php               ; perl's insecure younger brother
       ;;plantuml          ; diagrams for confusing people more
       python            ; beautiful is better than ugly
       ;;qt                ; the 'cutest' gui framework ever
       ;;rest              ; Emacs as a REST client
       rst               ; ReST in peace
       sh                ; she sells {ba,z,fi}sh shells on the C xor
       web               ; the tubes
       yaml              ; JSON, but readable
       :config
       (default +smartparens))


