;;; +org.el -*- lexical-binding: t; -*-

(use-package! markdown-mode
  :after markdown-mode
  :init
  (setq-default markdown-hide-markup t))
