(setq gc-cons-threshold (* 100 1024 1024))

(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
	(url-retrieve-synchronously
	 "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
	 'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(straight-use-package 'use-package)

(setq straight-use-package-by-default t)
(setq use-package-always-defer t)

(setq comp-async-report-warnings-errors nil)

;; (defun my/display-startup-time ()
;;   (message "⏱ Emacs loaded in %s with %d garbage collections."
;; 	   (format "%.2f seconds"
;; 		   (float-time
;; 		    (time-subtract after-init-time before-init-time)))
;; 	   gcs-done))

;; (add-hook 'emacs-startup-hook #'my/display-startup-time)

;; (setq use-package-verbose t)

(use-package no-littering
  :demand t
  :custom (auto-save-file-name-transforms
           `((".*" ,(no-littering-expand-var-file-name "auto-save/") t))))

(use-package auth-source
  :straight nil
  :demand t
  :custom
  (auth-sources '("~/.gnupg/shared/authinfo.gpg"
                  "~/.authinfo.gpg"
                  "~/.authinfo"
                  "~/.netrc")))

(setq-default
 ad-redefinition-action 'accept                      ; Silence warnings for redefinition.
 cursor-in-non-selected-windows t                    ;Hide the cursor in inactive windows.
 display-time-default-load-average nil               ; Don't display the load average.
 fill-column 120                                     ; Set width for automatic line break/wrap.
 help-window-select t                                ; Focus on new help windows when opened.
 indent-tabs-mode nil                                ; Use spaces over tabs.
 inhibit-startup-screen t                            ; Disable start-up screen.
 initial-scratch-message ""                          ; Clear the initial *scratch* buffer.
 kill-ring-max 128                                   ; Maximum length of the kill ring.
 mark-ring-max 128                                   ; Maximum length of the mark ring.
 load-prefer-newer t                                 ; Prefer the newest version of a file.
 read-process-output-max (* 1024 1024)               ; Increase the amount of data reads from the process.
 scroll-conservatively most-positive-fixnum          ; Always scroll by one line.
 select-enable-clipboard t                           ; Merge system's and Emacs' clipboards.
 tab-width 4                                         ; Set the width for tabs.
 user-full-name "Karolos Triantafyllou"              ; Set the full name of the current user.
 user-mail-address "karolos.triantafyllou@gmail.com" ; Set the email address of the current user.
 vc-follow-symlinks t                                ; Always follow the symlinks
 view-read-only t                                    ; Always open read-only buffers in view-mode.
 c-basic-offset 4                                    ; Set the base offset for C/C++.
 c-default-style "stroustrup")                       ; Set the default style of C/C++.
(global-display-line-numbers-mode t)                 ; Show line numbers.
(column-number-mode)                                 ; Show columns numbers in the modeline.
(fset 'yes-or-no-p 'y-or-n-p)                        ; Replace yes/no prompts with y/n.
(global-hl-line-mode)                                ; Highlight the current line.
(set-default-coding-systems 'utf-8)                  ; Set default encoding to UTF-8.
(show-paren-mode 1)                                  ; Show matching parentheses.
(set-fringe-mode 10)                                 ; Set the left and right width in pixels
;; Disable line numbers for some modes
(dolist (mode
         '(org-mode-hook
           term-mode-hook
           treemacs-mode-hook
           eshell-mode-hook
           vterm-mode-hook
           shell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

(when window-system
  (scroll-bar-mode -1)   ; Disable visible scrollbar
  (tool-bar-mode -1)     ; Disable the toolbar
  (tooltip-mode -1)      ; Disable tooltips
  (menu-bar-mode -1))     ; Disable menu bar

;; Set default font
(set-face-attribute 'default nil :font "Iosevka" :height 110)
;; Set fixed pitch face
(set-face-attribute 'fixed-pitch nil :font "Iosevka")
;; Set emoji font
(set-fontset-font t 'symbol (font-spec :family "Noto Color Emoji") nil 'prepend)
;; Set variable pitch face
(set-face-attribute 'variable-pitch nil :font "Cantarell" :weight 'regular :height 1.35)

;;(use-package mixed-pitch
;;    :hook (text-mode . mixed-pitch-mode))

(use-package ligature
  :straight (ligature :type git :host github :repo
                      "mickeynp/ligature.el" :branch "master")
  :demand t
  :config
  (ligature-set-ligatures 't '("www"))
  (ligature-set-ligatures 'eww-mode '("ff" "fi" "ffi"))
  (ligature-set-ligatures 'prog-mode '("|||>" "<|||" "<==>" "<!--" "####" "~~>" "***" "||=" "||>"
                                       ":::" "::=" "=:=" "===" "==>" "=!=" "=>>" "=<<" "=/=" "!=="
                                       "!!." ">=>" ">>=" ">>>" ">>-" ">->" "->>" "-->" "---" "-<<"
                                       "<~~" "<~>" "<*>" "<||" "<|>" "<$>" "<==" "<=>" "<=<" "<->"
                                       "<--" "<-<" "<<=" "<<-" "<<<" "<+>" "</>" "###" "#_(" "..<"
                                       "..." "+++" "/==" "///" "_|_" "www" "&&" "^=" "~~" "~@" "~="
                                       "~>" "~-" "**" "*>" "*/" "||" "|}" "|]" "|=" "|>" "|-" "{|"
                                       "[|" "]#" "::" ":=" ":>" ":<" "$>" "==" "=>" "!=" "!!" ">:"
                                       ">=" ">>" ">-" "-~" "-|" "->" "--" "-<" "<~" "<*" "<|" "<:"
                                       "<$" "<=" "<>" "<-" "<<" "<+" "</" "#{" "#[" "#:" "#=" "#!"
                                       "##" "#(" "#?" "#_" "%%" ".=" ".-" ".." ".?" "+>" "++" "?:"
                                       "?=" "?." "??" ";;" "/*" "/=" "/>" "//" "__" "~~" "(*" "*)"
                                       "\\\\" "://"))
  (global-ligature-mode t))

(use-package doom-themes
  :demand t
  :config
  (load-theme 'doom-nord t)
  (doom-themes-visual-bell-config)
  (setq doom-themes-treemacs-theme "doom-colors")
  (doom-themes-treemacs-config)
  (doom-themes-org-config))

(use-package solaire-mode
  :demand t
  :custom (solaire-mode-remap-fringe t)
  :config (solaire-global-mode))

(use-package doom-modeline
  :demand t
  :init (doom-modeline-mode)
  :custom
  (doom-modeline-icon (display-graphic-p))
  (doom-modeline-mu4e t)
  (mu4e-alert-enable-mode-line-display))

(use-package all-the-icons
  :if (display-graphic-p)
  :commands all-the-icons-install-fonts
  :config (unless (find-font (font-spec :name "all-the-icons"))
            (all-the-icons-install-fonts t))
  ;; Use 'prepend for the NS and Mac ports or Emacs will crash.
  (set-fontset-font t 'unicode (font-spec :family "all-the-icons") nil 'append)
  (set-fontset-font t 'unicode (font-spec :family "file-icons") nil 'append)
  (set-fontset-font t 'unicode (font-spec :family "Material Icons") nil 'append)
  (set-fontset-font t 'unicode (font-spec :family "github-octicons") nil 'append)
  (set-fontset-font t 'unicode (font-spec :family "FontAwesome") nil 'append)
  (set-fontset-font t 'unicode (font-spec :family "Weather Icons") nil 'append))

(use-package all-the-icons-dired
  :if (display-graphic-p)
  :hook (dired-mode . all-the-icons-dired-mode))

(use-package all-the-icons-completion
  :after (all-the-icons marginalia)
  :hook (marginalia-mode . all-the-icons-completion-marginalia-setup)
  :init
  (all-the-icons-completion-mode 1))

(use-package kind-icon
      :demand t
      :after corfu
      :custom
      (kind-icon-default-face 'corfu-default) ; to compute blended backgrounds correctly
      :config
      (add-to-list 'corfu-margin-formatters #'kind-icon-margin-formatter))

(use-package vertico
    :straight (:files (:defaults "extensions/*"))
    :init (vertico-mode)
    :bind (:map vertico-map
                ("C-<backspace>" . vertico-directory-up))
    :custom (vertico-cycle t)
    :custom-face (vertico-current ((t (:background "#1d1f21")))))

  ;;(use-package vertico-directory
;;    :after (vertico)
    ;;:straight nil
    ;;:bind (:map vertico-map
                ;;("C-<backspace>" . vertico-directory-up)))

(use-package marginalia
  :after vertico
  :init (marginalia-mode)
  :bind (:map minibuffer-local-map
              ("M-A" . marginalia-cycle))
  :custom
  (marginalia-annotators '(marginalia-annotators-heavy marginalia-annotators-light nil)))

(use-package orderless
  :after (vertico marginalia)
  :custom
  (completion-category-defaults nil)
  (completion-category-overrides '((file (styles . (partial-completion)))))
  (completion-styles '(orderless)))

(use-package consult
  :after (projectile)
  :bind (;; Related to control commands
         ("<help> a" . consult-apropos)
         ("C-x b" . consult-buffer)
         ("C-x M-:" . consult-complex-command)
         ("C-c k" . consult-kmacro)
         ;; Related to navigation
         ("M-g a" . consult-org-agenda)
         ("M-g e" . consult-error)
         ("M-g g" . consult-goto-line)
         ("M-g h" . consult-org-heading)
         ("M-g i" . consult-imenu)
         ("M-g k" . consult-global-mark)
         ("M-s l" . consult-line)
         ("M-g m" . consult-mark)
         ("M-g o" . consult-outline)
         ("M-g I" . consult-project-imenu)
         ;; Related to search and selection
         ("M-s G" . consult-git-grep)
         ("M-s g" . consult-grep)
         ("M-s k" . consult-keep-lines)
         ("M-s l" . consult-locate)
         ("M-s m" . consult-multi-occur)
         ("M-s r" . consult-ripgrep)
         ("M-s u" . consult-focus-lines)
         ("M-s f" . consult-find))
  :custom
  (completion-in-region-function #'consult-completion-in-region)
  (consult-narrow-key "<")
  (consult-project-root-function #'projectile-project-root)
  ;; Provides a consistent display for both '=consult-register=' and the register preview when editin registers.
  (register-preview-delay 0)
  (register-preview-function #'consult-register-preview))

(use-package embark
  :bind ("C-." . embark-act))

(use-package embark-consult
  :after (embark consult)
  :demand t
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))

(use-package corfu
  ;; Optional customizations
  :custom
  (corfu-cycle t)                ;; Enable cycling for 'corfu-next/previous'
  (corfu-auto t)                 ;; Enable auto completion
  ;; (corfu-separator ?\s)          ;; Orderless field separator
  ;; (corfu-quit-no-match nil)      ;; Never quit, even if there is no match
  ;; (corfu-preview-current nil)    ;; Disable current candidate preview
  ;; (corfu-preselect-first nil)    ;; Disable candidate preselection
  ;; (corfu-on-exact-match nil)     ;; Configure handling of exact matches
  ;; (corfu-echo-documentation nil) ;; Disable documentation in the echo area
  ;; (corfu-scroll-margin 5)        ;; Use scroll margin

  ;; You may want to enable Corfu only for certain modes.
  ;; :hook ((prog-mode . corfu-mode)
  ;;        (shell-mode . corfu-mode)
  ;;        (eshell-mode . corfu-mode))

  ;; Recommended: Enable Corfu globally.
  ;; This is recommended since dabbrev can be used globally (M-/).
  :init
  (global-corfu-mode))

(use-package cape
  ;; Bind dedicated completion commands
  :bind (("C-c c p" . completion-at-point) ;; capf
         ("C-c c t" . complete-tag)        ;; etags
         ("C-c c d" . cape-dabbrev)        ;; or dabbrev-completion
         ("C-c c f" . cape-file)
         ("C-c c k" . cape-keyword)
         ("C-c c s" . cape-symbol)
         ("C-c c a" . cape-abbrev)
         ("C-c c i" . cape-ispell)
         ("C-c c l" . cape-line)
         ("C-c c w" . cape-dict)
         ("C-c c \\" . cape-tex)
         ("C-c c _" . cape-tex)
         ("C-c c ^" . cape-tex)
         ("C-c c &" . cape-sgml)
         ("C-c c r" . cape-rfc1345))
  :init
  ;; Add 'completion-at-point-functions', used by 'completion-at-point'.
  (add-to-list 'completion-at-point-functions #'cape-file)
  (add-to-list 'completion-at-point-functions #'cape-tex)
  (add-to-list 'completion-at-point-functions #'cape-dabbrev)
  (add-to-list 'completion-at-point-functions #'cape-keyword)
  ;;(add-to-list 'completion-at-point-functions #'cape-sgml)
  ;;(add-to-list 'completion-at-point-functions #'cape-rfc1345)
  ;;(add-to-list 'completion-at-point-functions #'cape-abbrev)
  ;;(add-to-list 'completion-at-point-functions #'cape-ispell)
  ;;(add-to-list 'completion-at-point-functions #'cape-dict)
  ;;(add-to-list 'completion-at-point-functions #'cape-symbol)
  ;;(add-to-list 'completion-at-point-functions #'cape-line)
  )

(use-package lsp-mode
  :custom (lsp-completion-provider :none) ;; We use corfu
  :init
  (defun my/orderless-dispatch-flex-first (_pattern index _total)
    (and (eq index 0) 'orderless-flex))
  (defun my/lsp-mode-setup-completion ()
    (setf (alist-get 'styles (alist-get 'lsp-capf completion-category-defaults))
          '(orderless)))
  (add-hook 'orderless-style-dispatchers #'my/orderless-dispatch-flex-first nil 'local)
  (setq-local completion-at-point-functions (list (cape-capf-buster #'lsp-completion-at-point)))
  :commands (lsp lsp-deferred)
  :hook ((prog-mode . lsp-deferred)
         (lsp-mode . lsp-enable-which-key-integration)
         (lsp-completion-mode . my/lsp-mode-setup-completion))
  :custom
  (lsp-server-install-dir (expand-file-name (format "%s/etc/lsp" user-emacs-directory)))
  (lsp-keymap-prefix "C-c ;"))

(use-package lsp-ui
  :hook (lsp-mode . lsp-ui-mode))

(use-package lsp-treemacs
  :after lsp)

(use-package dap-mode
  :after lsp-mode
  :config (dap-mode t)
  (dap-ui-mode t))

(require 'dap-cpptools)
(require 'dap-lldb)

(use-package consult-lsp
  :after (consult lsp)
  :commands (consult-lsp-diagnostics consult-lsp-symbols))

(use-package emacs
  :straight nil
  :demand t
  :init
  (setq completion-cycle-threshold 3)
  (setq completion-prefix-min-length 1)
  (setq read-extended-command-predicate
        #'command-completion-default-include-p)
  (setq tab-always-indent 'complete))

(use-package meson-mode)

(use-package dired
  :straight nil
  :commands (dired dired-jump)
  :bind (:map dired-mode-map
	      ("h" . dired-up-directory)
	      ("j" . dired-next-line)
	      ("k" . dired-previous-line)
	      ("l" . dired-single-buffer))
  :delight "Dired"
  :custom
  (dired-auto-revert-buffer t)
  (dired-dwim-target t)
  (dired-hide-details-hide-symlink-targets nil)
  (dired-listing-switches "-alh --group-directories-first")
  (dired-ls-F-marks-symlinks nil)
  (dired-recursive-copies 'always))

(use-package dired-subtree
  :after dired
  :bind (:map dired-mode-map
	      ("<tab>" . dired-subtree-toggle)))

(use-package dired-single
  :after dired
  :bind (:map dired-mode-map
	      ([remap dired-find-file] . dired-single-buffer)
	      ([remap dired-up-directory] . dired-single-up-directory)
	      ("M-DEL" . dired-prev-subdir)))

(use-package dired-hide-dotfiles
  :hook (dired-mode . dired-hide-dotfiles-mode)
  :bind (:map dired-mode-map
	      ("H" . dired-hide-dotfiles-mode)))

(use-package dired-open
  :after (dired dired-jump)
  :custom (dired-open-extensions '(("mp4" . "mpv"))))

(use-package dired-narrow
  :straight nil
  :bind (("C-c C-n" . dired-narrow)
         ("C-c C-f" . dired-narrow-fuzzy)))

(use-package ibuffer
  :demand t
  :preface
  (defvar protected-buffers '("*scratch*" "*Messages*")
    "Buffers that cannot be killed.")
  (defun my/protected-buffers ()
    "Protects some buffers from being killed."
    (dolist (buffer protected-buffers)
  (with-current-buffer buffer
    (emacs-lock-mode 'kill)))))

(use-package imenu
  :straight nil
  :preface
  (defun my/smarter-move-beginning-of-line (arg)
    "Move point back to indentation of beginning of line.

 Move point to the first non-whitespace character on this line.
 If point is already there, move to the beginning of the line.
 Effectively toggle between the first non-whitespace character and
 the beginning of the line.

 If ARG is not nil or 1, move forward ARG - 1 lines first. If
 point reaches the beginning or end of the buffer, stop there."
    (interactive "^p")
    (setq arg (or arg 1))

    ;; Move lines first
    (when (/= arg 1)
      (let ((line-move-visual nil))
        (forward-line (1- arg))))

    (let ((orig-point (point)))
      (back-to-indentation)
      (when (= orig-point (point))
        (move-beginning-of-line 1))))
  :bind (("C-a" . my/smarter-move-beginning-of-line)
         ("C-r" . imenu)))

(use-package move-text
  :bind (("M-p" . move-text-up)
         ("M-n" . move-text-down))
  :config (move-text-default-bindings))

(use-package autorevert
  :straight nil
  :demand t
  :delight auto-revert-mode
  :bind ("C-x R" . revert-buffer)
  :custom (auto-revert-verbose nil)
  :config (global-auto-revert-mode))

(use-package window
  :straight nil
  :demand t
  :bind (("C-x 3" . hsplit-last-buffer)
         ("C-x 2" . vsplit-last-buffer)
         ;; Don't ask before killing a buffer.
         ([remap kill-buffer] . kill-this-buffer))
  :preface
  (defun hsplit-last-buffer ()
    "Gives the focus to the last created horizontal window."
    (interactive)
    (split-window-horizontally)
    (other-window 1))
  (defun vsplit-last-buffer ()
    "Gives the focus to the last created vertical window."
    (interactive)
    (split-window-vertically)
    (other-window 1)))

(use-package centered-window
  :demand t
  :custom
  (cwm-centered-window-width 140)
  (cwm-frame-internal-border 0)
  (cwm-incremental-padding t)
  (cwm-incremental-padding-% 2)
  (cwm-left-fringe-ratio 0)
  (cwm-use-vertical-padding t)
  :config (centered-window-mode t))

(use-package switch-window
    :bind (("C-x o" . switch-window)
           ("C-x w" . switch-window-then-swap-buffer)))

(use-package winner
  :straight nil
  :demand t
  :config (winner-mode))

(use-package term
  :commands term
  :config
  (setq explicit-shell-file-name "zsh")
  (setq term-prompt-regexp "^[^#$%>\n]*[#$%>] *"))

(use-package eterm-256color
  :hook (term-mode . eterm-256color-mode))

(use-package vterm
  :commands vterm
  :config
  (setq term-prompt-regexp "^[^#$%>\n]*[#$%>] *")
  (setq vterm-shell "zsh")
  (setq vterm-max-scrollback 10000))

(use-package eshell)

(use-package abbrev
  :straight nil
  :delight
  :hook (text-mode . abbrev-mode)
  :config
  (if (file-exists-p abbrev-file-name)
      (quietly-read-abbrev-file)))

(use-package flyspell
  :straight nil
  :delight
  :hook ((text-mode . flyspell-mode)
         (prog-mode . flyspell-prog-mode))
  :custom
  ;; Add correction to abbreviation table.
  (flyspell-abbrev-p t)
  (flyspell-default-dictionary "en_US")
  (flyspell-issue-message-flag nil)
  (flyspell-issue-welcome-flag nil))

(use-package ispell
  :preface
  (defun my/switch-language ()
    "Switches between the English and Greek language for ispell, flyspell and LanguageTool."
    (interactive)
    (let* ((current-dictionary ispell-current-dictionary)
           (new-dictionary (if (string= current-dictionary "en_US") "el_GR" "en_US")))
      (ispell-change-dictionary new-dictionary)
      (if (string= new-dictionary "el_GR")
          (progn
            (setq lsp-ltex-language "el"))
        (progn
          (setq lsp-ltex-language "en-US")))
      (flyspell-buffer)
      (message "[✓] Dictionary switched to %s" new-dictionary)))
  :custom
  (ispell-hunspell-dict-paths-alist
 '(("en_US" "/usr/share/hunspell/en_US.aff")
   ("el_GR" "/usr/share/hunspell/el_GR.aff")))
;; Save words in personal dictionary without asking
(ispell-silently-savep t)
:config
(setenv "LANG" "en_US")
(cond ((executable-find "hunspell")
       (setq ispell-program-name "hunspell")
       (setq ispell-local-dictionary-alist '(("en_US"
                                              "[[:alpha:]]"
                                              "[^[:alpha:]]"
                                              "['’-]"
                                              t
                                              ("-d" "en_US")
                                              nil
                                              utf-8)
                                             ("el_GR" "[[:alpha:]ΒΓΔΖΘΛΞΠΣΦΨΩαάβγδεέζηήθιίϊκλμνξοόπρσςτυύϋφχψωώ]" "[^[:alpha:]ΒΓΔΖΘΛΞΠΣΦΨΩαάβγδεέζηήθιίϊκλμνξοόπρσςτυύϋφχψωώ]"
                                              "['’-]"
                                              t
                                              ("-d" "el_GR")
                                              nil
                                              utf-8))))
      ((executable-find "aspell")
       (setq ispell-program-name "aspell")
       (setq ispell-extra-args '("--sug-mode=ultra"))))
;; Ignore file sections for spell checking.
(add-to-list 'ispell-skip-region-alist '("#\\+begin_align" . "#\\+end_align"))
(add-to-list 'ispell-skip-region-alist '("#\\+begin_align*" . "#\\+end_align*"))
(add-to-list 'ispell-skip-region-alist '("#\\+begin_equation" . "#\\+end_equation"))
(add-to-list 'ispell-skip-region-alist '("#\\+begin_equation*" . "#\\+end_equation*"))
(add-to-list 'ispell-skip-region-alist '("#\\+begin_example" . "#\\+end_example"))
(add-to-list 'ispell-skip-region-alist '("#\\+begin_labeling" . "#\\+end_labeling"))
(add-to-list 'ispell-skip-region-alist '("#\\+begin_src" . "#\\+end_src"))
(add-to-list 'ispell-skip-region-alist '("\\$" . "\\$"))
(add-to-list 'ispell-skip-region-alist '(org-property-drawer-re))
(add-to-list 'ispell-skip-region-alist '(":\\(PROPERTIES\\|LOGBOOK\\):" . ":END:")))

(use-package lsp-ltex
  :init
  (setq lsp-ltex-version "15.2.0")
  :custom
  ;;(lsp-ltex-enabled nil)
  (lsp-ltex-mother-tongue "en-US"))

(use-package sh-script
  :straight nil
  :hook (after-save . executable-make-buffer-file-executable-if-script-p))

(use-package cmake-mode
  :hook (cmake-mode . lsp-deferred)
  :mode ("CMakeLists\\.txt\\'" "\\.cmake\\'"))

(use-package cmake-font-lock
  :hook (cmake-mode . cmake-font-lock-activate))

(use-package cmake-ide
:after projectile
:init (cmake-ide-setup)
;; :hook (c++-mode . my/cmake-ide-find-project)
:preface
(defun my/cmake-ide-find-project ()
  "Find the directory of the project for cmake-ide."
  (with-eval-after-load 'projectile
    (setq cmake-ide-project-dir (projectile-project-root))
    (setq cmake-ide-build-dir (concat cmake-ide-project-dir "build")))
  (setq cmake-ide-compile-command
        (concat "cd " cmake-ide-build-dir " && cmake .. && make"))
  (cmake-ide-load-db))

(defun my/switch-to-compilation-window ()
  "Switch to the *compilation* buffer after compilation."
  (other-window 1))
:bind ([remap comment-region] . cmake-ide-compile)
:config (advice-add 'cmake-ide-compile :after #'my/switch-to-compilation-window))

(use-package csv-mode :mode ("\\.\\(csv\\|tsv\\)\\'"))

(use-package dart-mode
  :after projectile
  :mode "\\.dart\\'"
  :config
  (add-to-list 'projectile-project-root-files-bottom-up "pubspec.yaml")
  (add-to-list 'projectile-project-root-files-bottom-up "BUILD"))

(use-package lsp-dart
  :hook (dart-mode . lsp-deferred)
  :custom
  (lsp-dart-dap-flutter-hot-reload-on-save t)
  (lsp-dart-sdk-dir "/opt/flutter/bin/cache/dart-sdk/"))

(use-package dockerfile-mode :delight "δ" :mode "Dockerfile\\'")

(use-package gnuplot
  :mode "\\.\\(gp\\|gpi\\|plt\\)'"
  :bind (:map gnuplot-mode-map
              ("C-c C-c" . gnuplot-send-buffer-to-gnuplot)))

(use-package ini-mode :mode "\\.ini\\'")

(use-package lsp-java
  :hook (java-mode . lsp-deferred))

(use-package gradle-mode
  :hook (java-mode . gradle-mode)
  :preface
  (defun my/switch-to-compilation-window ()
    "Switch to the *compilation* buffer after compilation."
    (other-window 1))
  :bind (:map gradle-mode-map
              ("C-c C-c" . gradle-build)
              ("C-c C-t" . gradle-test))
  :config
  (advice-add 'gradle-build :after #'my/switch-to-compilation-window)
  (advice-add 'gradle-test :after #'my/switch-to-compilation-window))

(use-package js2-mode
  :mode "\\.js\\'"
  :hook ((js2-mode . js2-imenu-extras-mode)
         (js2-mode . prettier-js-mode))
  :custom (js-indent-level 2)
  :config (flycheck-add-mode 'javascript-eslint 'js2-mode))

(use-package prettier-js
  :delight
  :custom (prettier-js-args '("--print-width" "100"
                              "--single-quote" "true"
                              "--trailing-comma" "all")))

(use-package js2-refactor
  :hook (js2-mode . js2-refactor-mode)
  :bind (:map js2-mode-map
              ("C-k" . js2r-kill)
              ("M-." . lsp-find-definition)))

(use-package yarn-mode :mode "yarn\\.lock\\'")

(use-package json-mode
  :delight "J "
  :mode "\\.json\\'"
  :hook (before-save . my/json-mode-before-save-hook)
  :preface
  (defun my/json-mode-before-save-hook ()
    (when (eq major-mode 'json-mode)
      (json-pretty-print-buffer)))

  (defun my/json-array-of-numbers-on-one-line (encode array)
    "Prints the arrays of numbers in one line."
    (let* ((json-encoding-pretty-print
            (and json-encoding-pretty-print
                 (not (loop for x across array always (numberp x)))))
           (json-encoding-seperator (if json-encoding-pretty-print "," ", ")))
      (funcall encode array)))
  :config (advice-add 'json-encode-array :around #'my/json-array-of-numbers-on-one-line))

(use-package lua-mode :delight "Λ" :mode "\\.lua\\'")

(use-package markdown-mode
:delight "μ"
:mode ("\\.\\(md\\|markdown\\)\\'")
:custom (markdown-command "/usr/bin/pandoc"))

(use-package markdown-preview-mode
:commands markdown-preview-mode
:custom
(markdown-preview-javascript
 (list (concat "https://github.com/highlightjs/highlight.js/"
               "9.15.6/highlight.min.js")
       "<script>
          $(document).on('mdContentChange', function() {
            $('pre code').each(function(i, block)  {
              hljs.highlightBlock(block);
            });
          });
        </script>"))
(markdown-preview-stylesheets
 (list (concat "https://cdnjs.cloudflare.com/ajax/libs/github-markdown-css/"
               "3.0.1/github-markdown.min.css")
       (concat "https://github.com/highlightjs/highlight.js/"
               "9.15.6/styles/github.min.css")

       "<style>
          .markdown-body {
            box-sizing: border-box;
            min-width: 200px;
            max-width: 980px;
            margin: 0 auto;
            padding: 45px;
          }

          @media (max-width: 767px) { .markdown-body { padding: 15px; } }
        </style>")))

;;(use-package web-mode
;;    :delight ""
  ;;  :preface
    ;; (defun enable-minor-mode (my-pair)
    ;;   "Enable minor mode if filename match the regexp."
    ;;   (if (buffer-file-name)
    ;;       (if (string-match (car my-pair) buffer-file-name)
    ;;           (funcall (cdr my-pair)))))
    ;; :mode ("\\.\\(html\\|jsx\\|php\\|css\\)\\'" . web-mode)
    ;; :hook (web-mode . (lambda ()
    ;;                     (enable-minor-mode
    ;;                      '("\\.jsx?\\'" . prettier-js-mode))))
    ;;
    ;; (defun my/web-mode-hook ()
    ;;   "Hooks for web-mode."
    ;;   (setq web-mode-markup-indent-offset 2)
    ;;   (setq web-mode-attr-indent-offset 2)
    ;;   (setq web-mode-block-padding 2)
    ;;   (setq web-mode-css-indent-offset 2)
    ;;   (setq web-mode-code-indent-offset 2)
    ;;   (setq web-mode-comment-style 2))
    ;; :hook (web-mode . my/web-mode-hook)
    ;; :config
    ;; (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
    ;; (add-to-list 'auto-mode-alist '("\\.css?\\'" . web-mode))
    ;; (setq web-mode-enable-current-element-highlight t)
    ;; )

(use-package python
  :delight "π"
  :preface
  (defun python-remove-unused-imports()
    "Remove unused imports and unused variables with autoflake."
    (interactive)
    (if (executable-find "autoflake")
        (progn
          (shell-command (format "autoflake --remove-all-unused-imports -i %s"
                                 (shell-quote-argument (buffer-file-name))))
          (revert-buffer t t t))
      (warn "[✗] python-mode: Cannot find autoflake executable.")))
  :bind (:map python-mode-map
              ("M-[" . python-nav-backward-block)
              ("M-]" . python-nav-forward-block)
              ("M-|" . python-remove-unused-imports))
  :custom
  (flycheck-pylintrc "~/.pylintrc")
  (flycheck-python-pylint-executable "/usr/bin/pylint"))

(use-package lsp-pyright
  :if (executable-find "pyright")
  ;; To properly load 'lsp-pyright', the 'require' instruction is important.
  :hook (python-mode . (lambda ()
                         (require 'lsp-pyright)
                         (lsp-deferred)))
  :custom
  (lsp-pyright-python-executable-cmd "python3")
  (lsp-pyright-venv-path "~/.cache/pypoetry/virtualenvs/"))

(use-package blacken
  :delight
  :hook (python-mode . blacken-mode)
  :custom (blacken-line-length 79))

(use-package py-isort
  :hook ((before-save . py-isort-before-save)
         (python-mode . pyvenv-mode)))

(use-package pyvenv
  :after python
  :custom
  (pyvenv-default-virtual-env-name (expand-file-name (format "%s/myenv/" xdg-data)))
  (pyvenv-workon (expand-file-name (format "%s/myenv/" xdg-data)))
  :config (pyvenv-tracking-mode))

(use-package pyenv-mode
  :hook ((python-mode . pyenv-mode)
         (projectile-switch-project . projectile-pyenv-mode-set))
  :custom (pyenv-mode-set "3.8.5")
  :preface
  (defun projectile-pyenv-mode-set ()
    "Set pyenv version matching project name."
    (let ((project (projectile-project-name)))
      (if (member project (pyenv-mode-versions))
          (pyenv-mode-set project)
        (pyenv-mode-unset)))))

;;(use-package css-mode
;;    :after flycheck
    ;;:mode "\\.css\\'"
    ;;:custom (css-indent-offset 2))

(use-package typescript-mode
  :hook ((typescript-mode . prettier-js-mode)
       (typescript-mode . lsp-deferred))
:mode ("\\.\\(ts\\|tsx\\)\\'")
:custom
;; TSLint is depreciated in favor of ESLint.
(flycheck-disable-checker 'typescript-tslint)
(lsp-clients-typescript-server-args '("--stdio" "--tsserver-log-file" "/dev/stderr"))
(typescript-indent-level 2)
:config
(flycheck-add-mode 'javascript-eslint 'typescript-mode))

(use-package nxml-mode
:straight nil
:hook (nxml-mode . lsp-deferred)
:mode ("\\.\\(xml\\|xsd\\|wsdl\\)\\'"))

(use-package yaml-mode
:delight "ψ"
:hook (yaml-mode . lsp-deferred)
:mode ("\\.\\(yaml\\|yml\\)\\'"))

(use-package browse-url
  :straight nil
  :custom
  (browse-url-browser-function 'browse-url-generic)
  (browse-url-generic-program "firefox"))

(use-package calc
  :straight nil
  :custom
  (math-additional-units
   '((GiB "1024 * MiB" "Giga Byte")
     (MiB "1024 * KiB" "Mega Byte")
     (KiB "1024 * B" "Kilo Byte")
     (B nil "Byte")
     (Gib "1024 * Mib" "Giga Bit")
     (Mib "1024 * Kib" "Mega Bit")
     (Kib "1024 * b" "Kilo Bit")
     (b "B / 8" "Bit")))
  ;; Resets the calc's cache
  (math-units-table nil))

(use-package calendar
  :straight nil
  :bind ("C-c 0" . calendar)
  :custom
  (calendar-mark-holidays-flag t)
  (calendar-week-start-day 1))

(use-package holidays
  :straight nil
  :custom
  (holiday-bahai-holidays nil)
  (holiday-hebrew-holidays nil)
  (holiday-islamic-holidays nil)
  (holiday-oriental-holidays nil)
  (holiday-christian-holidays
   '((holiday-fixed 1 6 "Epiphany")
     (holiday-fixed 2 2 "Candlemas")
     (holiday-easter-etc -47 "Mardi Gras")
     (holiday-easter-etc 0 "Easter Day")
     (holiday-easter-etc 1 "Easter Monday")
     (holiday-easter-etc 39 "Ascension")
     (holiday-easter-etc 49 "Pentecost")
     (holiday-fixed 8 15 "Assumption")
     (holiday-fixed 11 1 "All Saints' Day")
     (holiday-fixed 11 2 "Day Of The Dead")
     (holiday-fixed 11 22 "Saint Cecilia's Day")
     (holiday-fixed 12 1 "Saint Eloi's Day")
     (holiday-fixed 12 4 "Saint Barbara")
     (holiday-fixed 12 6 "Saint Nicholas Day")
     (holiday-fixed 12 25 "Christmas Day")))
  (holiday-general-holidays
   '((holiday-fixed 1 1 "New Year's Day")
     (holiday-fixed 2 14 "Valentine's Day")
     (holiday-fixed 3 8 "International Women's Day")
     (holiday-fixed 10 31 "Halloween")
     (holiday-fixed 11 11 "Armistice of 1918")))
  ;; Need to fix these
  (holiday-local-holidays
   '((holiday-fixed 5 1 "Labor Day")
     (holiday-float 3 0 0 "Grandmothers' Day")
     (holiday-float 4 4 3 "Secretary's Day")
     (holiday-float 5 0 2 "Mother's Day")
     (holiday-float 6 0 3 "Father's Day"))))

(use-package rainbow-mode
  :delight
  :hook ((prog-mode text-mode) . rainbow-mode))

(use-package dashboard
  :demand t
  :custom
  (dashboard-banner-logo-title "With Great Power Comes Great Responsibility")
  (dashboard-center-content t)
  (dashboard-items '((agenda)
                     (projects . 10)))
  (dashboard-projects-switch-function 'projectile-persp-switch-project)
  (dashboard-set-file-icons t)
  (dashboard-set-footer nil)
  (dashboard-set-heading-icons t)
  (dashboard-set-navigator t)
  (dashboard-startup-banner 'logo)
  :config (dashboard-setup-startup-hook))

(use-package which-key
  :init (which-key-mode)
  :delight
  :custom (which-key-idle-delay 0.5))

(use-package helpful
  :commands (helpful-at-point
             helpful-callable
             helpful-command
             helpful-function
             helpful-key
             helpful-macro
             helpful-variable)
  :bind
  ([remap display-local-help] . helpful-at-point)
  ([remap describe-function] . helpful-callable)
  ([remap describe-variable] . helpful-variable)
  ([remap describe-symbol] . helpful-symbol)
  ([remap describe-key] . helpful-key)
  ([remap describe-command] . helpful-command))

(use-package aggressive-indent
  :custom (aggressive-indent-comments-too t))

(use-package highlight-indent-guides
  :hook (prog-mode . highlight-indent-guides-mode)
  :custom (highlight-indent-guides-method 'character))

(use-package flycheck
  :delight
  :hook ((lsp-mode . flycheck-mode)
         (prog-mode . flycheck-mode))
  :bind (:map flycheck-mode-map
              ("M-'" . flycheck-previous-error)
              ("M-\\" . flycheck-next-error))
  :custom
  (flycheck-display-errors-delay 0.3)
  (flycheck-stylelintrc "~/.stylelintrc.json")
  (flycheck-scss-stylelint-executable "~/node_modules/stylelint/bin/stylelint.js"))

(use-package faces
  :straight nil
  :custom (show-paren-delay 0)
  :config
  (set-face-background 'show-paren-match "#161719")
  (set-face-bold 'show-paren-match t)
  (set-face-foreground 'show-paren-match "#ffffff"))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package smartparens
  :delight
  :hook (prog-mode . smartparens-mode)
  :bind (("M-'" . sp-backward-sexp)
         ("M-\\" . sp-forward-sexp)
         ("M-(" . sp-wrap-round)
         ("M-[" . sp-wrap-curly))
  :custom (sp-escape-quotes-after-insert nil))

(use-package pdf-tools
  :magic ("%PDF" . pdf-view-mode)
  :init (pdf-tools-install :no-query))

(use-package pdf-view
  :straight nil
  :after pdf-tools
  :bind (:map pdf-view-mode-map
              ("C-s" . isearch-forward)
              ("d" . pdf-annot-delete)
              ("h" . pdf-annot-add-highlight-markup-annotation)
              ("t" . pdf-annot-add-text-annotation))
  :custom
  (pdf-view-display-size 'fit-page)
  (pdf-view-resize-factor 1.1)
  ;; Avoid searching for unicodes to speed up pdf-tools.
  (pdf-view-use-unicode-ligther nil)
  ;; Enable HiDPI support, at the cost of memory.
  (pdf-view-use-scaling t))

(use-package projectile
  ;;:demand t
  :delight (projectile-mode)
  :config (projectile-mode)
  :custom
  (projectile-enable-caching t)
  (projectile-keymap-prefix (kbd "C-c C-p"))
  (projectile-mode-line '(:eval (projectile-project-name)))
  (projectile-project-search-path '("~/Programming"))
  (projectile-switch-project-action #'projectile-dired)
  :config (projectile-global-mode))

(use-package consult-projectile
  :after (consult projectile)
  :straight (consult-projectile :type git :host gitlab :repo
                "OlMon/consult-projectile" :branch "master")
  :commands (consult-projectile))

(use-package ibuffer-projectile
  :after (ibuffer projectile)
  :preface
  (defun my/ibuffer-projectile ()
    (ibuffer-projectile-set-filter-groups)
    (unless (eq ibuffer-sorting-mode 'alphabetic)
      (ibuffer-do-sort-by-alphabetic)))
  :hook (ibuffer . my/ibuffer-projectile))

(use-package perspective
  :demand t
  :custom (persp-mode-prefix-key (kbd "C-c M-p"))
  :init (persp-mode))

(use-package persp-projectile
  :after (perspective))

(use-package yasnippet-snippets
    :after yasnippet
    :config (yasnippet-snippets-initialize))

(use-package yasnippet
  :demand t
  :delight yas-minor-mode "υ"
  :hook (yas-minor-mode . my/disable-yas-if-no-snippets)
  :config (yas-global-mode)
  :preface
  (defun my/disable-yas-if-no-snippets ()
    (when (and yas-minor-mode (null (yas--get-snippet-tables)))
      (yas-minor-mode -1))))

(use-package consult-yasnippet
  :straight (consult-yasnippet
             :type git
             :host github
             :repo "mohkale/consult-yasnippet")
  :bind ("C-c y" . consult-yasnippet))

(use-package magit
    :commands magit-status
    :custom
    (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))

(use-package git-commit
  :straight nil
  :preface
  (defun my/git-commit-auto-fill-everywhere ()
    "Ensures that the commit body does not exceed 72 characters."
    (setq fill-column 72)
    (setq-local comment-auto-fill-only-comments nil))
  :hook (git-commit-mode . my/git-commit-auto-fill-everywhere)
  :custom (git-commit-summary-max-length 50))

(use-package smerge-mode
  ;;:after hydra
  :delight "∓"
  :commands smerge-mode
  :bind (:map smerge-mode-map
              ("M-g n" . smerge-next)
              ("M-g p" . smerge-prev))
  ;;:hook (magit-diff-visit-file . hydra-merge/body)
  )

(use-package git-gutter
  :delight
  :config (global-git-gutter-mode))

  ;; Might use forge for magit
  ;; (use-package forge)

(use-package simple
  :straight nil
  :delight (auto-fill-function)
  :preface
  (defun my/kill-region-or-line ()
    "When called interactively with no active region, kill the whole line."
    (interactive)
    (if current-prefix-arg
        (progn
          (kill-new (buffer-string))
          (delete-region (point-min) (point-max)))
      (progn (if (use-region-p)
                 (kill-region (region-beginning) (region-end) t)
               (kill-region (line-beginning-position) (line-beginning-position 2))))))
  :hook ((before-save . delete-trailing-whitespace)
         ((prog-mode text-mode) . turn-on-auto-fill))
  :bind ("C-w" . my/kill-region-or-line)
  :custom (set-mark-command-repeat-pop t))

(use-package hungry-delete
  :demand t
  :delight
  :config (global-hungry-delete-mode))

(use-package undo-tree
  :delight
  ;;:bind ("C--" . undo-tree-redo)
  :init (global-undo-tree-mode)
  :custom
  (undo-tree-visualizer-timestamps t)
  (undo-tree-visualizer-diff t))

(use-package hydra
  :bind (("C-c I" . hydra-image/body)
         ("C-c L" . hydra-ledger/body)
         ("C-c M" . hydra-merge/body)
         ("C-c T" . hydra-tool/body)
         ("C-c b" . hydra-btoggle/body)
         ("C-c c" . hydra-clock/body)
         ("C-c f" . hydra-flycheck/body)
         ("C-c g" . hydra-go-to-file/body)
         ("C-c m" . hydra-magit/body)
         ("C-c o" . hydra-org/body)
         ("C-c p" . hydra-projectile/body)
         ("C-c s" . hydra-spelling/body)
         ("C-c t" . hydra-tex/body)
         ("C-c u" . hydra-upload/body)
         ("C-c w" . hydra-windows/body)))

(use-package major-mode-hydra
  :after hydra
  :preface
  (defun with-alltheicon (icon str &optional height v-adjust face)
    "Display an icon from all-the-icons."
    (s-concat (all-the-icons-alltheicon icon :v-adjust (or v-adjust 0) :height (or height 1) :face face) " " str))
  (defun with-faicon (icon str &optional height v-adjust face)
    "Display an icon from Font Awesome."
    (s-concat (all-the-icons-faicon icon :v-adjust (or v-adjust 0) :height (or height 1) :face face) " " str))
  (defun with-fileicon (icon str &optional height v-adjust face)
    "Display an icon from Atome File Icons."
    (s-concat (all-the-icons-fileicon icon :v-adjust (or v-adjust 0) :height (or height 1) :face face) " " str))
  (defun with-octicon (icon str &optional height v-adjust face)
    "Display an icon from GitHub Octicons."
    (s-concat (all-the-icons-octicon icon :v-adjust (or v-adjust 0) :height (or height 1) :face face) " " str))
  )

(pretty-hydra-define hydra-btoggle
(:hint nil :color amaranth :quit-key "q" :title (with-faicon "toggle-on" "Toggle" 1 -0.05))
("Basic"
 (("a" abbrev-mode "abbrev" :toggle t)
  ("h" global-hungry-delete-mode "hungry delete" :toggle t))
 "Coding"
 (("e" electric-operator-mode "electric operator" :toggle t)
  ("F" flyspell-mode "flyspell" :toggle t)
  ("f" flycheck-mode "flycheck" :toggle t)
  ("l" lsp-mode "lsp" :toggle t)
  ("s" smartparens-mode "smartparens" :toggle t))
 "UI"
 (("i" ivy-rich-mode "ivy-rich" :toggle t))))

(pretty-hydra-define hydra-clock
(:hint nil :color teal :quit-key "q" :title (with-faicon "clock-o" "Clock" 1 -0.05))
("Action"
 (("c" org-clock-cancel "cancel")
  ("d" org-clock-display "display")
  ("e" org-clock-modify-effort-estimate "effort")
  ("i" org-clock-in "in")
  ("j" org-clock-goto "jump")
  ("o" org-clock-out "out")
  ("p" org-pomodoro "pomodoro")
  ("r" org-clock-report "report"))))

(pretty-hydra-define hydra-flycheck
  (:hint nil :color teal :quit-key "q" :title (with-faicon "plane" "Flycheck" 1 -0.05))
  ("Checker"
   (("?" flycheck-describe-checker "describe")
    ("d" flycheck-disable-checker "disable")
    ("m" flycheck-mode "mode")
    ("s" flycheck-select-checker "select"))
   "Errors"
   (("<" flycheck-previous-error "previous" :color pink)
    (">" flycheck-next-error "next" :color pink)
    ("f" flycheck-buffer "check")
    ("l" flycheck-list-errors "list"))
   "Other"
   (("M" flycheck-manual "manual")
    ("v" flycheck-verify-setup "verify setup"))))

(pretty-hydra-define hydra-go-to-file
(:hint nil :color teal :quit-key "q" :title (with-octicon "file-symlink-file" "Go To" 1 -0.05))
("Agenda"
 (("ac" (find-file "~/.personal/agenda/contacts.org") "contacts")
  ("ah" (find-file "~/.personal/agenda/home.org") "home")
  ("ai" (find-file "~/.personal/agenda/inbox.org") "inbox")
  ("ag" (find-file "~/.personal/agenda/goals.org") "goals")
  ("ap" (find-file "~/.personal/agenda/people.org") "people")
  ("ar" (find-file "~/.personal/agenda/routine.org") "routine")
  ("aR" (find-file "~/.personal/agenda/review.org") "review")
  ("as" (find-file "~/.personal/agenda/someday.org") "someday")
  ("aw" (find-file "~/.personal/agenda/work.org") "work"))
 "Config"
 (("cA" (find-file (format "%s/sh/aliases" xdg-config)) "aliases")
  ("ce" (find-file (format "%s/emacs/config.org" xdg-config)) "emacs")
  ("cE" (find-file (format "%s/sh/environ" xdg-config)) "environ")
  ("cf" (find-file (format "%s/foot/foot.ini" xdg-config)) "foot")
  ("cn" (find-file (format "%s/neofetch/config.conf" xdg-config)) "neofetch")
  ("cr" (find-file (format "%s/ranger/rc.conf" xdg-config)) "ranger")
  ("cs" (find-file (format "%s/sway/config" xdg-config)) "sway")
  ("ct" (find-file (format "%s/tmux/tmux.conf" xdg-config)) "tmux")
  ("cw" (find-file (format "%s/waybar/config" xdg-config)) "waybar")
  ("cx" (find-file (format "%s/sh/xdg" xdg-config)) "xdg"))
 "Items"
  (("ib" (find-file "~/.personal/items/books.org") "book")
   ("il" (find-file "~/.personal/items/learning.org") "learning")
   ("im" (find-file "~/.personal/items/movies.org"))
   ("ip" (find-file "~/.personal/items/purchases.org") "purchase"))
  "Notes"
  (("na" (find-file (format "~/.personal/notes/affirmations.pdf" xdg-config)) "Affirmations"))
  "Other"
 (("ol" (find-file "~/.personal/other/long-goals.org") "long-terms goals")
  ("os" (find-file "~/.personal/other/short-goals.org") "short-terms goals")
  ("ou" (find-file "~/.personal/other/usb.org") "usb"))))

(pretty-hydra-define hydra-image
(:hint nil :color pink :quit-key "q" :title (with-faicon "file-image-o" "Images" 1 -0.05))
("Action"
 (("r" image-rotate "rotate")
  ("s" image-save "save" :color teal))
  "Zoom"
  (("-" image-decrease-size "out")
   ("+" image-increase-size "in")
   ("=" image-transform-reset "reset"))))

(pretty-hydra-define hydra-ledger
(:hint nil :color teal :quit-key "q" :title (with-faicon "usd" "Ledger" 1 -0.05))
("Action"
 (("b" leadger-add-transaction "add")
  ("c" ledger-mode-clean-buffer "clear")
  ("i" ledger-copy-transaction-at-point "copy")
  ("s" ledger-delete-current-transaction "delete")
  ("r" ledger-report "report"))))

(pretty-hydra-define hydra-projectile
  (:hint nil :color teal :quit-key "q" :title (with-faicon "rocket" "Projectile" 1 -0.05))
  ("Buffers"
   (("b" projectile-switch-to-buffer "list")
    ("k" projectile-kill-buffers "kill all")
    ("S" projectile-save-project-buffers "save all"))
   "Find"
   (("d" projectile-find-dir "directory")
    ("D" projectile-dired "root")
    ("f" projectile-find-file "file")
    ("p" projectile-persp-switch-project "project"))
   "Other"
   (("i" projectile-invalidate-cache "reset cache"))
   "Search"
   (("r" projectile-replace "replace")
    ("R" projectile-replace-regexp "regex replace")
    ("s" consult-git-grep "search"))))

(pretty-hydra-define hydra-magit
  (:hint nil :color teal :quit-key "q" :title (with-octicon "mark-github" "Magit" 1 -0.05))
  ("Action"
   (("b" magit-blame "blame")
    ("c" magit-clone "clone")
    ("i" magit-init "init")
    ("l" magit-log-buffer-file "commit log (current file)")
    ("L" magit-log-current "commit log (project)")
    ("s" magit-status "status"))))

(pretty-hydra-define hydra-merge
(:hint nil :color pink :quit-key "q" :title (with-octicon "mark-github" "Magit" 1 -0.05))
("Move"
 (("n" smerge-next "next")
  ("p" smerge-prev "previous"))
 "Keep"
 (("RET" smerge-keep-current "current")
  ("a" smerge-keep-all "all")
  ("b" smerge-keep-base "base")
  ("l" smerge-keep-lower "lower")
  ("u" smerge-keep-upper "upper"))
 "Diff"
 (("<" smerge-diff-base-upper "upper/base")
  ("=" smerge-diff-upper-lower "upper/lower")
  (">" smerge-diff-base-lower "base/lower")
  ("R" smerge-refine "redefine")
  ("E" smerge-ediff "ediff"))
 "Other"
 (("C" smerge-combine-with-next "combine")
  ("r" smerge-resolve "resolve")
  ("k" smerge-kill-current "kill current"))))

(pretty-hydra-define hydra-org
(:hint nil :color teal :quit-key "q" :title (with-fileicon "org" "Org" 1 -0.05))
("Action"
 (("A" my/org-archive-done-tasks "archive")
  ("a" org-agenda "agenda")
  ("c" org-capture "capture")
  ("d" org-decrypt-entry "decrypt")
  ("i" org-insert-link-global "insert-link")
  ("j" org-capture-goto-last-stored "jump-capture")
  ("k" org-cut-subtree "cut-subtree")
  ("o" org-open-at-point-global "open-link")
  ("r" org-refile "refile")
  ("s" org-store-link "store-link")
  ("t" org-show-todo-tree "todo-tree"))))

(pretty-hydra-define hydra-notes
(:hint nil :color teal :quit-key "q" :title (with-octicon "pencil" "Notes" 1 -0.05))
("Notes"
 (("c" org-roam-dailies-capture-today "capture")
  ("C" org-roam-dailies-capture-tomorrow "capture tomorrow")
  ("g" org-roam-graph "graph")
  ("f" org-roam-node-find "find")
  ("i" org-roam-node-insert "insert"))
 "Go To"
 ((">" org-roam-dailies-goto-next-note "next note")
  ("<" org-roam-dailies-goto-previous-note "previous note")
  ("d" org-roam-dailies-goto-date "date")
  ("t" org-roam-dailies-goto-today "today")
  ("T" org-roam-dailies-goto-tomorrow "tomorrow")
  ("y" org-roam-dailies-goto-yesterday "yesterday"))))

(pretty-hydra-define hydra-spelling
(:hint nil :color teal :quit-key "q" :title (with-faicon "magic" "Spelling" 1 -0.05))
("Checker"
 (("c" langtool-correct-buffer "correction")
  ("C" langtool-check-done "clear")
  ("d" ispell-change-dictionary "dictionary")
  ("l" (message "Current language: %s (%s)" langtool-default-language ispell-current-dictionary) "language")
  ("s" my/switch-language "switch")
  ("w" wiki-summary "wiki"))
 "Errors"
 (("<" flyspell-correct-previous "previous" :color pink)
  (">" flyspell-correct-next "next" :color pink)
  ("f" langtool-check "find"))))

(pretty-hydra-define hydra-windows
  (:hint nil :forein-keys warn :quit-key "q" :title (with-faicon "windows" "Windows" 1 -0.05))
  ("Window"
   (("b" balance-windows "balance")
    ("c" centered-window-mode "center")
    ("i" enlarge-window "heighten")
    ("j" shrink-window-horizontally "narrow")
    ("k" shrink-window "lower")
    ("u" winner-undo "undo")
    ("r" winner-redo "redo")
    ("l" enlarge-window-horizontally "widen")
    ("s" switch-window-then-swap-buffer "swap" :color teal))
   "Zoom"
   (("-" text-scale-decrease "out")
    ("+" text-scale-increase "in")
    ("=" (text-scale-increase 0) "reset"))))

(pretty-hydra-define hydra-tex
  (:hint nil :color teal :quit-key "q" :title (with-fileicon "tex" "LaTeX" 1 -0.05))
  ("Action"
   (("g" reftex-goto-label "goto")
    ("r" reftex-query-replace-document "replace")
    ("s" counsel-rg "search")
    ("t" reftex-toc "table of content"))))

(pretty-hydra-define hydra-tool
  (:hint nil :color teal :quit-key "q" :title (with-faicon "briefcase" "Tool" 1 -0.05))
  ("Network"
   (("c" ipcalc "subnet calculator")
    ("i" ipinfo "ip info"))))

(defhydra hydra-typescript (:color blue)
  "
  ^
  ^TypeScript^          ^Do^
  ^──────────^──────────^──^───────────
  _q_ quit             _b_ back
  ^^                   _e_ errors
  ^^                   _j_ jump
  ^^                   _r_ references
  ^^                   _R_ restart
  ^^                   ^^
  "
  ("q" nil)
  ("b" tide-jump-back)
  ("e" tide-project-errors)
  ("j" tide-jump-to-definition)
  ("r" tide-references)
  ("R" tide-restart-server))

(pretty-hydra-define hydra-upload
  (:hint nil :color teal :quit-key "q" :title (with-faicon "cloud-upload" "Upload" 1 -0.05))
  ("Action"
   (("b" webpaste-paste-buffer "buffer")
    ("i" imgbb-upload "image")
    ("r" webpaste-paste-region "region"))))

(use-package ledger-mode
  :mode ("\\.\\(dat\\|ledger\\)\\'")
  :preface
  (defun my/ledger-save ()
    "Clean the ledger buffer at each save."
    (interactive)
    (ledger-mode-clean-buffer)
    (save-buffer))
  :bind (:map ledger-mode-map
              ("C-x C-s" . my/ledger-save))
  :hook (ledger-mode . ledger-flymake-enable)
  :custom
  (ledger-clear-whole-transactions t)
  (ledger-reconcile-default-commodity "EUR")
  (ledger-reports
   '(("account statement" "%(binary) reg --real [[ledger-mode-flags]] -f %(ledger-file) ^%(account)")
     ("balance sheet" "%(binary) --real [[ledger-mode-flags]] -f %(ledger-file) bal ^assets ^liabilities ^equity")
     ("budget" "%(binary) --empty -S -T [[ledger-mode-flags]] -f %(ledger-file) bal ^assets:bank ^assets:receivables ^assets:cash ^assets:budget")
     ("budget goals" "%(binary) --empty -S -T [[ledger-mode-flags]] -f %(ledger-file) bal ^assets:bank ^assets:receivables ^assets:cash ^assets:'budget goals'")
     ("budget obligations" "%(binary) --empty -S -T [[ledger-mode-flags]] -f %(ledger-file) bal ^assets:bank ^assets:receivables ^assets:cash ^assets:'budget obligations'")
     ("budget debts" "%(binary) --empty -S -T [[ledger-mode-flags]] -f %(ledger-file) bal ^assets:bank ^assets:receivables ^assets:cash ^assets:'budget debts'")
     ("cleared" "%(binary) cleared [[ledger-mode-flags]] -f %(ledger-file)")
     ("equity" "%(binary) --real [[ledger-mode-flags]] -f %(ledger-file) equity")
     ("income statement" "%(binary) --invert --real -S -T [[ledger-mode-flags]] -f %(ledger-file) bal ^income ^expenses -p \"this month\""))
   (ledger-report-use-header-line nil)))

   (use-package flycheck-ledger :after ledger-mode)

(use-package org-contrib)

(use-package org
  :delight "θ"
  :hook (org-mode . turn-off-auto-fill)
  :bind ("C-c i" . org-insert-structure-template)
  :preface
  (defun my/org-archive-done-tasks ()
    "Archive finished or cancelled tasks."
    (interactive)
    (org-map-entries
     (lambda ()
       (org-archive-subtree)
       (setq org-map-continue-from (outline-previous-heading)))
     "TODO=\"DONE\"|TODO=\"CANCELLED\"" (if (org-before-first-heading-p) 'file 'tree)))

  (defun my/org-jump ()
    "Jump to a specific task."
    (interactive)
    (let ((current-prefix-arg '(4)))
      (call-interactively 'org-refile)))

  (defun my/org-use-speed-commands-for-headings-and-lists ()
    "Activate speed commands on list items too."
    (or (and (looking-at org-outline-regexp) (looking-back "^\**"))
        (save-excursion (and (looking-at (org-item-re)) (looking-back "^[ \t]*")))))

  (defmacro ignore-args (fnc)
    "Return function that ignores its arguments and invokes FNC."
    '(lambda (&rest _rest)
       (funcall ,fnc)))
  :hook ((after-save . my/config-tangle)
         (org-mode . visual-line-mode))
  :custom
  (org-archive-location "~/.personal/archives/%s::")
  (org-blank-before-new-entry '((heading . t) (plain-list-item . t)))
  (org-confirm-babel-evaluate nil)
  (org-cycle-include-plain-lists 'integrate)
  (org-ellipsis " ▾")
  (org-export-backends '(ascii beamer html icalendar latex man md org texinfo))
  (org-hide-emphasis-markers t)
  (org-lod-done 'time)
  (org-log-into-drrawer t)
  (org-modules '(org-crypt
                 org-habit
                 org-mouse
                 org-protocol
                 org-tempo))
  (org-refile-allow-creating-parent-nodes 'confirm)
  (org-refile-targets '((org-agenda-files :maxlevel . 1)
                        ("~/.personal/agenda/home.org" :maxlevel . 2)
                        ("~/.personal/agenda/work.org" :maxlevel . 2)))
  (org-refile-use-cache nil)
  (org-refile-use-outline-path nil)
  (org-startup-indented t)
  (org-startup-with-inline-images t)
  (org-tag-alist '((:startgroup . "Context")
                   ("@errands" . ?e)
                   ("@home" . ?h)
                   ("@work" . ?w)
                   (:endgroup)
                   (:startgroup . "Difficulty")
                   ("easy" . ?E)
                   ("medium" . ?M)
                   ("challenging" . ?C)
                   (:endgroup)
                   ("bug" . ?b)
                   ("car" . ?v)
                   ("future" . ?F)
                   ("goal" . ?g)
                   ("health" . ?H)
                   ("house" . ?O)
                   ("meeting" . ?m)
                   ("planning" . ?p)
                   ("phone" . ?0)
                   ("purchase" . ?P)
                   ("reading" . ?r)
                   ("review" . ?R)
                   ("study" . ?s)
                   ("sport" . ?S)
                   ("talk" . ?T)
                   ("tech" . ?t)
                   ("trip" . ?I)
                   ("thinking" . ?i)
                   ("update" . ?u)
                   ("watch" . ?l)
                   ("writing" . ?W)))
  (org-tags-exclude-from-inheritance '("crypt" "project"))
  (org-todo-keywords '((sequence "TODO(t)"
                                 "STARTED(s)"
                                 "NEXT(n)"
                                 "SOMEDAY(.)"
                                 "WAITING(w)""|" "DONE(x!)" "CANCELLED(c@)")))
  (org-use-effective-time t)
  (org-use-speed-commands 'my/org-use-speed-commands-for-headings-and-lists)
  (org-yank-adjusted-subtrees t)
  :config
  (add-to-list 'org-global-properties '("Effort_ALL" . "0:05 0:15 0:30 1:00 2:00 3:00 4:00"))
  (add-to-list 'org-speed-commands '("$" call-interactively 'org-archive-subtree))
  (add-to-list 'org-speed-commands '("i" call-interactively 'org-clock-in))
  (add-to-list 'org-speed-commands '("o" call-interactively 'org-clock-out))
  (add-to-list 'org-speed-commands '("s" call-interactively 'org-schedule))
  (add-to-list 'org-speed-commands '("x" org-todo "DONE"))
  (add-to-list 'org-speed-commands '("y" org-todo-yesterday "DONE"))
  (add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
  (add-to-list 'org-structure-template-alist '("sh" . "src shell"))
  (add-to-list 'org-structure-template-alist '("py" . "src python"))
  (advice-add 'org-deadline :after (ignore-args #'org-save-all-org-buffers))
  (advice-add 'org-schedule :after (ignore-args #'org-save-all-org-buffers))
  (advice-add 'org-store-log-note :after (ignore-args #'org-save-all-org-buffers))
  (advice-add 'org-refile :after 'org-save-all-org-buffers)
  (advice-add 'org-todo :after (ignore-args #'org-save-all-org-buffers))
  (font-lock-add-keywords 'org-mode
                          '(("^ *\\([-]\\) "
                             (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))
  (org-clock-persistence-insinuate)
  (org-load-modules-maybe t))

(use-package toc-org
  :after org
  :hook (org-mode . toc-org-enable))

(use-package async
  :after org
  :preface
  (defvar config-file (expand-file-name "config.org" user-emacs-directory)
    "The configuration file.")
  (defvar config-last-change (nth 5 (file-attributes config-file))
    "Last modification time of the configuration file.")
  (defvar show-async-tangle-results nil
    "Keeps *emacs* async buffers around for later inspection.")
  (defun my/config-updated ()
    "Check if the configuration file has been updated since the last time."
    (time-less-p config-last-change
                 (nth 5 (file-attributes config-file))))
  (defun my/config-tangle ()
    "Tangles the org file asynchronously."
    (when (my/config-updated)
      (setq config-last-change
            (nth 5 (file-attributes config-file)))
      (my/async-babel-tangle config-file)))
  (defun my/async-babel-tangle (org-file)
    "Tangles the org file asynchronously."
    (let ((init-tangle-start-time (current-time))
          (file (buffer-file-name))
          (async-quiet-switch "-q"))
      (async-start
       '(lambda ()
          (require 'org)
          (org-babel-tangle-file ,org-file))
       (unless show-async-tangle-results
         '(lambda (result)
            (if result
                (message "[✓] %s successfully tangled (%.2fs)"
                         ,org-file
                         (float-time (time-subtract (current-time)
                                                    ',init-tangle-start-time)))
              (message "[✗] %s as tangle failed." ,org-file))))))))

(use-package org-tempo
  :straight nil
  :after org)

(with-eval-after-load 'org
  (require 'org-tempo)
  (add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp")))

(use-package org-agenda
  :straight nil
  :bind (:map org-agenda-mode-map
              ("C-n" . org-agenda-next-item)
              ("C-p" . org-agenda-previous-item)
              ("j" . org-agenda-goto)
              ("X" . my/org-agenda-mark-done-next)
              ("x" . my/org-agenda-mark-done))
  :preface
  (defun my/org-agenda-mark-done (&optional arg)
    "Mark the current TODO as done in org-agenda."
    (interactive "P")
    (org-agenda-todo "DONE"))

  (defun my/org-agenda-mark-done-next ()
    "Mark the current TODO as done and add another task after it."
    (interactive)
    (org-agenda-todo "DONE")
    (org-agenda-switch-to)
    (org-capture 0 "t"))
  :custom
  (org-agenda-category-icon-alist
   '(("home" ,(list (all-the-icons-faicon "home" :v-adjust -0.05)) nil nil :ascent center :mask heuristic)
     ("inbox" ,(list (all-the-icons-faicon "inbox" :v-adjust -0.1)) nil nil :ascent center :mask heuristic)
     ("people" ,(list (all-the-icons-material "people" :v-adjust -0.25)) nil nil :ascent center :mask heuristic)
     ("work" ,(list (all-the-icons-material "work" :v-adjust -0.25)) nil nil :ascent center :mask heuristic)
     ("routine" ,(list (all-the-icons-material "repeat" :v-adjust -0.25)) nil nil :ascent center :mask heuristic)
     ))
  (org-agenda-custom-commands
   '(("d" "Dashboard"
      ((agenda "" ((org-deadline-warning-days 7)))
       (todo "NEXT"
             ((org-agenda-overriding-header "Next Tasks")))
       (tags-todo "agenda/ACTIVE" ((org-agenda-overriding-header "Active Projects")))))
     ("n" "Next Tasks"
      ((agenda "" ((org-deadline-warning-days 7)))
       (todo "NEXT"
             ((org-agenda-overriding-header "Next Tasks")))))
     ("h" "Home Tasks" tags-todo "@home")
     ("w" "Work Tasks" tags-todo "@work")

     ("E" "Easy Tasks" tags-todo "easy")
     ("C" "Challenging Tasks" tags-todo "challenging")

     ("e" tags-todo "+TODO=\"NEXT\"+Effort<15&+Effort>0"
      ((org-agenda-overriding-header "Low Effort Tasks")
       (org-agenda-max-todos 20)
       (org-agenda-files org-agenda-files)))))
  (org-agenda-dim-blocked-tasks t)
  (org-agenda-files '("~/.personal/agenda"))
  (org-agenda-inhibit-startup t)
  (org-agenda-show-log t)
  (org-agenda-skip-deadline-if-done t)
  (org-agenda-skip-deadline-prewarning-if-scheduled 'pre-scheduled)
  (org-agenda-skip-scheduled-if-done t)
  (org-agenda-span 2)
  (org-agenda-start-on-weekday 6)
  (org-agenda-start-with-log-mode t)
  (org-agenda-sticky nil)
  (org-agenda-tags-column 90)
  (org-agenda-time-grid '((daily today require-timed)))
  (org-agenda-use-tag-inheritance t)
  (org-columns-default-format "%14SCHEDULED %Effort{:} %1PRIORITY %TODO %50ITEM %TAGS")
  (org-default-notes-file "~/.personal/agenda/inbox.org")
  (org-directory "~/.personal")
  (org-enforce-todo-dependencies t)
  (org-habit-completed-glyph ?✓)
  (org-habit-graph-column 80)
  (org-habit-show-habits-only-for-today nil)
  (org-habit-today-glyph ?‖)
  (org-track-ordered-property-with-tag t))

(use-package org-wild-notifier
  :after org
  :custom
  (alert-default-style 'libnotify)
  (org-wild-notifier-notification-title "Agenda Reminder")
  :config (org-wild-notifier-mode))

;;(use-package org-bullets
;;    :hook (org-mode . org-bullets-mode)
    ;;:custom (org-bullets-bullet-list '("●" "►" "▸")))
(use-package org-modern
  :straight (org-modern :type git :host github :repo "minad/org-modern" :branch "main")
  :hook (org-mode . org-modern-mode))

(use-package org-capture
  :straight nil
  :preface
  (defvar my/org-active-task-template
    (concat "* NEXT %^{Task}\n"
            ":PROPERTIES:\n"
            ":Effort: %^{effort|1:00|0:05|0:15|0:30|2:00|4:00}\n"
            ":CAPTURED: %<%Y-%m-%d %H:%M>\n"
            ":END:") "Template for basic task.")
  (defvar my/org-appointment
    (concat "* TODO %^{Appointment}\n"
            "SCHEDULED: %t\n") "Template for appointment task.")
  (defvar my/org-basic-task-template
    (concat "* TODO %^{Task}\n"
            ":PROPERTIES:\n"
            ":Effort: %^{effort|1:00|0:05|0:15|0:30|2:00|4:00}\n"
            ":CAPTURED: %<%Y-%m-%d %H:%M>\n"
            ":END:") "Template for basic task.")
  (defvar my/org-contacts-template
    (concat "* %(org-contacts-template-name)\n"
            ":PROPERTIES:\n"
            ":BIRTHDAY: %^{YYYY-MM-DD}\n"
            ":END:") "Template for a contact.")
  :custom
  (org-capture-templates
   '(("c" "Contact" entry (file+headline "~/.personal/agenda/contacts.org" "Inbox"),
      my/org-contacts-template :empty-lines 1)
     ("p" "People" entry (file+headline "~/.personal/agenda/people.org" "Tasks"),
      my/org-basic-task-template :empty-lines 1)
     ("a" "Appointment" entry (file+headline "~/.personal/agenda/people.org" "Appointments"),
      my/org-appointment :empty-lines 1)
     ("m" "Meeting" entry (file+headline "~/.personal/agenda/people.org" "Meetings")
      "* Meeting with %? :meeting:\n%U" :clock-in t :clock-resume t :empty-lines 1)
     ("P" "Phone Call" entry (file+headline "~/.personal/agenda/people.org" "Phone Calls")
      "* Phone %? :phone:\n%U" :clock-in t :clock-resume t)

     ("i" "New Item")
     ("ib" "Book" checkitem (file+headline "~/.personal/items/books.org" "Books")
      "- [ ] %^{Title} -- %^{Author}\n  %U"
      :immediate-finish t)
     ("il" "Learning" checkitem (file+headline "~/.personal/items/learning.org" "Things")
      "- [ ] %^{Thing}\n  %U"
      :immediate-finish t)
     ("im" "Movie" checkitem (file+headline "~/.personal/items/movies.org" "Movies")
      "- [ ] %^{Title}\n  %U"
      :immediate-finish t)
     ("ip" "Purchase" checkitem (file+headline "~/.personal/items/purchases.org" "Purchases")
      "- [ ] %^{Item}\n  %U"
      :immediate-finish t)

     ("t" "New Task")
     ("ta" "Active" entry (file+headline "~/.personal/agenda/inbox.org" "Active"),
      my/org-active-task-template
      :empty-lines 1
      :immediate-finish t)
("tb" "Backlog" entry (file+headline "~/.personal/agenda/inbox.org" "Backlog"),
            my/org-basic-task-template
            :empty-lines 1
            :immediate-finish t))))

(use-package org-clock
  :straight nil
  :after org
  :preface
  (defun my/org-mode-ask-effort ()
    "Ask for an effort estimate when clocking in."
    (unless (org-entry-get (point) "Effort")
      (let ((effort
             (completing-read
              "Effort: "
              (org-entry-get-multivalued-property (point) "Effort"))))
        (unless (equal effort "")
          (org-set-property "Effort" effort)))))
  :hook (org-clock-in-prepare-hook . my/org-mode-ask-effort)
  :custom
  (org-clock-clocktable-default-properties
   '(:block day :maxlevel 2 :scope agenda :link t :compact t :formula %
            :step day :fileskip0 t :stepskip0 t :narrow 80
            :properties ("Effort" "CLOCKSUM" "CLOCKSUM_T" "TODO")))
  (org-clock-continuously nil)
  (org-clock-in-switch-to-state "STARTED")
  (org-clock-out-remove-zero-time-clocks t)
  (org-clock-persist t)
  (org-clock-persist-query-resume nil)
  (org-clock-report-include-clocking-task t)
  (org-show-notification-handler (lambda (msg) (alert msg))))

(use-package org-pomodoro
  :after org
  :custom
  (alert-user-configuration (quote ((((:category . "org-pomodoro")) libnotify nil))))
  (org-pomodoro-audio-player "/usr/bin/mpv")
  (org-pomodoro-finished-sound "~/Audio/pomodoro_finished.mp3")
  (org-pomodoro-format " %s")
  (org-pomodoro-killed-sound "~/Audio/pomodoro_killed.mp3")
  (org-pomodoro-long-break-sound "~/Audio/pomodoro_long.mp3")
  (org-pomodoro-overtime-sound "~/Audio/pomodoro_overtime.mp3")
  (org-pomodoro-short-break-sound "~/Audio/pomodoro_short.mp3")
  (org-pomodoro-start-sound "~/Audio/pomodoro_start.mp3")
  (org-pomodoro-start-sound-p t))

(use-package org-contacts
  :straight nil
  :after org
  :custom (org-contacts-files '("~/.personal/agenda/contacts.org")))

(use-package org-faces
  :straight nil
  :custom
  (org-todo-keyword-faces
   '(("DONE"    . (:foreground "#8abeb7" :weight bold))
     ("NEXT"    . (:foreground "#f0c674" :weight bold))
     ("SOMEDAY" . (:foreground "#b294bb" :weight bold))
     ("TODO"    . (:foreground "#b5bd68" :weight bold))
     ("WAITING" . (:foreground "#de935f" :weight bold)))))

(use-package org-crypt
  :straight nil
  :config
  (require 'org)
  (org-crypt-use-before-save-magic)
  :custom
  (org-crypt-key "CE498E212FC1FA5348B3FFF27A09A11BEB260B60"))

(setq epa-file-encrypt-to "karolos.triantafyllou@gmail.com")
(setq epa-file-select-keys "auto")

(use-package org-roam
  :after org
  :init
  (setq org-roam-v2-ack t)
  (setq my/daily-note-filename "%<%Y-%m-%d>.org.gpg"
        my/daily-note-header "#+title: %<%Y-%m-%d %a>\n\n[[roam:%<%Y-%B>]]\n\n")
  :custom
  (org-roam-capture-templates
   '(("d" "default" plain "%?"
      :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org"
                         "#+title: ${title}\n")
      :unnarrowed t)))
  (org-roam-completion-everywhere t)
  (org-roam-dailies-directory "journal/")
  (org-roam-dailies-capture-templates
   '(("d" "default" plain
      "* %?"
      :if-new (file+head ,my/daily-note-filename
                         ,my/daily-note-header)
      :empty-lines 1)

     ("j" "journal" plain
      "** %<%I:%M %p>  :journal:\n\n%?\n\n"
      :if-new (file+head+olp ,my/daily-note-filename
                             ,my/daily-note-header
                             ("Journal"))
      :empty-lines 1)
     ("m" "meeting" entry
      "** %<%I:%M %p> - %^{Meeting Title}  :meeting:\n\n%?\n\n"
      :if-new (file+head+olp ,my/daily-note-filename
                             ,my/daily-note-header
                             ("Meetings"))
      :empty-lines 1)))
  (org-roam-directory "~/.personal/notes")
  :custom (org-roam-graph-viewer "/usr/bin/qutebrowser")
  :config (org-roam-setup))

(use-package mu4e
    :straight nil
    :load-path "/usr/share/emacs/site-lisp/mu4e"
    :commands mu4e
    :hook (mu4e-compose-mode . turn-off-auto-fill)
    :bind (:map mu4e-headers-mode-map
                ("M-[" . scroll-down-command)
                ("M-]" . scroll-up-command))
    :preface
    (defun my/set-email-account (label letvars)
      "Registers an email address for mu4e."
      (setq mu4e-contexts
            (cl-loop for context in mu4e-contexts
                     unless (string= (mu4e-context-name context) label)
                     collect context))
      (let ((context (make-mu4e-context
                      :name label
                      :enter-func (lambda () (mu4e-message "Switched context"))
                      :leave-func #'mu4e-clear-caches
                      :match-func
                      (lambda (msg)
                        (when msg
                          (string-prefix-p (format "/%s" msg)
                                           (mu4e-message-field msg :maildir))))
                      :vars letvars)))
        (push context mu4e-contexts)
        context))
    :custom
    (mu4e-attachment-dir "~/Downloads")
    ;; To avoid synchronization issues/ with mbsync
    (mu4e-change-filenames-when-moving t)
    (mu4e-confirm-quit nil)
    ;; (mu4e-completing-read-function 'ivy-read)
    (mu4e-compose-complete-only-after (format-time-string
                                       "%Y-%m-%d"
                                       (time-subtract (current-time) (days-to-time 150))))
    (mu4e-compose-context-policy 'ask-if-none)
    (mu4e-compose-dont-reply-to-self t)
    (mu4e-compose-format-flowed t)
    (mu4e-get-mail-command (format "mbsync -c ~/.config/isync/mbsyncrc -a"))
    (mu4e-headers-date-format "%F")
    (mu4e-headers-fields
     '((:account    . 10)
       (:human-date . 12)
       (:flags      . 6)
       (:from       . 22)
       (:subject    . nil)))
    (mu4e-headers-time-format "%R")
    (mu4e-html2text-command "iconv -c -t utf-8 | pandoc -f html -t plain")
    (mu4e-maildir "~/Mails")
    (mu4e-org-contacts-file "~/.personal/agenda/contacts.org")
    (mu4e-update-interval (* 5 60))
    (mu4e-use-fancy-chars t)
    (mu4e-view-prefer-html t)
    (mu4e-view-show-addresses t)
    (mu4e-view-show-images t)
    :config
    (my/set-email-account "karolos-triantafyllou"
                          '((mu4e-drafts-folder . "/personal/karolos-triantafyllou/drafts")
                            (mu4e-refile-folder . "/personal/karolos-triantafyllou/all")
                            (mu4e-sent-folder   . "/personal/karolos-triantafyllou/sent")
                            (mu4e-trash-folder  . "/personal/karolos-triantafyllou/trash")
                            (mu4e-maildir-shortcuts . ((:maildir "/personal/karolos-triantafyllou/all"    :key ?a)
                                                       (:maildir "/personal/karolos-triantafyllou/inbox"  :key ?i)
                                                       (:maildir "/personal/karolos-triantafyllou/drafts" :key ?d)
                                                       (:maildir "/personal/karolos-triantafyllou/sent"   :key ?s)
                                                       (:maildir "/personal/karolos-triantafyllou/trash"  :key ?t)))
                            (smtpmail-smtp-user . "karolos.triantafyllou@gmail.com")
                            (smtpmail-smtp-server . "smtp.gmail.com")
                            (smtpmail-smtp-service . 465)
                            (smtpmail-stream-type . ssl)
                            (user-mail-address . "karolos.triantafyllou@gmail.com")
                            (user-full-name . "Karolos Triantafyllou")))
    ;; (setq mu4e-headers-attach-mark    '("a" . ,(with-faicon "paperclip" "" 0.75 -0.05 "all-the-icons-lyellow"))
    ;;       mu4e-headers-draft-mark     '("D" . ,(with-octicon "pencil" "" 0.75 -0.05 "all-the-icons-lsilver"))
    ;;       mu4e-headers-encrypted-mark '("x" . ,(with-faicon "lock" "" 0.75 -0.05 "all-the-icons-lred"))
    ;;       mu4e-headers-flagged-mark   '("F" . ,(with-faicon "flag" "" 0.75 -0.05 "all-the-icons-maroon"))
    ;;       mu4e-headers-new-mark       '("N" . ,(with-faicon "check-circle" "" 0.75 -0.05 "all-the-icons-silver"))
    ;;       mu4e-headers-passed-mark    '("P" . ,(with-faicon "share" "" 0.75 -0.05 "all-the-icons-purple "))
    ;;       mu4e-headers-replied-mark   '("R" . ,(with-faicon "reply" "" 0.75 -0.05 "all-the-icons-lgreen"))
    ;;       mu4e-headers-seen-mark      '("S" . ,(with-octicon "check" "" 1 -0.05 "all-the-icons-lgreen"))
    ;;       mu4e-headers-signed-mark    '("s" . ,(with-faicon "key" "" 0.75 -0.05 "all-the-icons-cyan"))
    ;;       mu4e-headers-trashed-mark   '("T" . ,(with-faicon "trash" "" 0.75 -0.05 "all-the-icons-lred"))
    ;;       mu4e-headers-unread-mark    '("u" . ,(with-faicon "envelope" "" 0.75 -0.05 "all-the-icons-silver")))
    (add-to-list 'mu4e-header-info-custom
                 '(:account
                   :name "Account"
                   :shortname "Account"
                   :help "Which account this email belongs to"
                   :function
                   (lambda (msg)
                     (let ((maildir (mu4e-message-field msg :maildir)))
                       (format "%s" (substring maildir 1 (string-match-p "/" maildir 1)))))))
    (add-to-list 'mu4e-headers-actions '("org-contact-add" . mu4e-action-add-org-contact) t)
    (add-to-list 'mu4e-view-actions '("org-contact-add" . mu4e-action-add-org-contact) t))

  (use-package org-mime
  :after mu4e
  :hook (message-send . org-mime-htmlize)
  :bind (:map mu4e-compose-mode-map
              ("C-c '" . org-mime-edit-mail-in-org-mode))
  :config
  (add-hook 'org-mime-html-hook (lambda ()
                                  (goto-char (point-max))
                                  (insert "--<br>
                 <strong>Karolos Triantafyllou</strong><br>")))
  (add-hook 'org-mime-html-hook (lambda ()
                                  (org-mime-change-element-style "p" (format "color: %s" "#1a1a1a"))))

  (add-hook 'org-mime-html-hook (lambda ()
                                  (org-mime-change-element-style "strong" (format "color: %s" "#000"))))

  (add-hook 'org-mime-html-hook (lambda ()
                                  (org-mime-change-element-style
                                   "pre" "background: none repeat scroll 0% 0% rgb(61, 61, 61);
                                                 border-radius: 15px;
                                                 color: #eceff4;
                                                 font-family: Courier, 'Courier New', monospace;
                                                 font-size: small;
                                                 font-weight: 400;                                                 line-height: 1.3em;
                                                 padding: 20px;
                                                 quotes: '«' '»';
                                                 width: 41%;")))
  (setq org-mime-export-options '(:preserve-breaks t
                                                   :section-numbers nil
                                                   :with-author nil
                                                   :with-toc nil)))

  (use-package mu4e-alert
  :hook ((after-init . mu4e-alert-enable-mode-line-display)
         (after-init . mu4e-alert-enable-notifications))
  :config (mu4e-alert-set-default-style 'libnotify))

(use-package message
  :straight nil
  :after mu4e
  :custom
  (message-citation-line-format "On %B %e, %Y at %l:%M %p, %f (%n) wrote:\n")
  (message-citation-line-function 'message-insert-formatted-citation-line)
  (message-kill-buffer-on-exit t)
  (message-send-mail-function 'smtpmail-send-it)
  (mml-secure-openpgp-signers '("84D878C99B99611D")))

(use-package nov
  :mode ("\\.epub\\'" . nov-mode)
  :custom (nov-text-width 75))

(setq gc-cons-threshold (* 10 1000 1000))
