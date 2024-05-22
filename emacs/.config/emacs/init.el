;;; package --- Summary:  Elpaca init.el -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(defvar elpaca-installer-version 0.7)
(defvar elpaca-directory (expand-file-name "elpaca/" user-emacs-directory))
(defvar elpaca-builds-directory (expand-file-name "builds/" elpaca-directory))
(defvar elpaca-repos-directory (expand-file-name "repos/" elpaca-directory))
(defvar elpaca-order '(elpaca :repo "https://github.com/progfolio/elpaca.git"
                              :ref nil :depth 1
                              :files (:defaults "elpaca-test.el" (:exclude "extensions"))
                              :build (:not elpaca--activate-package)))
(let* ((repo  (expand-file-name "elpaca/" elpaca-repos-directory))
       (build (expand-file-name "elpaca/" elpaca-builds-directory))
       (order (cdr elpaca-order))
       (default-directory repo))
  (add-to-list 'load-path (if (file-exists-p build) build repo))
  (unless (file-exists-p repo)
    (make-directory repo t)
    (when (< emacs-major-version 28) (require 'subr-x))
    (condition-case-unless-debug err
        (if-let ((buffer (pop-to-buffer-same-window "*elpaca-bootstrap*"))
                 ((zerop (apply #'call-process `("git" nil ,buffer t "clone"
                                                 ,@(when-let ((depth (plist-get order :depth)))
                                                     (list (format "--depth=%d" depth) "--no-single-branch"))
                                                 ,(plist-get order :repo) ,repo))))
                 ((zerop (call-process "git" nil buffer t "checkout"
                                       (or (plist-get order :ref) "--"))))
                 (emacs (concat invocation-directory invocation-name))
                 ((zerop (call-process emacs nil buffer nil "-Q" "-L" "." "--batch"
                                       "--eval" "(byte-recompile-directory \".\" 0 'force)")))
                 ((require 'elpaca))
                 ((elpaca-generate-autoloads "elpaca" repo)))
            (progn (message "%s" (buffer-string)) (kill-buffer buffer))
          (error "%s" (with-current-buffer buffer (buffer-string))))
      ((error) (warn "%s" err) (delete-directory repo 'recursive))))
  (unless (require 'elpaca-autoloads nil t)
    (require 'elpaca)
    (elpaca-generate-autoloads "elpaca" repo)
    (load "./elpaca-autoloads")))
(add-hook 'after-init-hook #'elpaca-process-queues)
(elpaca `(,@elpaca-order))

(elpaca elpaca-use-package
	(elpaca-use-package-mode))

(setq use-package-always-ensure t)

(elpaca-wait)

(use-package no-littering
  :config
  (setq custom-file (no-littering-expand-etc-file-name "custom.el")))

(elpaca-wait)

(use-package emacs
  :ensure nil
  :init
  (tool-bar-mode -1)
  (when scroll-bar-mode
    (scroll-bar-mode -1))
  (menu-bar-mode -1)
  (set-face-attribute 'default nil :font "Delugia" :height 110)
  :custom
  (treesit-language-source-alist
   '((json "https://github.com/tree-sitter/tree-sitter-json")))
  :config
  (add-to-list 'default-frame-alist '(alpha-background . 90)))

(setq user-full-name "Karolos Triantafyllou"
      user-mail-address "kartri@proton.me")

(use-package doom-themes
  :config
  (load-theme 'doom-nord t))

(use-package doom-modeline
  :init (doom-modeline-mode 1))

(use-package nerd-icons)

(use-package magit
  :commands magit-status)

(use-package json-ts-mode
  :ensure nil
  :mode ("\\.json\\|\\.jsonc\\'")
  :hook ((before-save . my/json-mode-before-save-hook)
	 (json-ts-mode . eglot-ensure))
  :preface
  (defun my/json-mode-before-save-hook ()
    (when (eq major-mode 'json-ts-mode)
      (json-pretty-print-buffer)))
  (defun my/json-array-of-numbers-on-one-line (encode array)
    "Print the arrays of numbers in one line."
    (let* ((json-encoding-pretty-print
	    (and json-encoding-pretty-print
		 (not (loop for x across arrays always (numberp x)))))
	   (json-encoding-separator (if json-encoding-pretty-print "," ", ")))
      (funcall encode array)))
  :config (advice-add 'json-encode-array :around #'my/json-array-of-numbers-on-one-line)
  (add-to-list 'major-mode-remap-alist '(json-mode . json-ts-mode)))

(use-package eldoc
  :ensure nil
  :init
  (global-eldoc-mode))

(use-package which-key
  :commands (which-key-mode)
  :init (which-key-mode))

(use-package eglot
  :ensure nil
  :init
  (setq eglot-stay-out-of '(flycheck))
  :bind (:map
	 eglot-mode-map
	 ("C-c c a" . eglot-code-actions)
	 ("C-c c o" . eglot-code-actions-organize-imports)
	 ("C-c c r" . eglot-rename)
	 ("C-c c f" . eglot-format))
)

(use-package flycheck
  :config
  (add-hook 'elpaca-after-init-hook #'global-flycheck-mode))

(use-package flycheck-eglot
  :after (flycheck eglot)
  :config
  (global-flycheck-eglot-mode 1))

(use-package corfu
  :init
  (global-corfu-mode)
  :config
  (add-to-list 'corfu-margin-formatters #'nerd-icons-corfu-formatter))

(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-defaults nil)
  (completion-category-overrides '((file (styles basic partial-completion))
				   (eglot (styles orderless))
				   (eglot-capf (styles orderless)))))

(use-package vertico
  :init
  (vertico-mode))

(use-package savehist
  :ensure nil
  :init
  (savehist-mode))

(use-package clipmon)

(use-package nerd-icons-dired
  :hook (dired-mode . nerd-icons-dired-mode))

(use-package nerd-icons-corfu)

(use-package corfu-candidate-overlay
  :after corfu
  :config
  (corfu-candidate-overlay-mode +1)
  (global-set-key (kbd "C-<tab>") 'completion-at-point)
  (global-set-key (kbd "<backtab>") 'corfu-candidate-overlay-complete-at-point))

(use-package marginalia
  :bind (:map minibuffer-local-map
	      ("M-A" . marginalia-cycle))
  :init
  (marginalia-mode))

(use-package nerd-icons-completion
  :after marginalia
  :config
  (nerd-icons-completion-mode)
  (add-hook 'marginalia-mode-hook #'nerd-icons-completion-marginalia-setup))

;;; init.el ends here
