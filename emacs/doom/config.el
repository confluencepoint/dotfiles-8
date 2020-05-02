;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; refresh' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Zekeriya Koc"
      user-mail-address "zekzekus@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font (font-spec :family "PragmataPro" :size 15))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. These are the defaults.
(setq doom-theme 'nord)

;; If you intend to use org, it is recommended you change this!
(setq org-directory "~/Documents/org/")

;; If you want to change the style of line numbers, change this to `relative' or
;; `nil' to disable it:
(setq display-line-numbers-type nil)

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', where Emacs
;;   looks when you load packages with `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c g k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c g d') to jump to their definition and see how
;; they are implemented.

(add-to-list 'default-frame-alist '(fullscreen . maximized))

(setq mac-command-modifier 'meta
      mac-option-modifier 'none)

(after! prodigy
  (prodigy-define-service
    :name "Voice Foreman"
    :command "foreman"
    :args '("start" "-p" "3000")
    :cwd (projectile-project-root)
    :env '(("WEB_CONCURRENCY" "1"))))

(after! org
  (setq org-log-done 'time)
  (setq org-directory "~/roaming")
  (setq org-agenda-files "agenda_files.list")
  (setq org-refile-targets '(("work.org" :maxlevel . 2)
                             ("personal.org" :maxlevel . 2)
                             ("tickler.org" :maxlevel . 2)
                             ("someday.org" :level . 1)))
  (setq org-refile-use-outline-path 'file)
  (setq org-outline-path-complete-in-steps nil)
  (setq org-refile-allow-creating-parent-nodes 'confirm)
  (setq org-tags-column -89)
  (setq org-todo-keywords
        '((sequence "TODO" "ONGOING" "FOLLOW" "WAITING" "|" "JIRA" "DONE" "CANCELLED")))
  (setq org-default-notes-file (concat org-directory "/inbox.org"))
  (setq org-capture-templates '(("t" "Todo [inbox]" entry
                                 (file+headline org-default-notes-file "Tasks")
                                 "* TODO %i%?")
                                ("T" "Tickler" entry
                                 (file+headline (concat org-directory "/tickler.org") "Tickler")
                                 "* %i%? \n %U"))))

(after! evil
  (defalias #'forward-evil-word #'forward-evil-symbol)
  (map! :n "DEL" 'evil-ex-nohighlight))

(after! ivy
  (setq ivy-use-virtual-buffers t))

(after! projectile
  (setq projectile-completion-system 'ivy))

(after! org-roam
  (setq org-roam-directory "~/roaming")
  (setq org-roam-index-file "index.org")
  (setq org-roam-completion-system 'ivy))
