; Copyright (C) 2012 by Grégoire Jadi
; See the file LICENSE for copying permission.

(in-package #:stumpwm)

(set-prefix-key (kbd "s-s"))

;;; Map [prefix s-X] to switch to the group X
(flet ((top-set-key (command &optional prefix)
         (lambda (n)
           (let ((group (format nil "~A" n)))
             (define-key *top-map* (kbd (concat "s-" prefix group)) (concat command " " group))))))
  (mapc (top-set-key "gselect")
        '(1 2 3 4 5 6 7 8 9)))

;;; Map [prefix s-S-X] to move the current window to the group X
(flet ((top-set-key-helper (args)
         (destructuring-bind (key command) args
           (top-set-key (kbd key) command))))
  (mapc #'top-set-key-helper
        `(("s-!"  "gmove 1")
          ("s-@"  "gmove 2")
          ("s-#"  "gmove 3")
          ("s-$"  "gmove 4")
          ("s-%"  "gmove 5")
          ("s-^"  "gmove 6")
          ("s-&"  "gmove 7")
          ("s-*"  "gmove 8")
          ("s-("  "gmove 9")
          ("XF86AudioLowerVolume" ,(spawn "amixer -- sset Master playback 2dB-"))
          ("XF86AudioRaiseVolume" ,(spawn "amixer -- sset Master playback 2dB+"))
          ("XF86AudioMute" ,(spawn "amixer sset Master playback toggle"))
          ("XF86AudioPlay" ,(spawn "mpc toggle"))
          ("XF86AudioStop" ,(spawn "mpc stop"))
          ("XF86AudioNext" ,(spawn "mpc next"))
          ("XF86AudioPrev" ,(spawn "mpc prev")))))

;;; Misc bindings
(flet ((global-set-key-helper (args)
         (destructuring-bind (key command) args
           (global-set-key (kbd key) command))))
  (mapc #'global-set-key-helper
        `(("s-e"        ,(spawn "~/bin/emacsc"))
          ("s-E"        ,(spawn "emacs"))
          ("s-RET"      ,(spawn *xterm*))
          ("RET"        ,(spawn *xterm*))
          ("s-S-RET"    ,(spawn *xterm*))
          ("V"          "vsplit")
          ("H"          "hsplit")
          ("S"          "websearch")
          ("ISO_Left_Tab" "prev"))))

(define-key *groups-map* (kbd "f") "gnew-float")
