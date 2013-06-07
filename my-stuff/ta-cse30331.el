(defvar *dropbox* "/afs/nd.edu/coursefa.09/cse/cse30331.01/dropbox/")

(defun open-record (username assignment)
  "open the Record.txt for grading cse30331 assignments"
  (find-file (concat *dropbox* username "/" assignment "/graded/Record.txt")))


(defvar *badi* "Badi' Abdul-Wahid")

(defun points (assignment)
  (concat "~/Private/TA/cse30331/" assignment "/points.txt"))

   

(defun add-grader (uname assignment grader)
  (open-record uname assignment)
  (search-forward "grader:")
  (insert " ")
  (insert grader))

(defun add-points (uname assignment)
  (search-forward "Comments:")
  (newline)
  (insert-file (points assignment)))
  
(defun grading-add-grade ()
  (interactive)
  (beginning-of-buffer)
  (search-forward "Grade:")
  (insert " "))

(defun grade-prog4 (uname)
  (interactive "Busername")
  (open-record uname "prog4")
  (add-grader uname "prog4" *badi*)
  (add-points uname "prog4"))


  



(provide 'ta-cse30331)
