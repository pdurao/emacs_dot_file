;; ===== Set the highlight current line minor mode ===== 
 
 ;; In every buffer, the line which contains the cursor will be fully
 ;; highlighted
 

 ;; (global-hl-line-mode 1)

;;http://homepages.inf.ed.ac.uk/s0243221/emacs/


;; Scroll down with the cursor,move down the buffer one
;; line at a time, instead of in larger amounts.

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(setq scroll-step 1)
;; In Emacs, to set the mod-N indentation used when you hit the TAB key, do this:
;;(setq-default tab-width 4)

;; -----
;; Tab width of most word processors is 8 or 9.
;; But most programmer's editors (eg BeOS's Eddie) use 4.
;; The following two lines are different, note the dash '-'.
;; -----www.jimbrooks.org/web/tools/emacs/dot_emacs.txt
(setq default-tab-width 4)
(setq-default tab-width 4)

;; To cause TAB characters to not be used in the file for compression, and for only spaces to be used, do this:
(setq-default indent-tabs-mode nil)
;; .emacs

;;; uncomment this line to disable loading of "default.el" at startup
;; (setq inhibit-default-init t)
;;//
;;;;(if (>= emacs-major-version 23)
;;;;        (set-default-font "Monospace-14"))

;;;;(set-default-font
;;;;"-adobe-courier-medium-r-normal--18-180-75-75-m-110-iso8859-1")
;; turn on font-lock mode
(when (fboundp 'global-font-lock-mode)
  (global-font-lock-mode t))

;; enable visual feedback on selections
;(setq transient-mark-mode t)

;; default to better frame titles
(setq frame-title-format
      (concat  "%b - emacs@" (system-name)))

;; default to unified diffs
(setq diff-switches "-u")
;; always end a file with a newline
;(setq require-final-newline 'query)
(delete-selection-mode t)               ; allow selection deletion

(setq mouse-yank-at-point t)           ;I-don't-like-mouse-that-much

;; Scroll down with the cursor,move down the buffer one
 ;; line at a time, instead of in larger amounts.
 (setq scroll-step 1)
 (blink-cursor-mode 0)                          ; No blinking cursor

(setq font-lock-maximum-decoration t)
(add-to-list 'load-path "~/color-theme-6.6.0")
(require 'color-theme)
(color-theme-initialize)
;;(color-theme-classic)

;;(require 'color-theme-solarized)

;; Xrefactory configuration part ;;
;; some Xrefactory defaults can be set here
;;;;(defvar xref-current-project nil) ;; can be also "my_project_name"
;;;;(defvar xref-key-binding 'global) ;; can be also 'local or 'none
;;;;(setq load-path (cons "/home/pdurao/xrefactory/xref/emacs" load-path))
;;;;(setq exec-path (cons "/home/pdurao/xrefactory/xref" exec-path))
;;;;(load "xrefactory")
;; end of Xrefactory configuration part ;;
;;;;(message "xrefactory loaded")

(setq vcursor-key-bindings 't)
(load "vcursor")


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun source-linkify ()
  "Make URL at cursor point into a HTML link.
If there's a text selection, use the text selection as input.

Example: http://example.com/xyz.htm
becomes
<a class=\"sorc\" href=\"http://example.com/xyz.htm\" title=\"accessed:2008-12-25\">Source example.com</a>"
  (interactive)
  (let (url resultLinkStr bds p1 p2 domainName)

    ;; get the boundary of URL or text selection
    (if (use-region-p)
        (setq bds (cons (region-beginning) (region-end)) )
      (setq bds (bounds-of-thing-at-point 'url))
      )

    ;; set URL
    (setq p1 (car bds))
    (setq p2 (cdr bds))
    (setq url (buffer-substring-no-properties p1 p2))

    ;; get the domainName
    (string-match "://\\([^\/]+?\\)/" url)
    (setq domainName  (match-string 1 url))

    (setq url (replace-regexp-in-string "&" "&amp;" url))
    (setq resultLinkStr
          (concat "<a class=\"sorc\" href=\"" url "\""
                  " title=\"accessed:" (format-time-string "%Y-%m-%d")
                  "\""
                  ">"
                  "Source " domainName
                  "</a>"))

    ;; delete url and insert the link
    (delete-region p1 p2)
    (insert resultLinkStr)))

(load "url")
(require 'url )
(defun www-get-page-title (url)
   (with-current-buffer (url-retrieve-synchronously url)
     (goto-char 0)
     (re-search-forward "<title>\\(.*\\)<[/]title>" nil t 1)
     (match-string 1)))
;; (www-get-page-title "http://www.emacswiki.org/emacs/Git";)
;;(require 'expand-region)
;;(global-set-key (kbd "C-=") 'er/expand-region)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("f34b107e8c8443fe22f189816c134a2cc3b1452c8874d2a4b2e7bb5fe681a10b" "556ec871d0cbbcd16114939de16be2d567a79fecba0123e9f300ea18bf5daae8" "3979974cb6a0a4ea509db4c2ab8127be7be622d1ec8bbbea7382b1997d4aee23" default))))
;;(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
;; '(mode-line ((t (:background "grey75" :foreground "black" :box (:line-width -1 :style released-button) :height 4)))))
;;(set-face-attribute 'mode-line nil  :height 200)
;;(set-face-attribute 'minibuffer-prompt nil  :height 200)

;; minibuffer-prompt
;;(set-face-attribute 'echo-area nil  :height 200)


;; Gist-ed from in https://github.com/arnab/emacs-starter-kit
;;;;;
(defun fontify-frame (frame)
  (interactive)
  (if window-system
      (progn
        (if (> (x-display-pixel-width) 2000)
            (set-frame-parameter frame 'font "Inconsolata 50") ;; Cinema Display
         (set-frame-parameter frame 'font "Inconsolata 50")))))

;; Fontify current frame
;;(fontify-frame nil)

;; Fontify any future frames
;;(push 'fontify-frame after-make-frame-functions)

(setq focus-follows-mouse t)
(setq mouse-autoselect-window t)
(setq auto-window-vscroll nil)
(setq auto-window-vscroll nil)
(setq scroll-step 1)
(setq scroll-conservatively 10000)
(setq auto-window-vscroll nil)
;;
;;(add-to-list 'load-path "~/tool-bar-plus")
;;(require 'tool-bar+)
;;(tool-bar-pop-up-mode 1)
;;(tool-bar-mode -1)
;;(add-to-list `custom-theme-load-path "~/.emacs.d/themes")
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(set-default-font "Inconsolata-20")
;;(add-to-list 'load-path "~/.emacs.d")
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
(package-initialize)
(require 'auto-complete)
(require 'auto-complete-config)
(ac-config-default)
