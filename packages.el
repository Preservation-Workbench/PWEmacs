;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

;; To install a package with Doom you must declare them here and run 'doom sync'
;; on the command line, then restart Emacs for the changes to take effect -- or
;; use 'M-x doom/reload'.


;; To install SOME-PACKAGE from MELPA, ELPA or emacsmirror:
;(package! some-package)

;; To install a package directly from a remote git repo, you must specify a
;; `:recipe'. You'll find documentation on what `:recipe' accepts here:
;; https://github.com/raxod502/straight.el#the-recipe-format
;(package! another-package
;  :recipe (:host github :repo "username/repo"))

;; If the package you are trying to install does not contain a PACKAGENAME.el
;; file, or is located in a subdirectory of the repo, you'll need to specify
;; `:files' in the `:recipe':
;(package! this-package
;  :recipe (:host github :repo "username/repo"
;           :files ("some-file.el" "src/lisp/*.el")))

;; If you'd like to disable a package included with Doom, you can do so here
;; with the `:disable' property:
;(package! builtin-package :disable t)

;; You can override the recipe of a built in package without having to specify
;; all the properties for `:recipe'. These will inherit the rest of its recipe
;; from Doom or MELPA/ELPA/Emacsmirror:
;(package! builtin-package :recipe (:nonrecursive t))
;(package! builtin-package-2 :recipe (:repo "myfork/package"))

;; Specify a `:branch' to install a package from a particular branch or tag.
;; This is required for some packages whose default branch isn't 'master' (which
;; our package manager can't deal with; see raxod502/straight.el#279)
;(package! builtin-package :recipe (:branch "develop"))

;; Use `:pin' to specify a particular commit to install.
;(package! builtin-package :pin "1a2b3c4d5e")


;; Doom's packages are pinned to a specific commit and updated from release to
;; release. The `unpin!' macro allows you to unpin single packages...
;(unpin! pinned-package)
;; ...or multiple packages
;(unpin! pinned-package another-pinned-package)
;; ...Or *all* packages (NOT RECOMMENDED; will likely break things)
;(unpin! t)

(package! bar-cursor)
(package! hercules)
(package! org-autolist)
(package! all-the-icons-ivy)
(package! mini-frame)
(package! mixed-pitch)
(package! flycheck-bashate)
(package! tab-jump-out)
(package! grip-mode)
(package! pretty-hydra) ;; TODO: Beholde denne?
(package! hydra-posframe)
(package! ivy-searcher)
;; (package! switch-buffer-functions)
(package! hydra-posframe :recipe (:host github :repo "Ladicle/hydra-posframe"))
(package! counsel-world-clock)
(package! counsel-etags) ;; TODO: Bruke counsel-imenu heller?
(package! show-eol :recipe (:host github :repo "jcs-elpa/show-eol"))
(package! point-history :recipe (:host github :repo "blue0513/point-history"))
(package! ivy-point-history :recipe (:host github :repo "SuzumiyaAoba/ivy-point-history"))
(package! ctrlf :recipe (:host github :repo "raxod502/ctrlf"))

;; (package! which-key :disable t)
;; TODO: Kan legge til flere med space mellom i variant under
(disable-packages! which-key)
