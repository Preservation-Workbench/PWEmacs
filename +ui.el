;;; +ui.el -*- lexical-binding: t; -*-

;; TODO: Se for eksempel på bruk av doom emacs sin use-package! (med utropstegn): https://github.com/jethrokuan/dots/blob/master/.doom.d/config.el

(use-package! emacs
  :config

  ;; Frame:
  (setq-default frame-title-format '("PWEmacs"))
  (setq-default icon-title-format  '("PWEmacs"))
  (menu-bar-mode 1)
  (setq doom-theme 'doom-one-light)
  (defun pw-save-frame-size ()           ; Save frame-size between sessions
    (pw-de-maximize)
    (call-process-shell-command "nohup grep -q 'emacs.geometry:*' ~/.Xresources 2> /dev/null || echo 'emacs.geometry: 100x46' >> ~/.Xresources &")
    (call-process-shell-command (concat "nohup sed -i 's/^emacs.geometry: .*/emacs.geometry: " (number-to-string (frame-width)) "x" (number-to-string (+ 2 (frame-height))) "/g' ~/.Xresources &"))
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
  (setq confirm-kill-processes nil)   ; Do not ask for confirm when killing processes
  (setq confirm-kill-emacs nil) ; Do not ask for confirm when killing emacs
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
                  (cond ((string-equal "eglot" (downcase (substring (buffer-name) 1 6)))
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



;;; Dialogs:

;; WAIT: Lag gui-varianter etter behov for når noe er åpnet fra meny og ikke shortcut
;; -> se flere gode eksempler her: https://github.com/cmpitg/emacs-config/blob/master/config-default/custom-functions.el
;; Og her: https://github.com/cmpitg/emacs-cmpitg/blob/780d35d0ee3678e9c97a8a473de3d47ba2c4e95c/src/config-core-functions.el

;;(defun sauron-fx-zenity (msg)
;; (defun sauron-fx-zenity ()
;;   "Pop-up a zenity window with MSG."
;;   (interactive)
;;   (shell-command "zenity --question --text Hi"))
;;   ;(unless (executable-find "zenity")
;;     ;(error "zenity not found"))
;;   ;(call-process "zenity" nil 0 nil "--info" "--title=Sauron"
;;     ;(concat "--text=" msg)))

;; (defun my-notify (title message)
;;   (my-shell-command-asynchronously
;;    (format "zenity --info --title \"%s\" --text \"%s\""
;;            title message)))
