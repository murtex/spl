
# tex configuration
SRCDIR="./"
CONFIGDIR="../config/"
IMAGEDIR="../images/"

TEXSRC="\def\srcdir{$(SRCDIR)}\def\configdir{$(CONFIGDIR)}\def\imagedir{$(IMAGEDIR)}\input{main}"

# building
all:
	pdflatex -jobname dsp $(TEXSRC)
	pdflatex -jobname dsp $(TEXSRC)
	pdflatex -jobname dsp $(TEXSRC)

# cleaning
clean:
	rm -f dsp.*

