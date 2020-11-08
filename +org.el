;;; +org.el -*- lexical-binding: t; -*-

(setq org-directory "~/org/")
(after! org
    (setq org-hide-emphasis-markers t)
    (setq org-support-shift-select  t)
    (setq prettify-symbols-unprettify-at-point 'right-edge)
    ;; TODO: Virker bare for de i prettify-symbols-alist under. Hvordan virker for bullets også?
    ;; --> se også her: https://www.reddit.com/r/orgmode/comments/grh423/is_it_possible_to_make_orghideemphasismarkers_and/
    (setq-default prettify-symbols-alist '(("#+BEGIN_SRC" . "λ")
                                           ("#+END_SRC" . "≋")
                                           ("#+begin_src" . "λ")
                                           ("#+end_src" . "≋")
                                           ("#+BEGIN_QUOTE" . "“")
                                           ("#+END_QUOTE" . "”")
                                           ("#+begin_quote" . "“")
                                           ("#+end_quote" . "”")
                                           ("#+TITLE:" . "⋮")
                                           ("#+title:" . "⋮")
                                           ("#+SUBTITLE:" . "⋮")
                                           ("#+subtitle:" . "⋮")
    ))
    (add-hook 'org-mode-hook 'prettify-symbols-mode)
    (add-hook 'org-mode-hook (lambda () (org-autolist-mode)))
)
