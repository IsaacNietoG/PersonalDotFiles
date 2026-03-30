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
    
    :os
    (:if (featurep :system 'macos) macos)
    
    :lang
    (cc +lsp)
    clojure
    (dart +flutter)
    emacs-lisp
    (go +lsp)
    (haskell +lsp)
    json
    (java +lsp)
    javascript
    latex
    markdown
    (rust +lsp)
    sh
    (org +evil)
    
    :email
    
    :app
    everywhere
    
    :config
    (default +bindings +smartparens)
    
)
