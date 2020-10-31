;;; +ui.el -*- lexical-binding: t; -*-

;;; Frame:
(setq-default frame-title-format '("PWEmacs"))
(setq-default icon-title-format  '("PWEmacs"))
(menu-bar-mode 1)

;;(setq doom-theme 'doom-one)
;;(setq doom-theme 'doom-vibrant)
(setq doom-theme 'doom-one-light)

(when-let (dims (doom-store-get 'last-frame-size))
  (cl-destructuring-bind ((left . top) width height fullscreen) dims
    (setq initial-frame-alist
          (append initial-frame-alist
                  `((left . ,left)
                    (top . ,top)
                    (width . ,width)
                    (height . ,height)
                    (fullscreen . ,fullscreen))))))

(defun save-frame-dimensions ()
  (doom-store-put 'last-frame-size
                  (list (frame-position)
                        (frame-width)
                        (frame-height)
                        (frame-parameter nil 'fullscreen))))

;; WAIT: Hvor kan denne legges inn så brukes med en gang og slipper "jerk motion". Kan ikke legges i init.el (er for tidlig)
(add-hook 'kill-emacs-hook #'save-frame-dimensions)

;;; Cursor:
(bar-cursor-mode 1)


;;; Messages:
(setq confirm-kill-processes nil)   ; Do not ask for confirm when killing processes
(setq confirm-kill-emacs nil) ; Do not ask for confirm when killing emacs

;;; Buffers:
(when (featurep! :input tabs)
    ;; TODO: Linje under satt i doom selv men virker ikke -> test mot buffer-name "*doom*" heller?
    ;;(add-hook '+doom-dashboard-mode-hook #'centaur-tabs-local-mode)
    ;;(add-hook 'fundamental-mode-hook 'centaur-tabs-local-mode)
)



;;; Dialogs:

;; WAIT: Lag gui-varianter etter behov for når noe er åpnet fra meny og ikke shortcut
;; -> se flere gode eksempler her: https://github.com/cmpitg/emacs-config/blob/master/config-default/custom-functions.el
;; Og her: https://github.com/cmpitg/emacs-cmpitg/blob/780d35d0ee3678e9c97a8a473de3d47ba2c4e95c/src/config-core-functions.el

;;(defun sauron-fx-zenity (msg)
(defun sauron-fx-zenity ()
  "Pop-up a zenity window with MSG."
  (interactive)
  (shell-command "zenity --question --text Hi"))
  ;(unless (executable-find "zenity")
    ;(error "zenity not found"))
  ;(call-process "zenity" nil 0 nil "--info" "--title=Sauron"
    ;(concat "--text=" msg)))

(defun my-notify (title message)
  (my-shell-command-asynchronously
   (format "zenity --info --title \"%s\" --text \"%s\""
           title message)))

(after! centaur-tabs
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
	  (not (file-name-extension name)))
     )))

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
       
(mini-frame-mode +1)

(custom-set-variables
 '(mini-frame-show-parameters
   '((top . 10)
     (width . 0.7)
     (left . 0.5))))      