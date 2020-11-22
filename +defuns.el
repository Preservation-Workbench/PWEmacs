;;; +defuns.el -*- lexical-binding: t; -*-

; TODO: Hvorfor feil bakgrunnsfarge? Fordi ikke lagret fil?
(defun new-untitled-buffer ()
  "Opens a new empty buffer."
  (interactive)
  (let ((buf (generate-new-buffer "Untitled")))
    (pretty-tabs-mode)
    (switch-to-buffer buf)
    (text-mode) ;; TODO: Tregere start hvis text-mode -> hvordan endre i etterkant?
    (doom-mark-buffer-as-real-h) ;; TODO: Virker denne?
    (turn-on-solaire-mode) ;; Virker ikke
    (setq buffer-offer-save t) ;; TODO: Fiks så denne respekteres ved lukking av tab med mus
    )
  ;(add-hook 'kill-buffer-query-functions
            ;'ask-to-save-modified nil t) ;; TODO: Denne sies er undefined
  )