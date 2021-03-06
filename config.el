;;; config.el -*- lexical-binding: t; -*-

;
;
;; TODO: Se over eksempel under for hvordan bruke use-package riktig
;; --> se også her: https://github.com/jethrokuan/dots/blob/master/.doom.d/config.el
;; --> og her: https://github.com/a13/emacs.d
;; (use-package! hl-todo
;;   ;; if you omit :defer, :hook, :commands, or :after, then the package is loaded
;;   ;; immediately. By using :hook here, the `hl-todo` package won't be loaded
;;   ;; until prog-mode-hook is triggered (by activating a major mode derived from
;;   ;; it, e.g. python-mode)
;;   :hook (prog-mode . hl-todo-mode)
;;   :init
;;   ;; code here will run immediately
;;   :config
;;   ;; code here will run after the package is loaded
;;   (setq hl-todo-highlight-punctuation ":"))


(load! "+defuns")
(load! "+ui")

;; TODO: Se her for riktig lasting av lokal pakke:
;; https://github.com/hlissner/doom-emacs/blob/develop/docs/getting_started.org#usingloading-local-packages

(defun maple-scratch-hide-lines () ;; TODO: Denne endring som gjør at unthemed mode-line vises?
  (when (or maple-scratch-anywhere (equal (buffer-name) maple-scratch-buffer))
    (progn
      ;; TODO: Sjekk her på om tab-bar-mode er aktivt?
      (tab-bar-rename-tab "Home")
      ;; TODO: Feil at tab blir Home når åpner fil på direkten med emacs. Bare når tabs aktivert med en gang
      ;; TODO: Endre slik at aldri kan være andre buffere enn scratch i home tab.
      ;; --> Lag ny tab auto hvis åpner ny buffer når i denne
    (hide-mode-line-mode))
    ))

;; TODO: Test å skjule modeline opprinnelig med xresources
(add-hook 'after-change-major-mode-hook #'maple-scratch-hide-lines)

;; Hvorfan åpne flere filer fra cli til tabs? 
;; - https://emacs.stackexchange.com/questions/61312/open-multiple-files-in-tabs-from-command-line
;; - https://emacs.stackexchange.com/questions/61677/make-display-buffer-open-buffer-in-new-tab/61681#61681

;; TODO: Juster config på denne: https://github.com/honmaple/emacs-maple-scratch -> gjøre til +scratch? -> eller tilpasse maple-scratch direkte heller?
;; TODO: Juster så både modeline og header line ikke vises når scratch er aktiv buffer

(load! "vendor/maple-scratch.el")
(setq initial-scratch-message "")


;; (add-hook 'emacs-startup-hook
;;       (lambda ()
;;         (if (= 1 (length command-line-args))
;;             (maple-scratch-init)
;;           )))

;; TODO: Fiks så ingenting av dette lastes når emacs startes med fil arg
(use-package! maple-scratch
  :hook
  (window-setup . maple-scratch-init)
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


(load! "+bindings.el")
(load! "+org.el")
(load! "+markdown.el")


(point-history-mode t)

;; https://github.com/CsBigDataHub/counsel-fd/blob/master/counsel-fd.el
;; TODO: Finn bedre ivy/counsel for fd-find eller fiks/lag kode selv

(use-package! counsel-etags
  :init
  (add-hook 'prog-mode-hook
        (lambda ()
          (add-hook 'after-save-hook
            'counsel-etags-virtual-update-tags 'append 'local)))
  :config
  (setq counsel-etags-update-interval 60)
  (push "build" counsel-etags-ignore-directories))

;; TODO: Virker bare med enkelte ivy/counsel og treg i start (fordi ikke lagt inn start etter ivy?)
;; (use-package all-the-icons-ivy
;;  :init (add-hook 'after-init-hook 'all-the-icons-ivy-setup))

(eval-after-load 'flycheck
  '(progn
     (require 'flycheck-bashate)
     (flycheck-bashate-setup)))

(add-hook 'csv-mode-hook (lambda () (setq truncate-lines t)))

(use-package! ctrlf
  :bind
  ([remap isearch-forward]         . ctrlf-forward-literal)
  ([remap isearch-backward]        . ctrlf-backward-literal)
  ([remap isearch-forward-regexp]  . ctrlf-forward-regexp)
  ([remap isearch-backward-regexp] . ctrlf-backward-regexp)
  :config
  ;; Clear out the bindings because we've already defined them.
  ;; TODO: Sett opp i bindings heller
  (setq ctrlf-mode-bindings '())
  (setq ctrlf-minibuffer-bindings
        `(
          (,(kbd "<return>") . ctrlf-next-match)
          (,(kbd "<escape>") . exit-minibuffer)))
  (ctrlf-mode +1))



(add-hook 'prog-mode-hook
          (lambda ()
            (tab-jump-out-mode)))

