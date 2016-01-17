
# building
all:
	# building slides
	pdflatex --shell-escape -jobname slides "\def\srcdir{slides/}\input{\srcdir/main}"
	pdflatex --shell-escape -jobname slides "\def\srcdir{slides/}\input{\srcdir/main}"
	pdflatex --shell-escape -jobname slides "\def\srcdir{slides/}\input{\srcdir/main}"
	# zipping matlab scripts
	zip -r matlab.zip matlab/

# cleaning
clean:
	rm -f slides.*
	rm -f matlab.zip

