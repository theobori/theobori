;; My ELisp code to write a README markdown file based on a template file.

(require 'calendar)

(defun get-string-from-file (filePath)
  "Returns file content as string."
  (with-temp-buffer
    (insert-file-contents filePath)
    (buffer-string)))

(defun get-age-from-birth-date (year month day)
  "Returns your current age in years from your birth date described by a YEAR, a
MONTH and a DAY."
  (let* ((current-date (calendar-current-date))
	 (current-year (nth 2 current-date))
	 (current-month (nth 0 current-date))
	 (current-day (nth 1 current-date))
	 (age (- current-year year)))
    (when (or
	   (> year current-year)
	   (and (= year current-year) (> month current-month))
	   (and (= year current-year) (= month current-month) (> day current-day)))
      (error "Invalid birth date."))
    (when (or
	   (< current-month month)
	   (and (= current-month month) (< current-day day)))
      (setq age (1- age)))
    age))

(defun render-then-write-markdown (source destination)
  "Render the SOURCE template and write the result to DESTINATION."
  (let ((content (get-string-from-file source)))
    (setq content (string-replace "{{age}}"
				  (number-to-string (get-age-from-birth-date 2001 01 24))
				  content))
    (setq content (string-replace "{{email-address}}"
				  "theobori@disroot.org"
				  content))

    (with-temp-file destination
      (insert content))))
