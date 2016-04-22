.PHONY: slides
.PHONY: images
.PHONY: clean

all: slides

slides:
	pdflatex --shell-escape -jobname slides "\input{latex/main}"
	pdflatex --shell-escape -jobname slides "\input{latex/main}"
	pdflatex --shell-escape -jobname slides "\input{latex/main}"

images:
	cd matlab; matlab -nosplash -nodesktop -r "sampling; print( fig1, '../images/sampling_ad', '-depsc2', '-loose' ); print( fig2, '../images/sampling_da', '-depsc2', '-loose' ); exit();"
	cd matlab; matlab -nosplash -nodesktop -r "fdomain; print( fig1, '../images/fdomain_decomp', '-depsc2', '-loose' ); print( fig2, '../images/fdomain_powspec', '-depsc2', '-loose' ); exit();"
	cd matlab; matlab -nosplash -nodesktop -r "filters; print( fig1, '../images/filters_high', '-depsc2', '-loose' ); print( fig2, '../images/filters_low', '-depsc2', '-loose' ); exit();"
	cd matlab; matlab -nosplash -nodesktop -r "filters2; print( fig1, '../images/filters', '-depsc2', '-loose' ); exit();"

clean:
	rm -f slides.*

# building
#all:
	## building slides
	#pdflatex --shell-escape -jobname slides "\def\srcdir{slides/}\input{\srcdir/main}"
	#pdflatex --shell-escape -jobname slides "\def\srcdir{slides/}\input{\srcdir/main}"
	#pdflatex --shell-escape -jobname slides "\def\srcdir{slides/}\input{\srcdir/main}"
	## zipping matlab scripts
	#zip -r matlab.zip matlab/

## cleaning
#clean:
	#rm -f matlab.zip

