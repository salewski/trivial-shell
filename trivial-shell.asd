#|

Author: Gary King

Code originally forked from Kevin Rosenberg's KMRCL and borrowed from
Alexander Repenning's Apple event code. It was then subjected to bursts
of gamma radiation and repeated does of the sonic screwdriver.
|#

(defsystem "trivial-shell"
  :version "0.2.0"
  :author "Gary Warren King <gwking@metabang.com>"
  :maintainer "Gary Warren King <gwking@metabang.com>"
  :licence "MIT Style License"
  :description "OS and Implementation independent access to the shell"
  :components ((:module 
		"notes"
		:pathname "dev/"
		:components 
		((:static-file "notes.text")))
	       (:module
		"timeout"
		:pathname "timeout/"
		:components 
		((:file "package")
		 (:file "with-timeout" :depends-on ("package"))))
	       (:module 
		"setup"
		:pathname "dev/"
		:depends-on ("timeout")
		:components 
		((:file "package")))
	       (:module 
		"dev"
		:depends-on ("setup")
		:components 
		((:file "definitions")
		 (:file "macros")
		 (:file "utilities")
		 (:file "shell"
			:depends-on ("definitions" "macros" #+digitool "mcl"))))
	       (:module
		"port"
		:pathname "dev/"
		:depends-on ("dev")
		:components
		(
		 #+abcl
		 (:file "abcl")
		 #+allegro
		 (:file "allegro")
		 #+clisp
		 (:file "clisp")
		 #+cmu
		 (:file "cmucl")
		 #+digitool
		 (:file "digitool")
		 #+ecl
		 (:file "ecl")
		 #+lispworks
		 (:file "lispworks")
		 #+openmcl
		 (:file "openmcl")
		 #+sbcl
		 (:file "sbcl")
		 #+scl
		 (file "scl")

		 #-(or abcl allegro clisp cmu digitool ecl
		       lispworks openmcl sbcl scl)
		 (:file "unsupported")
		 #+digitool
		 (:module "mcl"
			  :components ((:file "eval-apple-script")))))
               (:module 
		"website"
		:components
		((:module "source"
			  :components ((:static-file "index.md"))))))
  :in-order-to ((test-op (test-op "trivial-shell-test"))))
