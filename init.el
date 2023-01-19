;; Welcome to my Emacs config file!
;; This will become a literate config file when I figure out how the fuck to do that.
;; But this will do for now.
;; Currently this is basically a line for line copy of System Crafter's emacs config
;; tutorial series, but the more elisp I learn, the more this will become my own.

;; Makes the shitty UI less shitty
(scroll-bar-mode -1)     ;; Disable scroll bar
(tool-bar-mode -1)       ;; Disable tool bar
(tooltip-mode -1)        ;; Disable tool tips
(set-fringe-mode 10)     ;; Add a margin
(menu-bar-mode -1)       ;; Disables menu bar

;; Visual bell instead of my computer YELLING AT ME
(setq visible-bell t)

;; LINE AND COLUMN NUMBERS
(column-number-mode)
(global-display-line-numbers-mode)

;; Disable line and column numbers in certain modes
(dolist (mode '(org-mode-hook
		term-mode-hook
		eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

;; Package repos
(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
			 ("melpa-stable" . "https://stable.melpa.org/packages/")
			 ("org" . "https://orgmode.org/elpa/")
			 ("elpa" . "https://elpa.gnu.org/packages/")))
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Initialize use-package on non-linux platforms
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

;; Why did it add this
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("dc8285f7f4d86c0aebf1ea4b448842a6868553eded6f71d1de52f3dcbc960039" "ddffe74bc4bf2c332c2c3f67f1b8141ee1de8fd6b7be103ade50abb97fe70f0c" "1a1ac598737d0fcdc4dfab3af3d6f46ab2d5048b8e72bc22f50271fd6d393a00" "bf948e3f55a8cd1f420373410911d0a50be5a04a8886cabe8d8e471ad8fdba8e" "512ce140ea9c1521ccaceaa0e73e2487e2d3826cc9d287275550b47c04072bc4" "944d52450c57b7cbba08f9b3d08095eb7a5541b0ecfb3a0a9ecd4a18f3c28948" "e3daa8f18440301f3e54f2093fe15f4fe951986a8628e98dcd781efbec7a46f2" default))
 '(package-selected-packages
   '(meow undo-tree golden-ratio org-roam hydra evil-collection evil general all-the-icons doom-themes helpful ivy-rich which-key rainbow-delimiters doom-modeline counsel ivy use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Ivy
