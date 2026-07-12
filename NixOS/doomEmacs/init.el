(doom!
    :input
    :completion
    (company +childframe)
    vertico
    
    :ui
    doom
    doom-dashboard
    hl-todo
    modeline
    ophints
    (popup + defaults)
    (vc-gutter +pretty)
    vi-tilde-fringe
    workspaces
    :editor
    file-templates
    fold
    snippets
    (evil +everywhere)
    
    :emacs
    dired
    electric
    undo
    vc
    
    :term
    vterm
    
    :checkers
    syntax
    
    :tools
    lookup
    lsp
    magit
    pdf
    
    :os
    (:if (featurep :system 'macos) macos)
    
    :lang
    emacs-lisp
    json
    latex
    markdown
    (rust +lsp)
    sh
    (org +evil +dragndrop +pretty)
    (cc +lsp)
    (go +lsp)
    javascript
    python
    clojure
    (java +lsp)
    :email
    
    :app
    everywhere
    
    :config
    (default +bindings +smartparens)
    
)
