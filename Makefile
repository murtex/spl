
# building
all:
	# building slides
	pdflatex --shell-escape -jobname slides "\def\srcdir{slides/}\input{\srcdir/main}"
	pdflatex --shell-escape -jobname slides "\def\srcdir{slides/}\input{\srcdir/main}"
	pdflatex --shell-escape -jobname slides "\def\srcdir{slides/}\input{\srcdir/main}"

# cleaning
clean:
	rm -f slides.*

