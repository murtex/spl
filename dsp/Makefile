
# (la-)tex configuration
SRCDIR="./"
CONFIGDIR="../config/"
IMAGEDIR="../images/"

TEXMAIN="main"
TEXSRC="\def\srcdir{$(SRCDIR)}\def\configdir{$(CONFIGDIR)}\def\imagedir{$(IMAGEDIR)}\input{$(TEXMAIN)}"

# building
all:
	pdflatex -jobname dsp $(TEXSRC)
	pdflatex -jobname dsp $(TEXSRC)
	pdflatex -jobname dsp $(TEXSRC)

# cleaning
clean:
	rm -f dsp.*

