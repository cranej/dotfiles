;; global variables
(setq
 exec-path (append exec-path '("/usr/local/bin" "~/.cargo/bin" "~/.local/bin"))
 redisplay-dont-pause t
 visible-bell nil
 inhibit-startup-screen t
 create-lockfiles nil
 make-backup-files nil
 x-select-enable-clipboard t
 ;; show keystrokes in progress
 echo-keystrokes 0.1
 ;; we have lots of memory now
 gc-cons-threshold 20000000
 column-number-mode t
 scroll-error-top-bottom t
 auto-save-default nil
 use-package-always-ensure t
 sentence-end-double-space nil)

(setenv "PATH" (concat (getenv "PATH") ":/usr/local/bin" ":~/.cargo/bin" ":~/.local/bin"))

(define-key global-map (kbd "RET") 'newline-and-indent)
(add-hook 'window-setup-hook 'toggle-frame-maximized t)
;; highlight current line / matching parentheses
(global-hl-line-mode t)
(show-paren-mode t)
;; auto refresh buffers
(global-auto-revert-mode t)
;; transparently open compressed files
(auto-compression-mode t)
;; y-n instead of yes-or-no
(defalias 'yes-or-no-p 'y-or-n-p)
;; always line number
(global-display-line-numbers-mode)
;; remove text in active region if inserting text
(delete-selection-mode t)
(tool-bar-mode nil)
;; ido
(setq ido-enable-flex-matching t)
(ido-mode t)
;; emacs server
(require 'server)
(unless (server-running-p)
  (server-start))

;; buffer local
(setq-default
 indent-tabs-mode nil
 tab-width 2
 c-basic-offset 2)

(electric-indent-mode 0) ;;why?

(global-unset-key (kbd "C-z")) ;;why?

;; package manager
(require 'package)
(setq
 package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
		    ("org" . "http://orgmode.org/elpa/")
		    ("melpa" . "http://melpa.org/packages/")
		    ("melpa-stable" . "http://stable.melpa.org/packages/"))
 package-archive-priorities '(("melpa-stable" . 1)))

(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "pandoc"))

(use-package expand-region
  :bind ("C-=" . 'er/expand-region))

(use-package undo-tree
  :config (global-undo-tree-mode)
  :bind ("C-x u" . 'undo-tree-undo))

(use-package org
  :init
  (advice-add 'org-agenda-quit :before 'org-save-all-org-buffers)
  (advice-add 'org-refile :after 'org-save-all-org-buffers)
  :config
  (setq org-agenda-files (quote ("~/org-personal"
                                 "~/org-home"))
        org-refile-targets (quote ((nil :maxlevel . 9)
                                   (org-agenda-files :maxlevel . 9)))
        org-refile-use-outline-path t
        org-outline-path-complete-in-steps nil
        org-refile-allow-creating-parent-nodes (quote confirm)
        org-completion-use-ido t
        org-indirect-buffer-display 'current-window
        org-log-done 'time
        org-capture-templates (quote (("t" "todo" entry (file "~/org-personal/refile.org")
                                       "* TODO %?\n%U\n%a\n\n" :clock-in t :clock-resume t)
                                      ("n" "note" entry (file "~/org-personal/refile.org")
                                       "* %? :NOTE:\n%U\n%a\n\n" :clock-in t :clock-resume t))))
  (unbind-key "C-c [" org-mode-map)
  (unbind-key "C-c ]" org-mode-map)  
  :bind
  (("C-c c" . org-capture)
   ("C-c a" . org-agenda)))

(defun copy-line (arg)
    "Copy lines (as many as prefix argument) in the kill ring.
      Ease of use features:
      - Move to start of next line.
      - Appends the copy on sequential calls.
      - Use newline as last char even on the last line of the buffer.
      - If region is active, copy its lines."
    (interactive "p")
    (let ((beg (line-beginning-position))
          (end (line-end-position arg)))
      (when mark-active
        (if (> (point) (mark))
            (setq beg (save-excursion (goto-char (mark)) (line-beginning-position)))
          (setq end (save-excursion (goto-char (mark)) (line-end-position)))))
      (if (eq last-command 'copy-line)
          (kill-append (buffer-substring beg end) (< end beg))
        (kill-ring-save beg end)))
    (kill-append "\n" nil)
    (beginning-of-line (or (and arg (1+ arg)) 2))
    (if (and arg (not (= 1 arg))) (message "%d lines copied" arg)))

(global-set-key "\C-c\C-k" 'copy-line)
