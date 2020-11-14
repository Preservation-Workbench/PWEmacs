;;; +ui.el -*- lexical-binding: t; -*-

;; TODO: Se for eksempel på bruk av doom emacs sin use-package! (med utropstegn):
;; https://github.com/jethrokuan/dots/blob/master/.doom.d/config.el

(use-package! emacs
  :config

  ;; Frame:
  (setq-default frame-title-format '("PWEmacs"))
  (setq-default icon-title-format  '("PWEmacs"))
  (setq doom-font (font-spec :family "Fira Code" :size 13))
  (setq-default
   display-fill-column-indicator-column 110
   truncate-lines t)
  ;; TODO: Automatiser installasjon av font selv heller enn bruke kommando
  (menu-bar-mode 1)
  (setq doom-theme 'doom-one-light)
  (defun pw-save-frame-size ()           ; Save frame-size between sessions
    (pw-de-maximize)
    (call-process-shell-command
     (concat "nohup grep -q 'emacs.geometry:*' ~/.Xresources 2> /dev/null"
             " || echo 'emacs.geometry: 100x46' >> ~/.Xresources &"))
    (call-process-shell-command
     (concat "nohup sed -i 's/^emacs.geometry: .*/emacs.geometry: "
             (number-to-string (frame-width)) "x"
             (number-to-string (- (frame-height) 1)) "/g' ~/.Xresources &"))
    (call-process-shell-command "nohup xrdb -merge ~/.Xresources &"))
  (defun pw-de-maximize ()
    (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
                           '(0 "_NET_WM_STATE_MAXIMIZED_HORZ" 0))
    (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
                           '(0 "_NET_WM_STATE_MAXIMIZED_VERT" 0)))
  (add-hook 'kill-emacs-hook 'pw-save-frame-size)

  ;; Cursor:
  (bar-cursor-mode 1)

  ;; Messages:
  (setq confirm-kill-processes nil) ; Do not ask confirm when killing processes
  (setq confirm-kill-emacs nil) ; Do not ask confirm when killing emacs
  )



;; (setq tab-bar-close-button-show nil)
;; (setq tab-bar-new-button-show nil)
;; (setq tab-bar-position nil)

;; (use-package tab-bar
;;   :init
;;   (setq tab-bar-show 1                  ; hide when only one tab
;;         tab-bar-new-tab-choice "*scratch*"
;;         tab-bar-tab-name-function #'tab-bar-tab-name-all
;;         tab-bar-new-tab-to 'rightmost)
;;   ;; :config
;;   ;; ;; use C-x t T to toggle actually displaying the tab-bar:
;;   ;; (define-key tab-prefix-map (kbd "T") #'tab-bar-mode)
;;   ;; ;; C-z C-z to emulate "toggle between most recent tab" (not circulate in order)
;;   ;; (define-key tab-prefix-map (kbd "C-z") #'tab-recent)
;;   ;; ;; View (/select) list of tabs. See also C-zRET tab-bar-select-tab-by-name
;;        ;; (define-key tab-prefix-map (kbd "C-l") #'tab-list)
;;   ;; :bind-keymap ("C-z" . tab-prefix-map)

;;   )


(customize-set-variable 'tab-bar-new-tab-choice (lambda () (new-untitled-buffer)))

;; TODO: Se over disse: 
;; https://github.com/tadfisher/nixhome/blob/540da320eade4f4d9eec61861a1c7cd08be3206a/pkgs/emacs/pretty-tabs/pretty-tabs.el
;; https://github.com/pfault/dotfiles/blob/3c5a89b8fcdf23d03d7ce66c9fb91c245a973b6e/.emacs.d/modules/workspace/nexus-tab-bar.el
(use-package tab-bar
  :config
  ;;(setq tab-bar-button-margin 0)
  ;;(setq tab-bar-button-relief 0)
  ;;(setq tab-bar-border 2)
  (setq tab-bar-back-button "")
  (setq tab-bar-forward-button "")
  (setq tab-bar-close-button-show nil)
  (setq tab-bar-new-button-show nil)
  (setq tab-bar-close-last-tab-choice "*scratch*") ;; TODO: Denne virker ikke helt
  (setq tab-bar-close-tab-select 'recent)
  (setq tab-bar-new-tab-choice t)
  (setq tab-bar-new-tab-to 'right)
  (setq tab-bar-position nil)
  (setq tab-bar-show nil)
  (setq tab-bar-tab-hints nil)
  (setq tab-bar-tab-name-function 'tab-bar-tab-name-all)

  ;; TODO: Endring under gjorte at frame ble høyere for hver gang
 ;;  (custom-set-faces
 ;; '(tab-bar
 ;;   ((t (
 ;;        ;;:background "#393939"
 ;;        :height 1.2
 ;;        ))))
 ;; '(tab-bar-tab
 ;;   ((t (
 ;;        ;;:background "#393939"
 ;;        ;;:foreground "#cc99cc"
 ;;        :box nil ; '(:line-width 1 :style nil)
 ;;        :inverse-video: nil
 ;;        :height 0.9
 ;;        ))))
 ;; '(tab-bar-tab-inactive
 ;;   ((t (
 ;;        ;;:background "#999999"
 ;;        ;;:foreground "#393939"
 ;;        :box nil ; '(:line-width 1 :style nil)
 ;;        :inverse-video: nil
 ;;        :height 0.9
 ;;        ))))
 ;; ;; '(tab-line
 ;; ;;   ((t (
 ;; ;;        :background "#191919"
 ;; ;;        ))))
 ;; )

  (tab-bar-mode 1) ;; TODO: Reduser høyde på frame før aktiverer så ikke øker høyde på frame
  (global-tab-line-mode -1)
  (tab-bar-history-mode -1)

  (defun prot/tab-bar-select-tab-dwim ()
    "Do-What-I-Mean function for getting to a `tab-bar-mode' tab.
If no other tab exists, create one and switch to it.  If there is
one other tab (so two in total) switch to it without further
questions.  Else use completion to select the tab to switch to."
    (interactive)
    (let ((tabs (mapcar (lambda (tab)
                          (alist-get 'name tab))
                        (tab-bar--tabs-recent))))
      (cond ((eq tabs nil)
             (tab-new))
            ((eq (length tabs) 1)
             (tab-next))
            (t
             (icomplete-vertical-do ()
               (tab-bar-switch-to-tab
                (completing-read "Select tab: " tabs nil t)))))))

  ;; :bind (("C-x t t" . prot/tab-bar-select-tab-dwim)
  ;;        ("s-t" . prot/tab-bar-select-tab-dwim)
  ;;        ("C-x t s" . tab-switcher))
  ;;:custom-face
  ;;(tab-bar . '((t (:background "Gray50"))))
  ;;(tab-bar-tab . '((t (:background "white" :foreground "black" :underline t))))
  ;;(tab-bar-tab-inactive . '((t (:background "Gray50"))))
  ;; TODO: Må ha symbol og ikke farge direkte i linjer over
  )

(use-package! centaur-tabs
  :after centaur-tabs
  :config
  (defun centaur-tabs-hide-tab (x)
    "Do no to show buffer X in tabs."
    (let ((name (format "%s" x)))
      (or
       ;; Current window is not dedicated window.
       (window-dedicated-p (selected-window))
       ;; Buffer name not match below blacklist.
       (string-prefix-p "*scratch*" name)
       (string-prefix-p "*epc" name)
       (string-prefix-p "*helm" name)
       (string-prefix-p "*Helm" name)
       (string-prefix-p "*Compile-Log*" name)
       (string-prefix-p "*lsp" name)
       (string-prefix-p "*company" name)
       (string-prefix-p "*Flycheck" name)
       (string-prefix-p "*tramp" name)
       (string-prefix-p " *Mini" name)
       (string-prefix-p "*help" name)
       (string-prefix-p "*straight" name)
       (string-prefix-p " *temp" name)
       (string-prefix-p "*Help" name)
       (string-prefix-p "*mybuf" name)
       ;; Is not magit buffer.
       (and (string-prefix-p "magit" name)
            (not (file-name-extension name))))))
  (defun centaur-tabs-buffer-groups ()
    "Use as few groups as possible."
    (list (cond ((string-equal "*" (substring (buffer-name) 0 1))
                 (cond ((string-equal "eglot"
                                      (downcase (substring (buffer-name) 1 6)))
                        "Eglot")
                        (t
                        "Tools")))
                ((string-equal "magit" (downcase (substring (buffer-name) 0 5)))
                  "Magit")
                (t
                 "Default"))))
  )



(use-package! mini-frame
  :config
  (mini-frame-mode +1)
  (setq mini-frame-color-shift-step 10)
  (setq mini-frame-show-parameters '((top . 0.01) (width . 0.7) (left . 0.5))))


(use-package mixed-pitch
  :hook
  (text-mode . mixed-pitch-mode)
  )


(use-package! hl-todo
  :after hl-todo
  :config
  (setq hl-todo-highlight-punctuation ":"
        hl-todo-keyword-faces
        `(
          ("TODO" error bold)
          ("FIXME" error bold)
          ("HACK" font-lock-constant-face bold)
          ("NOTE" success bold)
          ("DEPRECATED" font-lock-doc-face bold)
          ("BUG" error bold)
          ("WAIT" font-lock-constant-face bold)))
  )


;; TODO: Farge på fill column ikke oppdatert når åpner fil på direkten
;;; Fill column
(after! display-fill-column-indicator
  (setq-default display-fill-column-indicator-character ?|)
  (defun set-face-fci ()
    ""
    (let* ((bk (face-background 'default nil 'default))
          (fg (color-name-to-rgb (face-foreground 'default nil 'default)))
          (bg (color-name-to-rgb bk))
          mod fl bl)
      (setq fl (nth 2 (apply 'color-rgb-to-hsl fg)))
      (setq bl (nth 2 (apply 'color-rgb-to-hsl bg)))
      (setq mod (cond ((< fl bl) -1) ((> fl bl) 1) ((< 0.5 bl) -1) (t 1)))
      (set-face-foreground 'fill-column-indicator (color-lighten-name bk (* mod 10))))
    )

  (custom-set-faces
  '(fill-column-indicator ((t (:inherit default)))))
  (set-face-fci)
  )
