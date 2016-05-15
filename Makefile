.PHONY: slides
.PHONY: assign1
.PHONY: images
.PHONY: clean

all: slides assign1

slides:
	pdflatex --shell-escape -jobname slides "\input{latex/slides}"
	pdflatex --shell-escape -jobname slides "\input{latex/slides}"
	pdflatex --shell-escape -jobname slides "\input{latex/slides}"

assign1:
	pdflatex --shell-escape -jobname assign1 "\input{latex/assign1}"
	pdflatex --shell-escape -jobname assign1 "\input{latex/assign1}"
	pdflatex --shell-escape -jobname assign1 "\input{latex/assign1}"

images:
	#cd matlab; matlab -nosplash -nodesktop -r "sampling; print( fig1, '../images/sampling_ad', '-depsc2', '-loose' ); print( fig2, '../images/sampling_da', '-depsc2', '-loose' ); exit();"
	#cd matlab; matlab -nosplash -nodesktop -r "decibel; print( fig1, '../images/linear', '-depsc2', '-loose' ); print( fig2, '../images/decibel', '-depsc2', '-loose' ); exit();"
	#cd matlab; matlab -nosplash -nodesktop -r "fdomain; print( fig1, '../images/fdomain_decomp', '-depsc2', '-loose' ); print( fig2, '../images/fdomain_powspec', '-depsc2', '-loose' ); exit();"
	#cd matlab; matlab -nosplash -nodesktop -r "spectrum; print( fig1, '../images/spectd', '-depsc2', '-loose' ); print( fig2, '../images/specfd', '-depsc2', '-loose' ); exit();"
	#cd matlab; matlab -nosplash -nodesktop -r "spectrum; print( fig1, '../images/spectd2', '-depsc2', '-loose' ); print( fig2, '../images/specfd2', '-depsc2', '-loose' ); exit();"
	#cd matlab; matlab -nosplash -nodesktop -r "filters; print( fig1, '../images/filters_high', '-depsc2', '-loose' ); print( fig2, '../images/filters_low', '-depsc2', '-loose' ); exit();"
	#cd matlab; matlab -nosplash -nodesktop -r "filters2; print( fig1, '../images/filters', '-depsc2', '-loose' ); exit();"
	#cd matlab; matlab -nosplash -nodesktop -r "spectrum; print( fig1, '../images/tatd', '-depsc2', '-loose' ); print( fig2, '../images/tafd', '-depsc2', '-loose' ); exit();"
	#cd matlab; matlab -nosplash -nodesktop -r "windows; print( fig1, '../images/windows', '-depsc2', '-loose' ); exit();"
	#cd matlab; matlab -nosplash -nodesktop -r "specgram; print( fig1, '../images/tawf', '-depsc2', '-loose' ); print( fig2, '../images/tasg', '-depsc2', '-loose' ); exit();"
	#cd matlab; matlab -nosplash -nodesktop -r "specgram; print( fig1, '../images/tawf2', '-depsc2', '-loose' ); print( fig2, '../images/tasg2', '-depsc2', '-loose' ); exit();"
	#cd matlab; matlab -nosplash -nodesktop -r "specgram; print( fig1, '../images/chwf', '-depsc2', '-loose' ); print( fig2, '../images/chsg', '-depsc2', '-loose' ); exit();"
	#cd matlab; matlab -nosplash -nodesktop -r "specgram; print( fig1, '../images/hkwf', '-depsc2', '-loose' ); print( fig2, '../images/hksg', '-depsc2', '-loose' ); exit();"
	cd matlab; matlab -nosplash -nodesktop -r "activity; print( fig1, '../images/ac1', '-depsc2', '-loose' ); print( fig2, '../images/ac2', '-depsc2', '-loose' ); print( fig3, '../images/ac3', '-depsc2', '-loose' ); print( fig4, '../images/ac4', '-depsc2', '-loose' ); exit();"
	#cd matlab; matlab -nosplash -nodesktop -r "landmarks; print( fig1, '../images/lm1', '-depsc2', '-loose' ); print( fig2, '../images/lm2', '-depsc2', '-loose' ); print( fig3, '../images/lm3', '-depsc2', '-loose' ); print( fig4, '../images/lm4', '-depsc2', '-loose' ); exit();"

clean:
	rm -f slides.*
	rm -f assign1.*

