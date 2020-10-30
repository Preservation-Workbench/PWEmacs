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


(cond (IS-LINUX 'x)
(let ((font-dest (cl-case window-system
                   (x  (concat (or (getenv "XDG_DATA_HOME")            ;; Default Linux install directories
                                   (concat (getenv "HOME") "/.local/share"))
                               "/fonts/")))))
  (unless (file-exists-p (concat font-dest "all-the-icons.ttf"))
    (all-the-icons-install-fonts t))))

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
