(in-package #:metashell)

(defun shell-command (command)
  ;; BUG: CLisp doesn't allow output to user-specified stream
  (values
   nil
   nil
   (ext:run-shell-command  command :output :terminal :wait t)))