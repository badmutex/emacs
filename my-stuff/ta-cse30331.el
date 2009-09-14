(defvar *dropbox* "/afs/nd.edu/coursefa.09/cse/cse30331.01/dropbox/")

(defun open-record (username assignment)
  "open the Record.txt for grading cse30331 assignments"
  (find-file (concat *dropbox* username "/" assignment "/graded/Record.txt")))

(defun open-hw1-record (username)
  "open the Record.txt for hw1"
  (open-record username "hw1"))

(defun grade-hw1 (uname)
  "open the Record.txt for hw1 to grade"
  (interactive "Busername:s")
  (open-hw1-record uname))



(provide 'ta-cse30331)
