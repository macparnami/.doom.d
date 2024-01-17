(setq doom-theme 'doom-one)

(setq doom-font (font-spec :family "FiraCode Nerd Font Mono" :size 17
:weight 'normal))

(setq display-line-numbers-type 'relative)

(use-package! lsp-ui
  :bind
  (("C-h ." . lsp-ui-doc-focus-frame))
  )

(after! lsp-ui
  (setq lsp-ui-doc-enable t
        ;; lsp-ui-doc-position 'at-point
        ;; lsp-lens-enable t
        ;; lsp-ui-sideline-enable t
        ;; lsp-ui-doc-include-signature t
        lsp-headerline-breadcrumb-enable t
        lsp-signature-function 'lsp-signature-posframe
        lsp-modeline-code-actions-enable t
        lsp-completion-show-detail t
        lsp-completion-show-kind t
        ;; lsp-signature-render-documentation t
        lsp-ui-doc-max-height 15
        lsp-ui-doc-max-width 100)
  )

(add-hook 'inferior-python-mode-hook
          (lambda ()
            (setq comint-move-point-for-output t)))

(use-package! lsp-pyright
  :defer t
  :ensure t
  :init
  (setq! lsp-pyright-multi-root nil)
  )

(use-package! conda
  :config
  (setq! conda-env-autoactivate-mode t)
  (add-hook 'python-mode-hook (lambda ()
                                (when
                                    (bound-and-true-p
                                     conda-project-env-path)
                                  (conda-env-activate-for-buffer))))
  )

(setq! org-superstar-headline-bullets-list '("⁖" "◉" "○" "✸" "✿"))

(setq org-directory "~/org/")

(map! :leader
      (:prefix ("s a" . "Avy")
       :desc "Avy Jump Char 2" "c" #'avy-goto-char-2
       :desc "Avy Jump Symbol 1" "s" #'avy-goto-symbol-1
       :desc "Avy Jump Word or Subword 1" "w" #'avy-goto-word-or-subword-1
       )
      )

(map! :leader
      (:prefix ("d" . "dired")
       :desc "Open dired" "o" #'dired
       :desc "Create empty file" "f" #'dired-create-empty-file
       :desc "Create directory" "d" #'dired-create-directory
       :desc "Dired jump to current" "j" #'dired-jump)
      )
(evil-define-key 'normal dired-mode-map
  (kbd "M-RET") 'dired-display-file
  (kbd "h") 'dired-up-directory
  (kbd "l") 'dired-find-file ; use dired-find-file instead of dired-open.
  (kbd "m") 'dired-mark
  (kbd "t") 'dired-toggle-marks
  (kbd "u") 'dired-unmark
  (kbd "C") 'dired-do-copy
  (kbd "D") 'dired-do-delete
  (kbd "J") 'dired-goto-file
  (kbd "+") 'dired-create-directory
  (kbd "-") 'dired-do-kill-lines
  (kbd "R") 'dired-do-rename
  (kbd "T") 'dired-do-touch
  (kbd "Y") 'dired-copy-filenamecopy-filename-as-kill ; copies filename to kill ring.
  (kbd "% l") 'dired-downcase
  (kbd "% m") 'dired-mark-files-regexp
  (kbd "% u") 'dired-upcase
  )

(use-package! which-key
  :ensure t
  :config
  (setq which-key-use-C-h-commands t)
  )
;; this will unbind the C-h in evil window mode
(map! :leader
      (:prefix ("w")
       :desc "" "C-h" #'nil)
      )
