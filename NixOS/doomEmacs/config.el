(setq doom-theme 'doom-one)
(setq display-line-numbers-type t)
(set-frame-parameter (selected-frame) 'alpha '(95 95))
(add-to-list 'default-frame-alist '(alpha 95 95))
(setq org-directory "~/org/")
(setq org-agenda-files '("~/Documents/agendaORG"))
(setq org-agenda-skip-deadline-prewarning-if-scheduled 'pre-scheduled)
(setq org-deadline-warning-days 14)
(setq org-agenda-skip-scheduled-if-done t
      org-agenda-skip-deadline-if-done t
      org-agenda-skip-timestamp-if-done t)
(setq org-use-fast-todo-selection t)
(setq org-todo-keywords
   '((sequence "TODO(t)" "NEXT(n)" "PROJ(p)" "|" "DONE(d)")
	 (sequence "TASK(T)")
	 (sequence "WAITING(w@/!)" "INACTIVE(i)" "SOMEDAY(s)" "|" "CANCELLED(c@/!)")))

(setq org-todo-keyword-faces
      '(("TODO" :foreground "red" :weight bold)
	    ("TASK" :foreground "#5C888B" :weight bold)
	    ("NEXT" :foreground "blue" :weight bold)
	    ("PROJ" :foreground "magenta" :weight bold)
	    ("DONE" :foreground "forest green" :weight bold)
	    ("WAITING" :foreground "orange" :weight bold)
	    ("INACTIVE" :foreground "magenta" :weight bold)
	    ("SOMEDAY" :foreground "cyan" :weight bold)
	    ("CANCELLED" :foreground "forest green" :weight bold)))
(setq org-log-into-drawer t)
(after! org
  (require 'org-edna)
  (org-edna-mode 1))

(setq +latex-viewers '(okular))
 (org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
   (go . t)
   (haskell . t)
   (sql . t)
   ))
(setq org-startup-with-inline-images t)

(use-package! gptel
  :config
  (setq gptel-backend
        (gptel-make-openai "Groq"
          :host "api.groq.com"
          :endpoint "/openai/v1/chat/completions"
          :stream t
          :key (lambda () 
       (with-temp-buffer
         (insert-file-contents "~/.groq-secret")
         (if (string-match "export GROQ_API_KEY=\"\\(.*\\)\"" (buffer-string))
             (match-string 1 (buffer-string))
           (string-trim (buffer-string)))))
          :models '(llama-3.3-70b-versatile
                    llama-3.1-8b-instant
                    mixtral-8x7b-32768)))

  ;; 2. Establecer el modelo por defecto
  (setq gptel-model 'llama-3.3-70b-versatile))

(map! :leader
      :prefix "l" ; "l" de LLM
      :desc "Gptel Menu" "l" #'gptel-menu
      :desc "Gptel Send" "s" #'gptel-send
      :desc "Gptel Chat" "c" #'gptel)

(use-package! copilot
  :hook (prog-mode . copilot-mode)
  :bind (:map copilot-completion-map
              ("<tab>" . 'copilot-accept-completion)
              ("TAB" . 'copilot-accept-completion)
              ("C-TAB" . 'copilot-accept-completion-by-word)
              ("C-<tab>" . 'copilot-accept-completion-by-word)))
