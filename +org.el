;;; +org.el -*- lexical-binding: t; -*-

(setq org-directory "~/org/")
(after! org
    (setq org-hide-emphasis-markers t)
    (setq org-support-shift-select  t)
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

