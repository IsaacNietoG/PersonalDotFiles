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

(setq +latex-viewers '(okular))
 (org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
   (go . t)
   (haskell . t)
   (sql . t)
   ))
(setq org-startup-with-inline-images t)

;; --- Configuración de Exportación Agenda a ICS ---

(setq my-agenda-path (expand-file-name "~/Documents/agendaORG/")) ;; Añadida barra final
(setq my-ics-export-file (expand-file-name "~/Dropbox/Apps/Org/mi_agenda.ics"))

(defun my/export-agenda-to-ics ()
  "Exporta archivos .org a un solo archivo .ics forzando la ruta de destino."
  (interactive)
  (let* ((files (cl-remove-if (lambda (file) (string-match-p "_archive" file))
                             (directory-files my-agenda-path t "\\.org$")))
         ;; FORZAMOS las variables de Org aquí dentro:
         (org-agenda-files files)
         (org-icalendar-combined-agenda-file my-ics-export-file)
         (org-icalendar-directory (file-name-directory my-ics-export-file)))

    ;; Ejecutamos la exportación
    (org-icalendar-combine-agenda-files)

    (message "Agenda exportada correctamente a: %s" my-ics-export-file)))

(add-hook 'org-mode-hook ;; Es mejor añadirlo al hook de org-mode directamente
          (lambda ()
            (add-hook 'after-save-hook
                      (lambda ()
                        (when (file-in-directory-p (buffer-file-name) my-agenda-path)
                          (my/export-agenda-to-ics)))
                      nil t))) ;; El 't' final hace que el hook sea local al buffer
