;; http://cx4a.org/software/auto-complete/manual.html

(require 'el-get-setup)

;; start with default config from auto-complete-config
(require 'auto-complete-config)
(ac-config-default)

;; Go autocompletion
(require 'go-autocomplete)

;; C and C++ auto-completion
(require 'auto-complete-clang-async)
(add-hook 'c-mode-common-hook
	  '(lambda()
	     (setq ac-sources (append '(ac-source-clang-async) ac-sources))
	     (setq ac-clang-complete-executable
						 (format "%s/%s" 
										 (car (el-get-load-path 'auto-complete-clang-async))
										 "clang-complete"))
	     (ac-clang-launch-completion-process)))
(add-hook 'auto-complete-mode-hook 'ac-common-setup)

;; bind toggle-key
(define-key ac-mode-map (kbd "C-c C-c") 'auto-complete)

(provide 'init-auto-complete)
