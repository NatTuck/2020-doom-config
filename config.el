;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; Font
(if (string-equal (system-name) "icewing")
    (setq doom-font (font-spec :family "Hack" :size 22)
          doom-variable-pitch-font (font-spec :family "DejaVu Sans")
          doom-unicode-font (font-spec :family "DejaVu Sans Mono")
          doom-big-font (font-spec :family "Hack" :size 28)))

(if (string-equal (system-name) "greyarea")
    (setq doom-font (font-spec :family "Hack" :size 32)
          doom-variable-pitch-font (font-spec :family "DejaVu Sans")
          doom-unicode-font (font-spec :family "DejaVu Sans Mono")
          doom-big-font (font-spec :family "Hack" :size 36)))

;; Key Bindings
(map! :leader
      (:prefix-map ("o" . "open")
                   :desc "Email" "e" #'=mu4e))

(define-key evil-normal-state-map "Q" 'fill-paragraph)

(defun liu233w/ex-kill-buffer-and-close ()
  (interactive)
  (unless (char-equal (elt (buffer-name) 0) ?*)
    (kill-this-buffer))
  )

(defun liu233w/ex-save-kill-buffer-and-close ()
  (interactive)
  (save-buffer)
  (kill-this-buffer)
  )

(evil-ex-define-cmd "q[uit]" 'liu233w/ex-kill-buffer-and-close)
(evil-ex-define-cmd "wq" 'liu233w/ex-save-kill-buffer-and-close)

(defun my-compose-mode-hook ()
  (local-set-key (kbd "C-c C-c") #'message-send-and-exit))

;(add-hook 'mu4e-compose-mode-hook 'my-compose-mode-hook)

(add-hook 'after-change-major-mode-hook
          (lambda()
            (setq counsel-find-file-ignore-regexp (rx ".#"))
            (smartparens-global-mode -1)
            (auto-insert-mode 0)
            ))

(setq company-idle-delay nil)

(defun my-web-mode-hook ()
  "Hooks for Web mode."
  (setq web-mode-enable-auto-pairing nil)
  (setq web-mode-enable-auto-quoting nil)
  (setq web-mode-enable-auto-expanding nil)
  (setq web-mode-enable-auto-closing nil)

  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  )
(add-hook 'web-mode-hook  'my-web-mode-hook)
(add-to-list 'auto-mode-alist '("\\.eex$" . web-mode))

(defun my-js2-mode-hook ()
  (setq js2-basic-offset 2))
(add-hook 'js2-mode-hook 'my-js2-mode-hook)


;; Mail
(setq mu4e-view-html-plaintext-ratio-heuristic most-positive-fixnum)

(setq mu4e-maildir "/home/nat/Sync/Mail"
      mu4e-drafts-folder "/Drafts"
      user-mail-address "nat@ferrus.net"
      user-full-name "Nat Tuck"
      mail-user-agent 'message-user-agent
      send-mail-function 'message-send-mail-with-sendmail
      message-send-mail-function 'message-send-mail-with-sendmail
      sendmail-program "/usr/bin/msmtp"
      message-sendmail-extra-arguments '("--read-envelope-from")
      message-sendmail-f-is-evil 't
      mu4e-get-mail-command "mbsync -a"
      mu4e-update-interval 300
      )

(setq mu4e-contexts
      `(
        ,(make-mu4e-context
          :name "Fastmail"
          :enter-func (lambda () (mu4e-message "enter context Fastmail"))
          :leave-func (lambda () (mu4e-message "leave context Fastmail"))
          ;; we match based on the contact-fields of the message
          :match-func (lambda (msg)
                        (when msg
                          (string-match-p "^/Mail/Fastmail" (mu4e-message-field msg :maildir))))
          :vars '( (user-mail-address		. "nat@ferrus.net")
                   (user-full-name	    	. "Nat Tuck")
                   (mu4e-drafts-folder		. "/Fastmail/Drafts")
                   (mu4e-trash-folder		. "/Fastmail/Trash")
                   (mu4e-refile-folder		. "/Fastmail/Archive")
                   (mu4e-sent-folder		. "/Fastmail/Sent")
                   ))
        ,(make-mu4e-context
          :name "NEU"
          :enter-func (lambda () (mu4e-message "enter context NEU"))
          :leave-func (lambda () (mu4e-message "leave context NEU"))
          ;; we match based on the contact-fields of the message
          :match-func (lambda (msg)
                        (when msg
                          (string-match-p "^/Mail/NEU" (mu4e-message-field msg :maildir))))
          :vars '( (user-mail-address		. "n.tuck@neu.edu")
                   (user-full-name	    	. "Nat Tuck")
                   (mu4e-drafts-folder		. "/NEU/Drafts")
                   (mu4e-trash-folder		. "/NEU/Trash")
                   (mu4e-refile-folder		. "/NEU/Archive")
                   (mu4e-sent-folder		. "/NEU/Sent")
                   ))
        ))

;; Maybe fix some CPU issues
(setq history-length 10)
(put 'minibuffer-history 'history-length 50)
(put 'evil-ex-history 'history-length 50)
(put 'kill-ring 'history-length 25)
