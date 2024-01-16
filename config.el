;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)
(setq doom-font (font-spec :family "FiraCode Nerd Font Mono" :size 17 :weight 'normal))
;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.


;; Doom theme
;; lsp-mode
;; (use-package! lsp-mode
;;   :defer t
;;   :commands lsp
;;   :hook (python-mode . lsp-mode)
;;   :config
;;   )
;; ;
;; lsp-pyright
;; Python related config
;; inferior shell auto scroll mode
(add-hook 'inferior-python-mode-hook
          (lambda ()
            (setq comint-move-point-for-output t)))

;; Init config to disable Multiroot projects
(use-package! lsp-pyright
  :defer t
  :ensure t
  :init
  (setq! lsp-pyright-multi-root nil)
  )

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

;; Conda.el config
(use-package! conda
  :config
  (setq! conda-env-autoactivate-mode t)
  (add-hook 'python-mode-hook (lambda () (when (bound-and-true-p conda-project-env-path)
                                           (conda-env-activate-for-buffer))))
  )

;;avy config
(map! :leader
      (:prefix ("s a" . "Avy")
       :desc "Avy Jump Char 2" "c" #'avy-goto-char-2
       :desc "Avy Jump Symbol 1" "s" #'avy-goto-symbol-1
       :desc "Avy Jump Word or Subword 1" "w" #'avy-goto-word-or-subword-1
       )
      )



;; dired config
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


;; Org mod Config
(setq! org-superstar-headline-bullets-list '("⁖" "◉" "○" "✸" "✿"))


;; Which key config for enabling pagination
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


