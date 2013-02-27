;; -*- coding: utf-8 -*-

(require 'proof-site)
(require 'proof)
(require 'proof-easy-config)

(proof-ready-for-assistant 'ts)

(defvar ts-keywords '( "lambda" "Pi" "Sigma" "∏" "λ" "Σ" "Pi" "lambda" "Ulevel" "Type" "Proof"
		       "uexp" "texp" "oexp" "istype" "hastype" "uequal" "tequal" "oequal" "tuequal" "ouequal" 
		       "Texp" "Oexp" "Tequal" "Oequal"
		       "max" "Singleton" "LF_Empty" "pair" "CAR" "CDR" "WildCard" ))

(defvar ts-commands '( "Clear" "Universes" "LF" "TS" "TTS"
		       "Check" "Alpha" "End" "Clear" "Show" "Include" "Back" "BackTo"))

; should use font-lock-compile-keywords !
(defvar ts-mode-font-lock-keywords 
  (progn ; font-lock-compile-keywords
   `(
     ("@\\[\\([[:alnum:]∏∐Σλ_']+\\)\\(;[[:alnum:]_',]+\\)?\\]" 
      (1 font-lock-constant-face))
     (,(concat "\\<\\(" (regexp-opt ts-commands) "\\)\\>") 
      . font-lock-keyword-face)
     ("\\(Variable\\) +\\([[:alnum:]_']+\\)"
      (1 font-lock-keyword-face) 
      (2 font-lock-function-name-face))
     ("\\(Definition\\|Lemma\\|Proposition\\|Corollary\\|Axiom\\|Theorem\\)[[:space:]]*\\(LF\\)?\\( [0-9]+\\(\\.[0-9]+\\)*\\)?[[:space:]]+\\([[:alnum:]∏∐Σλ_']+\\)"
      (1 font-lock-keyword-face) 
      (5 font-lock-function-name-face))
     (,(concat "\\<\\(" (regexp-opt ts-keywords) "\\)\\>") 
      . font-lock-type-face)
     )))

(add-hook 'ts-mode-hook
	  (function
	   (lambda ()
	     (message "entering TS checker mode in buffer %s" (current-buffer))
	     (set (make-local-variable 'comment-column) 60)
	     (set (make-local-variable 'comment-start-skip) "# *")
	     (set (make-local-variable 'transient-mark-mode) t)
	     (setq font-lock-defaults '( ts-mode-font-lock-keywords ))
	     (setq truncate-lines t)
	     (setq case-fold-search nil)
	     )))

(proof-easy-config
 'ts "TS"	    				; the string here must be the symbol's name made upper case
 proof-terminal-string			"."
 proof-save-command-regexp		"Defined." ; not implemented in the checker yet
 proof-script-syntax-table-entries      '( ?# "<" ?\n ">" ?\' "w" ?∏ "w" ?Σ "w" ?λ "w" ?_ "w" ?∐ "w" ?⟶ "_" ?₁ "."  ?₂ "."  ?⟾ "."  ?⟼ "." )
 proof-shell-syntax-table-entries       '(                ?\' "w" ?∏ "w" ?Σ "w" ?λ "w" ?_ "w" ?∐ "w" ?⟶ "_" ?₁ "."  ?₂ "."  ?⟾ "."  ?⟼ "." )
 proof-script-comment-start		"#"
 proof-script-comment-end		""
 proof-prog-name			"checker --proof-general"
 proof-shell-strip-crs-from-input	nil
 proof-arbitrary-undo-positions		nil
 proof-forget-id-command		"Back."
 proof-kill-goal-command		"Back."
 proof-undo-n-times-cmd			"Back %s."
 proof-ignore-for-undo-count		"Back[^.]*\\."
 proof-assistant-home-page		"https://github.com/DanGrayson/checker"
 proof-shell-annotated-prompt-regexp	"^i\\([0-9]+\\) = " ; figure out how to get the statenum here stored in the corresponding span, as in coq/*.el
 proof-shell-error-regexp		"^File \""
 proof-script-font-lock-keywords	ts-mode-font-lock-keywords
 proof-goals-font-lock-keywords		ts-mode-font-lock-keywords
 proof-response-font-lock-keywords	ts-mode-font-lock-keywords
 )

(provide 'ts)