(use-package ivy
  :diminish
  :bind (("C-s" . swiper)
	 :map ivy-minibuffer-map
	 ("TAB" . ivy-alt-done)
	 ("C-l" . ivy-alt-done)
	 ("C-j" . ivy-next-line)
	 ("C-k" . ivy-previous-line)
	 :map ivy-switch-buffer-map
	 ("C-k" . ivy-previous-line)
	 ("C-l" . ivy-done)
	 ("C-d" . ivy-switch-buffer-kill)
	 :map ivy-reverse-i-search-map
	 ("C-k" . ivy-previous-line)
	 ("C-d". ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1))

;; Ivy Rich
(use-package ivy-rich
  :init
  (ivy-rich-mode 1))

;; Counsel
(use-package counsel
  :bind (("M-x" . counsel-M-x)
	 ("C-x b" . counsel-ibuffer)
	 ("C-x C-f" . counsel-find-file)
	 :map minibuffer-local-map
	 ("C-r" . 'counsel-minibuffer-history))
  :config
  (setq ivy-initial-inputs-alist nil))

;; Doom modeline for pretty ui
(use-package doom-modeline
  :init (doom-modeline-mode 1))

;; Rainbow Delimiters, so I can understand the nightmare that is ELisp
(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

;; WhichKey, helpful to know what to press next
(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0.3))

;; Helpful, makes help screens actually helpful
(use-package helpful
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap descrive-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))

;; Doom Themes
(use-package doom-themes
  :init (load-theme 'doom-challenger-deep t))

;; Global Keybinds
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; All of this is for Evil mode, I am currently trying out Meow instead

;; General, for special keybinds
;(use-package general
;  :config
;  (general-create-definer spitty/leader-keys
;    :keymaps '(normal insert visual emacs)
;    :prefix "SPC"
;    :global-prefix "C-SPC")

;    (spitty/leader-keys
;    "tt" '(counsel-load-theme :which-key "change theme")
;    "e" '(eval-buffer :which-key "evaluate buffer")
;    "." '(counsel-find-file :which-key "find file")
;    "b" '(ibuffer :which-key "manage buffers")))
 
;; Evil mode, vim in emacs (makes emacs superior)
;(use-package evil
;  :init
;  (setq evil-want-keybinding nil)
;  :config
;  (evil-mode 1)
;  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
;  (evil-global-set-key 'motion "k" 'evil-previous-visual-line))

;; Evil Collection
;(use-package evil-collection
;  :after evil
;  :config
;  (evil-collection-init))

;; Hydra
;(use-package hydra)

;(defhydra hydra-text-scale (:timeout 4)
;  "scale text"
;  ("j" text-scale-increase "in")
;  ("k" text-scale-decrease "out")
;  ("f" nil "finished" :exit t))

;(spitty/leader-keys
;  "z" '(hydra-text-scale/body :which-key "scale text"))

;; Meow
(use-package meow)
(require 'meow)
(defun meow-setup ()
  (setq meow-cheatsheet-layout meow-cheatsheet-layout-qwerty)
  (meow-motion-overwrite-define-key
   '("j" . meow-next)
   '("k" . meow-prev)
   '("<escape>" . ignore))
  (meow-leader-define-key
   ;; SPC j/k will run the original command in MOTION state.
   '("j" . "H-j")
   '("k" . "H-k")
   ;; Use SPC (0-9) for digit arguments.
   '("1" . meow-digit-argument)
   '("2" . meow-digit-argument)
   '("3" . meow-digit-argument)
   '("4" . meow-digit-argument)
   '("5" . meow-digit-argument)
   '("6" . meow-digit-argument)
   '("7" . meow-digit-argument)
   '("8" . meow-digit-argument)
   '("9" . meow-digit-argument)
   '("0" . meow-digit-argument)
   '("/" . meow-keypad-describe-key)
   '("?" . meow-cheatsheet))
  (meow-normal-define-key
   '("0" . meow-expand-0)
   '("9" . meow-expand-9)
   '("8" . meow-expand-8)
   '("7" . meow-expand-7)
   '("6" . meow-expand-6)
   '("5" . meow-expand-5)
   '("4" . meow-expand-4)
   '("3" . meow-expand-3)
   '("2" . meow-expand-2)
   '("1" . meow-expand-1)
   '("-" . negative-argument)
   '(";" . meow-reverse)
   '("," . meow-inner-of-thing)
   '("." . meow-bounds-of-thing)
   '("[" . meow-beginning-of-thing)
   '("]" . meow-end-of-thing)
   '("a" . meow-append)
   '("A" . meow-open-below)
   '("b" . meow-back-word)
   '("B" . meow-back-symbol)
   '("c" . meow-change)
   '("d" . meow-delete)
   '("D" . meow-backward-delete)
   '("e" . meow-next-word)
   '("E" . meow-next-symbol)
   '("f" . meow-find)
   '("g" . meow-cancel-selection)
   '("G" . meow-grab)
   '("h" . meow-left)
   '("H" . meow-left-expand)
   '("i" . meow-insert)
   '("I" . meow-open-above)
   '("j" . meow-next)
   '("J" . meow-next-expand)
   '("k" . meow-prev)
   '("K" . meow-prev-expand)
   '("l" . meow-right)
   '("L" . meow-right-expand)
   '("m" . meow-join)
   '("n" . meow-search)
   '("o" . meow-block)
   '("O" . meow-to-block)
   '("p" . meow-yank)
   '("q" . meow-quit)
   '("Q" . meow-goto-line)
   '("r" . meow-replace)
   '("R" . meow-swap-grab)
   '("s" . meow-kill)
   '("t" . meow-till)
   '("u" . meow-undo)
   '("U" . meow-undo-in-selection)
   '("v" . meow-visit)
   '("w" . meow-mark-word)
   '("W" . meow-mark-symbol)
   '("x" . meow-line)
   '("X" . meow-goto-line)
   '("y" . meow-save)
   '("Y" . meow-sync-grab)
   '("z" . meow-pop-selection)
   '("'" . repeat)
   '("<escape>" . ignore)))
(meow-global-mode 1)

;; Org-mode
(use-package org)

;; Org-Roam
(use-package org-roam
  :ensure t
  :init
  (setq org-roam-v2-ack t)
  :custom
  (org-roam-directory "~/Documents/Org Roam")
  (org-roam-completion-everywhere t)
  (setq org-roam-dailies-directory "journal/")
  :bind (("C-c n l" . org-roam-buffer-toggle)
	 ("C-c n f" . org-roam-node-find)
	 ("C-c n i" . org-roam-node-insert)
	 :map org-mode-map
	 ("C-M-i"   . completion-at-point))
  :config
  (org-roam-setup))

;; Undo Tree
(use-package undo-tree)
(global-undo-tree-mode)

;; Misc Packages
(use-package golden-ratio)
(use-package all-the-icons)
