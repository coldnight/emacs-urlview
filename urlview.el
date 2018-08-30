;;; urlview.el -- Find URLs in current buffer and show select narrowing.
;;;
;;; Commentary:
;;;
;;; Find URLs in current buffer and show select narrowing, you can select one
;;; to open it with browse-url.
;;;
;;; Here some test urls:
;;;
;;; http://www.github.com
;;; https://www.github.com
;;; https://www.google.com/search?newwindow=1&client=firefox-b-ab&ei=a2uHW9PqHZDr-QbDvp-wCw&q=emacs+url+regex&oq=emacs+url&gs_l=psy-ab.3.0.35i39k1l2j0i203k1l8.274433.275975.0.277262.9.8.0.0.0.0.408.1038.0j2j1j0j1.4.0....0...1c.1.64.psy-ab..5.4.1038...0j0i131k1j0i67k1j0i12k1.0.7TYdUbrKXug
;;; http://localhost:8000/abc
;;; http://10.0.0.1:800/jjj?ab=cc
;;;
;;; Code:

(defun uv/find-urls-in-current-buffer()
  "Find URLs in current buffer."
  (save-match-data
    (let ((regexp "http\\(?:s\\)?://\\w+\\(?:[-./#\+%&?=_:]\\w*\\)+")
          (string (buffer-string))
          (pos 0)
          matches)
      (while (string-match regexp string pos)
        (push (match-string 0 string) matches)
        (setq pos (match-end 0)))
      (reverse matches))))


(defun uv/browse-url (url)
  "Find URLs in current buffer and open."
  (interactive
   (list
    (completing-read "Chooise a URL: " (uv/find-urls-in-current-buffer))))
  (browse-url url))

(global-set-key (kbd "C-c u v") 'uv/browse-url)

(provide 'urlview)
;; urlview.el ends here
