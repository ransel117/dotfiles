(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package)
  )
(eval-and-compile
  (setq use-package-always-ensure t
        use-package-expand-minimally t)
  )

(use-package auto-package-update
  :config
  (setq auto-package-update-delete-old-versions t
	auto-package-update-hide-results t)
  (auto-package-update-maybe)
  )

;; -------- settings -------- ;;
(menu-bar-mode 0)
(when (fboundp #'tool-bar-mode)
  (tool-bar-mode 0)
  )
(when (fboundp #'scroll-bar-mode)
  (scroll-bar-mode 0)
  )

(transient-mark-mode 0)
(column-number-mode 1)
(file-name-shadow-mode 1)
(global-display-line-numbers-mode 1)
(when (fboundp 'global-eldoc-mode)
  (global-eldoc-mode 0)
  )
(use-package paren
  :ensure t
  :init
  (setq show-paren-delay 0)
  :config
  (show-paren-mode 1)
  )
(setq-default display-line-numbers-type 'relative)
(setq-default font-use-system-font t)
(setq whitespace-style
      '(face tabs spaces trailing space-before-tab newline indentation empty space-after-tab space-mark tab-mark)
      )
(setq inhibit-startup-screen t)
(setq inhibit-startup-buffer-menu nil)
(setq make-backup-files nil)

(use-package ido-completing-read+)
(ido-mode 1)
(ido-everywhere 1)
(ido-ubiquitous-mode 1)

(use-package cl-lib)
(use-package magit)
(setq magit-auto-revert-mode nil)

(use-package ethan-wspace)
(setq mode-require-final-newlines nil)

(use-package editorconfig
  :ensure t
  :config
  (editorconfig-mode 1)
  )

;; --------- themes --------- ;;
;;(use-package gruber-darker-theme)
;;(load-theme 'gruber-darker t)

;; -------- keybinds -------- ;;
(use-package bind-key)

(setq compile-command "./__build.sh || ./build.sh || ranmake || make -k")
(bind-key "C-c C-c" 'compile)

(use-package move-text)
(bind-key "M-p" 'move-text-up)
(bind-key "M-n" 'move-text-down)

(use-package crux)
(bind-key "C-c o" 'crux-open-with)
(bind-key "C-c I" 'crux-find-user-init-file)
(bind-key "C-c ," 'crux-find-user-custom-file)
(bind-key "C-c S" 'crux-find-shell-init-file)

(use-package smex)
(bind-key "M-x"     'smex)
(bind-key "C-c M-x" 'execute-extended-command)

(bind-key "C-c m s" 'magit-status)
(bind-key "C-c m l" 'magit-log)

;; global syntax highlighting
(global-font-lock-mode 1)
(setq font-lock-maximum-decoration t)

(defvar font-lock-todo-keywords
  '(("\\(@@@\\|\\_<BUG:\\|\\_<FIXME:\\|\\_<NB:\\|\\_<NOTE:\\|\\_<TODO:\\|\\_<XXX:\\|\\_<XXX\\_>\\)" . (1 'warning t)))
  "TODO-style keywords for syntax highlighting."
  )

(defun font-lock-add-todo-keywords ()
  "Add syntax highlighting for TODO-style keywords."
  (font-lock-add-keywords nil font-lock-todo-keywords t)
  )

(mapc
 (lambda (mode-hook)
   (add-hook mode-hook #'font-lock-add-todo-keywords)
   )
 '(text-mode-hook prog-mode-hook)
 )

;; ---------- modes --------- ;;
(use-package markdown-mode)

(defconst ran/tab-width 4)

(setq-default indent-tabs-mode nil)
(setq-default electric-indent-mode nil)
(setq-default tab-mode nil)

(setq-default tab-always-indent t)

(setq-default fill-column 96)

(setq-default sentence-end-base "[.?!â€¼â€½â‡âˆâ‰â¸®â€¤â€¥â€¦â€”â€•â€•][])}âŒªâŸ©âŸ«â€¯Â \"'â€˜â€™â€œâ€Â«Â»â€¹â€º]*")
(setq table-time-before-update 0.1)
(setq table-time-before-reformat 0.1)

(setq auto-mode-alist
      (cons '("README.*\\.html?\\'" . mhtml-mode)
      (cons '("README.*\\.md\\'"    . markdown-mode)
      (cons '("README.*\\.org\\'"   . org-mode)
      (cons '("README.*\\.rst\\'"   . rst-mode)
      (cons '("README.*"            . text-mode)
      (cons '("TODO\\'"             . outline-mode)
      (cons '("\\.[hc]\\'"          . ranc-mode)
      auto-mode-alist)))))))
      )
(add-hook 'text-mode-hook
          (lambda ()
            (turn-off-auto-fill)
            (setq fill-individual-varying-indent nil)
            )
          )
(add-hook 'markdown-mode-hook
          (lambda ()
            (setq tab-width 8)
              (toggle-word-wrap 1)
              )
          )
(add-hook 'outline-mode-hook
          (lambda ()
            (setq outline-regexp " *[-*]+")
            )
          )
(add-hook 'emacs-lisp-mode-hook
          'turn-on-eldoc-mode
          )
(add-hook 'lisp-interaction-mode-hook
          'turn-on-eldoc-mode
          )
(add-hook 'ielm-mode-hook
          'turn-on-eldoc-mode
          )

;; C stuff

(defvar ranc-mode-syntax-table
  (let ((table (make-syntax-table)))
    ;; C/C++ style comments
    (modify-syntax-entry ?/ ". 124b" table)
    (modify-syntax-entry ?* ". 23" table)
    (modify-syntax-entry ?\n "> b" table)
    ;; Preprocessor stuff?
    (modify-syntax-entry ?# "." table)
    ;; Chars are the same as strings
    (modify-syntax-entry ?' "\"" table)
    ;; Treat <> as punctuation (needed to highlight C++ keywords
    ;; properly in template syntax)
    (modify-syntax-entry ?< "." table)
    (modify-syntax-entry ?> "." table)

    (modify-syntax-entry ?& "." table)
    (modify-syntax-entry ?% "." table)
    table))

(defun ranc-types ()
  '("char" "int" "long" "short" "void" "bool" "float" "double" "signed" "unsigned"
    "char16_t" "char32_t" "char8_t"
    "int8_t" "uint8_t" "int16_t" "uint16_t" "int32_t" "uint32_t" "int64_t" "uint64_t"
    "uintptr_t"
    "size_t")
  )

(defun ranc-keywords ()
  '("auto" "break" "case" "const" "continue" "default" "do"
    "else" "enum" "extern" "for" "goto" "if" "register"
    "return"  "sizeof" "static" "struct" "switch" "typedef"
    "union"  "volatile" "while" "alignas" "alignof" "and"
    "and_eq" "asm" "atomic_cancel" "atomic_commit" "atomic_noexcept" "bitand"
    "bitor" "catch"  "class" "co_await"
    "co_return" "co_yield" "compl" "concept" "const_cast" "consteval" "constexpr"
    "constinit" "decltype" "delete" "dynamic_cast" "explicit" "export" "false"
    "friend" "inline" "mutable" "namespace" "new" "noexcept" "not" "not_eq"
    "nullptr" "operator" "or" "or_eq" "private" "protected" "public" "reflexpr"
    "reinterpret_cast" "requires" "static_assert" "static_cast" "synchronized"
    "template" "this" "thread_local" "throw" "true" "try" "typeid" "typename"
    "using" "virtual" "wchar_t" "xor" "xor_eq")
  )

(defun ranc-font-lock-keywords ()
  (list
   `("# *[#a-zA-Z0-9_]+" . font-lock-preprocessor-face)
   `("#.*include \\(\\(<\\|\"\\).*\\(>\\|\"\\)\\)" . (1 font-lock-string-face))
   `(,(regexp-opt (ranc-keywords) 'symbols) . font-lock-keyword-face)
   `(,(regexp-opt (ranc-types) 'symbols) . font-lock-type-face))
  )

;;; TODO: try to replace ranc--space-prefix-len with current-indentation
(defun ranc--space-prefix-len (line)
  (- (length line)
     (length (string-trim-left line))
     )
  )

(defun ranc--previous-non-empty-line ()
  (save-excursion
    (forward-line -1)
    (while (and (not (bobp))
                (string-empty-p (string-trim-right (thing-at-point 'line t))))
      (forward-line -1)
      )
    (thing-at-point 'line t)
    )
  )

(defun ranc--desired-indentation ()
  (let ((cur-line (string-trim-right (thing-at-point 'line t)))
        (prev-line (string-trim-right (ranc--previous-non-empty-line)))
        (indent-len 4))
    (cond
     ((and (string-suffix-p "{" prev-line)
           (string-prefix-p "}" (string-trim-left cur-line)))
      (ranc--space-prefix-len prev-line)
      )
     ((string-suffix-p "{" prev-line)
      (+ (ranc--space-prefix-len prev-line) indent-len)
      )
     ((string-prefix-p "}" (string-trim-left cur-line))
      (max (- (ranc--space-prefix-len prev-line) indent-len) 0)
      )
     (t (ranc--space-prefix-len prev-line))
     )
    )
  )

;;; TODO: customizable indentation (amount of spaces, tabs, etc)
(defun ranc-indent-line ()
  (interactive)
  (when (not (bobp))
    (let* ((current-indentation (ranc--space-prefix-len (thing-at-point 'line t)))
           (desired-indentation (ranc--desired-indentation))
           (n (max (- (current-column) current-indentation) 0))
           )
      (indent-line-to desired-indentation)
      (forward-char n)
      )
    )
  )

(define-derived-mode ranc-mode c-mode "ran C"
  "My major mode for editing C files."
  ;;:syntax-table ranc-mode-syntax-table
  ;;(setq-local font-lock-defaults '(ranc-font-lock-keywords))
  ;;(setq-local indent-line-function 'ranc-indent-line)

  (setq-local indent-tabs-mode nil)
  (setq-local electric-indent-mode nil)
  (setq-local tab-mode nil)
  (setq-local tab-always-indent t)
  (setq-local fill-column 96)

  (setq-local c-basic-offset ran/tab-width)
  (setq-local c-tab-width    ran/tab-width)
  (setq-local c-auto-align-backslashes t)


  )

;; compilation mode
(use-package compile)

compilation-error-regexp-alist-alist

(add-to-list 'compilation-error-regexp-alist
             '("\\([a-zA-Z0-9\\.]+\\)(\\([0-9]+\\)\\(,\\([0-9]+\\)\\)?) \\(Warning:\\)?"
               1 2 (4) (5)))


;; remove the irritating fucking whitespace
(add-hook 'before-save-hook
          'delete-trailing-whitespace
          )

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(markdown-mode smex crux move-text editorconfig ethan-wspace magit ido-completing-read+ auto-package-update use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
