(eval-and-compile
  (require 'proof-site)			; compilation for tts
  (proof-ready-for-assistant 'tts))

(require 'proof)
(require 'proof-easy-config)		; easy configure mechanism

(proof-easy-config
 'tts "TTS"
 proof-prog-name			"checker --proof-general"
 proof-terminal-string			"."
 proof-arbitrary-undo-positions		t	; or make (proof-last-goal-or-goalsave) work
 proof-kill-goal-command		"Back."
 proof-undo-n-times-cmd			"Back %s."
 proof-ignore-for-undo-count		"Back[^.]*\\."
 proof-script-comment-start		"#"
 proof-script-comment-end		""
 proof-assistant-home-page		"https://github.com/DanGrayson/checker"
 proof-shell-annotated-prompt-regexp	"^i\\([0-9]+\\) = "
 proof-shell-error-regexp		"^File \""
 )

(provide 'tts)
