clearvars( '-except', '-regexp', '^fig\d*$' );
ws = warning();
warning( 'off', 'MATLAB:audiovideo:wavread:functionToBeRemoved' );

	% -----------------------------------------------------------------------
	% read a test sound from wave file
	% https://github.com/murtex/spl/blob/master/matlab/sound.wav?raw=true
	% -----------------------------------------------------------------------
[xi, fS, nS] = wavread( 'sound.wav' );

xi = xi(1:end, 1); % restrict to first channel
xi = xi / max( abs( xi ) ); % normalize signal

N = numel( xi ); % number of samples
L = (N - 1) / fS; % length in seconds
ti = linspace( 0, L, N ); % discrete time values

	% -----------------------------------------------------------------------
	% compute instantaneous power (linear and logarithmic)
	% -----------------------------------------------------------------------
Pi = (xi .* xi);
PidB = 10 * log10( Pi );

	% -----------------------------------------------------------------------
	% plot linear scale
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

set( fig1, 'Name', 'LINEAR SCALE' ); % set labels
title( get( fig1, 'Name' ) );

xlabel( 'time in seconds' );
ylabel( 'instantaneous power' );

xlim( [0, L] ); % set axes
ylim( [0, 1] * 1.1 );

plot( ti, Pi, ... % plot linear power
	'Color', 'blue', 'LineWidth', 2 );

	% -----------------------------------------------------------------------
	% plot logarithmic/decibel scale
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

set( fig2, 'Name', 'DECIBEL SCALE' ); % set labels
title( get( fig2, 'Name' ) );

xlabel( 'time in seconds' );
ylabel( 'instantaneous power' );

xlim( [0, L] ); % set axes
minPidB = min( PidB(~isinf( PidB )) );
ylim( [minPidB, -0.1 * minPidB] );

plot( ti, PidB, ... % plot logarithmic power
	'Color', 'blue', 'LineWidth', 2 );

warning( ws );

