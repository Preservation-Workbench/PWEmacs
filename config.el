;;; config.el -*- lexical-binding: t; -*-

;; TODO: Fiks så "open with emacs" fra thunar bruker kommando på denne formen: emacsclient -a /usr/bin/emacs FILE
;; --> ikke helt fullgod løsning (men muligens bare når startet fra cli) -> alternate virker ikke riktig
;; -> må ha script som sjekker om emacs startet og så kjører enten  'emacs FILENAME & disown' eller 'emacsclient -q FILENAME & disown'
;; -> noe sånt: https://stackoverflow.com/questions/24910937/how-do-i-start-emacs-from-the-command-line-but-use-emacsclient-if-a-server-is-al
;; -> må i tillegg fikse at den ene filen som åpnes på denne måten ikke har synlig tab -> tabs pakke ikke lastet tidlig nok?
;; Fjern også yes/no spm som kommer ved lukking av frame da

;; TODO: Feil farge på untitled pga solaire-mode -> finn bedre måte å justere, evt fjerne den enn linje under som ikke virker
;; -> evt få til å slå av solaire totalt -> får da mørkere bakgrunn for alt som er bedre for øynene
;; (solaire-global-mode -1)

; TODO: Fiks så tabs er lastet før untitled lages
;(defun my-close-scratch ()
  ;(kill-buffer "*scratch*")
  ;(if (not (delq nil (mapcar 'buffer-file-name (buffer-list))))
      ;(new-untitled-buffer)
    ;))
;
;(defun my-emacs-startup-hook ()
  ;(my-close-scratch))
;(add-hook 'emacs-startup-hook 'my-emacs-startup-hook)
;
; TODO: Hvorfor feil bakgrunnsfarge? Fordi ikke lagret fil?
(defun new-untitled-buffer ()
  "Opens a new empty buffer."
  (interactive)
  (let ((buf (generate-new-buffer "Untitled")))
    (centaur-tabs-mode)
    (switch-to-buffer buf)
    (text-mode) ;; TODO: Tregere start hvis text-mode -> hvordan endre i etterkant?
    (doom-mark-buffer-as-real-h) ;; TODO: Virker denne?
    (turn-on-solaire-mode) ;; Virker ikke
    (setq buffer-offer-save t) ;; TODO: Fiks så denne respekteres ved lukking av tab med mus
    )
  ;(add-hook 'kill-buffer-query-functions
            ;'ask-to-save-modified nil t) ;; TODO: Denne sies er undefined
  )

;; TODO: Denne skal virke men får den ikke til å virke med mine modes -> det finnes ingen fundament-mode hook
;; (add-hook 'completion-list-mode-hook #'doom-hide-modeline-mode)

;; (add-hook 'fundamental-mode-hook #'doom-hide-modeline-mode)
;; (add-hook 'minibuffer-setup-hook #'hide-mode-line-mode)


(defun maple-scratch-hide-lines ()
  (when (or maple-scratch-anywhere (equal (buffer-name) maple-scratch-buffer))
      (hide-mode-line-mode)))

(add-hook 'after-change-major-mode-hook #'maple-scratch-hide-lines)


;; TODO: Juster config på denne: https://github.com/honmaple/emacs-maple-scratch -> gjøre til +scratch? -> eller tilpasse maple-scratch direkte heller?
;; TODO: Juster så både modeline og header line ikke vises når scratch er aktiv buffer
(load! "vendor/maple-scratch.el")
(setq initial-scratch-message "")

(use-package maple-scratch
  :hook (window-setup . maple-scratch-init)
  :config
  (setq maple-scratch-source nil
        maple-scratch-number 5
        maple-scratch-center t
        maple-scratch-empty t
        maple-scratch-anywhere nil
        maple-scratch-write-mode 'emacs-lisp-mode
        maple-scratch-items '(maple-scratch-banner
                              maple-scratch-navbar
                              maple-scratch-default
                              maple-scratch-startup)
        maple-scratch-alist
        (append (butlast maple-scratch-alist)
                '(("Init"
                   :action 'maple/open-init-file
                   :desc "Open Init File")
                  ("Test"
                   :action 'maple/open-test-file
                   :desc "Open Test File"))
                (last maple-scratch-alist)))

  (setq maple-scratch-banner
        '(" "
          " "
          " "
          " "
          " "
          " "
          " "
          " "))

  (setq maple-scratch-navbar-alist
        '(("HOME"
           :action (lambda() (find-file (expand-file-name "init.el" user-emacs-directory)))
           :desc "Browse home")
          ("CAPTURE"
           :action 'org-capture
           :desc "Open Org Capture")
          ("AGENDA"
           :action 'org-agenda
           :desc "Open Org Agenda")
          ("HELP"
           :action (lambda() (find-file (expand-file-name "README.org" user-emacs-directory)))
           :desc "Emacs Help"))))


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "John Doe"
      user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))



;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(load! "+ui")
(load! "+bindings.el")
(load! "+org.el")

(point-history-mode t)

