;;; +org.el -*- lexical-binding: t; -*-

;; WAIT: Test markdown-toggle-inline-images
(use-package! markdown-mode
  :after markdown-mode
  :init
  (setq byte-compile-warnings '(cl-functions))
  (add-hook 'markdown-mode-hook #'pwe/markdown-unhighlight))


;; https://superuser.com/a/1025827
;; ;; TODO: Flytt denne til egen fil for funksjoner som brukes flere steder
(defun pwe/suppress-messages (old-fun &rest args)
  (cl-flet ((silence (&rest args1) (ignore)))
    (advice-add 'message :around #'silence)
    (unwind-protect
         (apply old-fun args)
      (advice-remove 'message #'silence))))


;; https://emacs.stackexchange.com/a/47747
(defvar pwe/current-line '(0 . 0)
  "(start . end) of current line in current buffer")
(make-variable-buffer-local 'pwe/current-line)

(defun pwe/unhide-current-line (limit)
  "Font-lock function"
  (let ((start (max (point) (car pwe/current-line)))
        (end (min limit (cdr pwe/current-line))))
    (when (< start end)
      (remove-text-properties start end '(invisible t display ""))
      (goto-char limit)
      t)))

(defun pwe/refontify-on-linemove ()
  "Post-command-hook"
  (let* ((start (line-beginning-position))
         (end (line-beginning-position 2))
         (needs-update (not (equal start (car pwe/current-line)))))
    (setq pwe/current-line (cons start end))
    (when needs-update
      (advice-add 'font-lock-fontify-block :around #'pwe/suppress-messages)
      (font-lock-fontify-block 3)
      (advice-remove 'font-lock-fontify-block #'pwe/suppress-messages))))

(defun pwe/markdown-unhighlight ()
  "Install"
  (markdown-toggle-markup-hiding 1)
  (font-lock-add-keywords nil '((pwe/unhide-current-line)) t)
  (add-hook 'post-command-hook #'pwe/refontify-on-linemove nil t))
