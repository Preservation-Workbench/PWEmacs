;;; +ui.el -*- lexical-binding: t; -*-

(use-package! emacs
  :config

  ;; Frame:
  (setq initial-frame-alist '((left . .5)))
  (setq doom-font (font-spec :family "Fira Code" :size 13))
  (setq-default
   display-fill-column-indicator-column 110
   truncate-lines t)
  ;; TODO: Automatiser installasjon av font selv heller enn bruke kommando
  (menu-bar-mode 1)
  (setq doom-theme 'doom-one-light)
  (defun pw-save-frame-size ()           ; Save frame-size between sessions
    (pw-de-maximize)
    (pretty-tabs-mode)
    (call-process-shell-command
     (concat "nohup grep -q 'emacs.geometry:*' ~/.Xresources 2> /dev/null"
             " || echo 'emacs.geometry: 100x46' >> ~/.Xresources &"))
    (call-process-shell-command
     (concat "nohup sed -i 's/^emacs.geometry: .*/emacs.geometry: "
             (number-to-string (frame-width)) "x"
             (number-to-string (frame-height)) "/g' ~/.Xresources &"))
    ;; TODO: Nødvendig å ha Emacs.tabBar: 0 i xresources?
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

(load! "vendor/pretty-tabs.el")


;; TODO: Se over disse:
;; https://github.com/pfault/dotfiles/blob/3c5a89b8fcdf23d03d7ce66c9fb91c245a973b6e/.emacs.d/modules/workspace/nexus-tab-bar.el
(use-package! tab-bar
  :init
  (tab-bar-mode -1)
  ;;(pretty-tabs-mode)
  :config
  ;; (tab-bar-mode -1)
  ;;(setq tab-bar-button-margin 0)
  ;;(setq tab-bar-button-relief 0)
  ;;(setq tab-bar-border 2)
  (setq tab-bar-back-button "")
  (setq tab-bar-forward-button "")
  (setq tab-bar-close-button-show nil)
  (setq tab-bar-new-button-show nil)
  ;; (setq-default tab-bar-close-last-tab-choice 'tab-bar-mode-disable)
  (setq tab-bar-close-last-tab-choice "Home")
  ;; TODO: Denne virker ikke helt -> havner på Home men ikke med scratch?
  ;; --> Eller denn ok men må sørge for at ikke andre enn scratch buffer i Home tab bare?
  (setq tab-bar-close-tab-select 'recent)
  (setq tab-bar-new-tab-choice (lambda () (new-untitled-buffer)))
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

  ;;(tab-bar-mode 1) ;; TODO: Reduser høyde på frame før aktiverer så ikke øker høyde på frame
  (global-tab-line-mode -1)
  (tab-bar-history-mode -1)

  ;; :bind (("C-x t t" . prot/tab-bar-select-tab-dwim)
  ;;        ("s-t" . prot/tab-bar-select-tab-dwim)
  ;;        ("C-x t s" . tab-switcher))
  ;;:custom-face
  ;;(tab-bar . '((t (:background "Gray50"))))
  ;;(tab-bar-tab . '((t (:background "white" :foreground "black" :underline t))))
  ;;(tab-bar-tab-inactive . '((t (:background "Gray50"))))
  ;; TODO: Må ha symbol og ikke farge direkte i linjer over
  )




(use-package! mini-frame
  :config
  (mini-frame-mode +1)
  (setq mini-frame-color-shift-step 10)
  (setq mini-frame-show-parameters '((top . 0.01) (width . 0.7) (left . 0.5)))
  )


(use-package! mixed-pitch
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


(defun set-face-fci ()
  "Lighter color fill column"
  (let* ((bk (face-background 'default nil 'default))
         (fg (color-name-to-rgb (face-foreground 'default nil 'default)))
         (bg (color-name-to-rgb bk))
         mod fl bl)
    (setq fl (nth 2 (apply 'color-rgb-to-hsl fg)))
    (setq bl (nth 2 (apply 'color-rgb-to-hsl bg)))
    (setq mod (cond ((< fl bl) -1) ((> fl bl) 1) ((< 0.5 bl) -1) (t 1)))
    (set-face-foreground 'fill-column-indicator (color-lighten-name bk (* mod 10))))
  )

(add-hook 'prog-mode-hook #'set-face-fci) ;; TODO: Sjekk om prog-mode-hook som bruker av doom også

;; TODO: Sjekk om kan få vist denne i mini-frame
;; TODO: Bruke pretty-hydra?
(defhydra hydra-mark-buffer (:exit t :idle 1.0)
  "Mark buffer"
  ("w" mark-whole-buffer "Whole buffer")
  ("a" mark-buffer-after-point "Buffer after point")
  ("b" mark-buffer-before-point "Buffer before point"))

(global-set-key (kbd "M-l") 'hydra-mark-buffer) ;; TODO: HVorfor virker ikke denne?

;; TODO: Lag hydra for C-n slik at kan velge hva som skal i ny tab

;; TODO: Gjøre mer lik mini-frame?
(use-package! hydra-posframe
  :hook (after-init . hydra-posframe-enable))

;; Scrollbar only on active window visiting file
(defun update-scroll-bars ()
  (interactive)
  (mapc (lambda (win)
          (set-window-scroll-bars win nil))
        (window-list))
  (if (buffer-file-name (window-buffer (selected-window)))
      (set-window-scroll-bars (selected-window) 10 'right)))

(add-hook 'window-configuration-change-hook 'update-scroll-bars)
(add-hook 'buffer-list-update-hook 'update-scroll-bars)
