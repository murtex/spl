clearvars( '-except', '-regexp', '^fig\d*$' );

	% -----------------------------------------------------------------------
	% setup commonly used second-order Butterworth filters
	% -----------------------------------------------------------------------
fS = 1000; % sampling rate

order = 2; % filter order
cuthigh = 100; % cutoff frequencies
cutlow = 350;

[blow, alow] = butter( order, cutlow / (fS/2), 'low' ); % filter coefficients
[bhigh, ahigh] = butter( order, cuthigh / (fS/2), 'high' );

	% -----------------------------------------------------------------------
	% get filter responses
	% -----------------------------------------------------------------------
[hlow, flow] = freqz( blow, alow, 512, fS );
[hhigh, fhigh] = freqz( bhigh, ahigh, 512, fS );

	% -----------------------------------------------------------------------
	% plot high-pass filter
	% THIS PART IS NOT IMPORTANT FOR FOLLOWING THE LECTURE!
	% -----------------------------------------------------------------------
if exist( 'fig1', 'var' ) ~= 1 || ~ishandle( fig1 ) % prepare figure window
	fig1 = figure( ...
		'Color', [0.9, 0.9, 0.9], 'InvertHardcopy', 'off', ...
		'PaperPosition', [0, 0, 8, 6], ...
		'defaultAxesFontName', 'DejaVu Sans Mono', 'defaultAxesFontSize', 20, 'defaultAxesFontWeight', 'bold', ...
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

plot( fhigh, abs( hhigh ).^2, ... % plot filter response
	'Color', 'blue', 'LineWidth', 2 );

plot( [1, 1] * cuthigh, get( gca(), 'XLim' ), ... % cutoff frequency
	'Color', 'red', 'Linewidth', 2, 'LineStyle', '--' );

hl = legend( ... % show legend
	{sprintf( 'response (order: %d)', order ), sprintf( 'cutoff frequency (%.0fHz)', cuthigh )}, ...
	'Location', 'southeast' );
set( hl, 'Color', [0.9825, 0.9825, 0.9825] );
	
	% -----------------------------------------------------------------------
	% plot low-pass filter
	% THIS PART IS NOT IMPORTANT FOR FOLLOWING THE LECTURE!
	% -----------------------------------------------------------------------
if exist( 'fig2', 'var' ) ~= 1 || ~ishandle( fig2 ) % prepare figure window
	fig2 = figure( ...
		'Color', [0.9, 0.9, 0.9], 'InvertHardcopy', 'off', ...
		'PaperPosition', [0, 0, 8, 6], ...
		'defaultAxesFontName', 'DejaVu Sans Mono', 'defaultAxesFontSize', 20, 'defaultAxesFontWeight', 'bold', ...
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

plot( flow, abs( hlow ).^2, ... % plot filter response
	'Color', 'blue', 'LineWidth', 2 );

plot( [1, 1] * cutlow, get( gca(), 'XLim' ), ... % cutoff frequency
	'Color', 'red', 'Linewidth', 2, 'LineStyle', '--' );

hl = legend( ... % show legend
	{sprintf( 'response (order: %d)', order ), sprintf( 'cutoff frequency (%.0fHz)', cutlow )}, ...
	'Location', 'southwest' );
set( hl, 'Color', [0.9825, 0.9825, 0.9825] );
	
	% -----------------------------------------------------------------------
	% write plot images
	% THIS PART IS NOT IMPORTANT FOR FOLLOWING THE LECTURE!
	% -----------------------------------------------------------------------
print( fig1, 'filters_high', '-depsc2' );
print( fig2, 'filters_low', '-depsc2' );

