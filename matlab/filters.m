clearvars( '-except', '-regexp', '^fig\d*$' );

	% -----------------------------------------------------------------------
	% setup commonly used second-order Butterworth filters
	% -----------------------------------------------------------------------
fS = 1000; % sampling rate

m = 2; % filter order
cuthigh = 100; % cutoff frequencies
cutlow = 350;

[bl, al] = butter( m, cutlow / (fS/2), 'low' ); % filter coefficients
[bh, ah] = butter( m, cuthigh / (fS/2), 'high' );

	% -----------------------------------------------------------------------
	% get filter response
	% -----------------------------------------------------------------------
[hl, fl] = freqz( bl, al, 512, fS );
[hh, fh] = freqz( bh, ah, 512, fS );

	% -----------------------------------------------------------------------
	% plot high-pass filter
	% THIS PART IS NOT IMPORTANT FOR FOLLOWING THE LECTURE!
	% -----------------------------------------------------------------------
if exist( 'fig1', 'var' ) ~= 1 || ~ishandle( fig1 ) % prepare figure window
	fig1 = figure( ...
		'Color', [0.9, 0.9, 0.9], 'InvertHardcopy', 'off', ...
		'PaperPosition', [0, 0, 8, 5], ...
		'defaultAxesFontName', 'DejaVu Sans Mono', 'defaultAxesFontSize', 16, 'defaultAxesFontWeight', 'bold', ...
		'defaultAxesNextPlot', 'add', ...
		'defaultAxesBox', 'on', 'defaultAxesLayer', 'top', ...
		'defaultAxesXGrid', 'on', 'defaultAxesYGrid', 'on' );
end

figure( fig1 ); % set and clear current figure
clf( fig1 );

set( fig1, 'Name', 'HIGH-PASS FILTER' ); % set labels
title( get( fig1, 'Name' ) );

xlabel( 'frequency in hertz' );
ylabel( 'power' );

xlim( [0, fS/2] );
ylim( [0, 1] * 1.1 );

plot( fh, abs( hh ).^2, ... % plot filter response
	'Color', 'blue', 'LineWidth', 2 );

plot( [1, 1] * cuthigh, get( gca(), 'XLim' ), ... % plot cutoff frequency
	'Color', 'red', 'Linewidth', 2, 'LineStyle', '--' );

h = legend( ... % show legend
	{sprintf( 'filter response (order: %d)', m ), sprintf( 'cutoff frequency (%.0fHz)', cuthigh )}, ...
	'Location', 'southeast' );
set( h, 'Color', [0.9825, 0.9825, 0.9825] );
	
	% -----------------------------------------------------------------------
	% plot low-pass filter
	% THIS PART IS NOT IMPORTANT FOR FOLLOWING THE LECTURE!
	% -----------------------------------------------------------------------
if exist( 'fig2', 'var' ) ~= 1 || ~ishandle( fig2 ) % prepare figure window
	fig2 = figure( ...
		'Color', [0.9, 0.9, 0.9], 'InvertHardcopy', 'off', ...
		'PaperPosition', [0, 0, 8, 5], ...
		'defaultAxesFontName', 'DejaVu Sans Mono', 'defaultAxesFontSize', 16, 'defaultAxesFontWeight', 'bold', ...
		'defaultAxesNextPlot', 'add', ...
		'defaultAxesBox', 'on', 'defaultAxesLayer', 'top', ...
		'defaultAxesXGrid', 'on', 'defaultAxesYGrid', 'on' );
end

figure( fig2 ); % set and clear current figure
clf( fig2 );

set( fig2, 'Name', 'LOW-PASS FILTER' ); % set labels
title( get( fig2, 'Name' ) );

xlabel( 'frequency in hertz' );
ylabel( 'power' );

xlim( [0, fS/2] );
ylim( [0, 1] * 1.1 );

plot( fl, abs( hl ).^2, ... % plot filter response
	'Color', 'blue', 'LineWidth', 2 );

plot( [1, 1] * cutlow, get( gca(), 'XLim' ), ... % plot cutoff frequency
	'Color', 'red', 'Linewidth', 2, 'LineStyle', '--' );

h = legend( ... % show legend
	{sprintf( 'filter response (order: %d)', m ), sprintf( 'cutoff frequency (%.0fHz)', cutlow )}, ...
	'Location', 'southwest' );
set( h, 'Color', [0.9825, 0.9825, 0.9825] );
	
	% -----------------------------------------------------------------------
	% write plot images
	% THIS PART IS NOT IMPORTANT FOR FOLLOWING THE LECTURE!
	% -----------------------------------------------------------------------
print( fig1, 'filters_high', '-depsc2', '-loose' );
print( fig2, 'filters_low', '-depsc2', '-loose' );

