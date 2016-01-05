
# tex configuration
SRCDIR="./"
CONFIGDIR="../config/"
IMAGEDIR="../images/"

TEXSRC="\def\srcdir{$(SRCDIR)}\def\configdir{$(CONFIGDIR)}\def\imagedir{$(IMAGEDIR)}\input{main}"

# building
all:
	pdflatex -jobname slides $(TEXSRC)
	pdflatex -jobname slides $(TEXSRC)
	pdflatex -jobname slides $(TEXSRC)

# cleaning
clean:
	rm -f slides.*

