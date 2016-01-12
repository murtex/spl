
# tex configuration
SRCDIR="./"
CONFIGDIR="../config/"
IMAGEDIR="../images/"

TEXSRC="\def\srcdir{$(SRCDIR)}\def\configdir{$(CONFIGDIR)}\def\imagedir{$(IMAGEDIR)}\input{main}"

# building
all:
	pdflatex --shell-escape -jobname dsp_slides $(TEXSRC)
	pdflatex --shell-escape -jobname dsp_slides $(TEXSRC)
	pdflatex --shell-escape -jobname dsp_slides $(TEXSRC)

# cleaning
clean:
	rm -f dsp_slides.*

