clearvars( '-except', '-regexp', '^fig\d*$' );

	% -----------------------------------------------------------------------
	% setup comparing high-pass filters
	% THIS PART IS NOT IMPORTANT FOR FOLLOWING THE LECTURE!
	% -----------------------------------------------------------------------
m = 3; % filter order
cutoff = 0.5; % cutoff frequency, normalized
passripple = 0.5; % passband ripple
stopripple = 10; % stopband ripple

[b1, a1] = butter( m, cutoff, 'high' ); % butterworth filter
[b2, a2] = cheby1( m, passripple, cutoff, 'high' ); % chebyshev type 1 filter
[b3, a3] = cheby2( m, stopripple, cutoff, 'high' ); % chebyshev type 2 filter
[b4, a4] = ellip( m, passripple, stopripple, cutoff, 'high' ); % elliptic filter

	% -----------------------------------------------------------------------
	% get filter responses
	% THIS PART IS NOT IMPORTANT FOR FOLLOWING THE LECTURE!
	% -----------------------------------------------------------------------
h1 = freqz( b1, a1 );
h2 = freqz( b2, a2 );
h3 = freqz( b3, a3 );
h4 = freqz( b4, a4 );

	% -----------------------------------------------------------------------
	% plot filters response
	% THIS PART IS NOT IMPORTANT FOR FOLLOWING THE LECTURE!
	% -----------------------------------------------------------------------

		% general
if exist( 'fig1', 'var' ) ~= 1 || ~ishandle( fig1 ) % prepare figure window
	fig1 = figure( ...
		'Color', [0.9, 0.9, 0.9], 'InvertHardcopy', 'off', ...
		'PaperPosition', [0, 0, 8/5*7, 5/5*7], ...
		'defaultAxesFontName', 'DejaVu Sans Mono', 'defaultAxesFontSize', 16, 'defaultAxesFontWeight', 'bold', ...
		'defaultAxesNextPlot', 'add', ...
		'defaultAxesBox', 'on', 'defaultAxesLayer', 'top', ...
		'defaultAxesXGrid', 'on', 'defaultAxesYGrid', 'on' );
end

figure( fig1 ); % set and clear current figure
clf( fig1 );

		% butterworth
subplot( 2, 2, 1 );

title( 'Butterworth' );
ylabel( 'power' );

xlim( [0, 1] );
ylim( [0, 1] * 1.1 );

plot( linspace( 0, 1, numel( h1 ) ), abs( h1 ).^2, ... % plot filter response
	'Color', 'blue', 'LineWidth', 2 );

plot( [1, 1] * cutoff, get( gca(), 'YLim' ), ... % plot cutoff frequency
	'Color', 'red', 'Linewidth', 2, 'LineStyle', '--' );

		% chebyshev type 1
subplot( 2, 2, 2 );

title( 'Chebyshev (Type I)' );

xlim( [0, 1] );
ylim( [0, 1] * 1.1 );

plot( linspace( 0, 1, numel( h2 ) ), abs( h2 ).^2, ... % plot filter response
	'Color', 'blue', 'LineWidth', 2 );

plot( [1, 1] * cutoff, get( gca(), 'YLim' ), ... % plot cutoff frequency
	'Color', 'red', 'Linewidth', 2, 'LineStyle', '--' );

		% chebyshev type 2
subplot( 2, 2, 3 );

title( 'Chebyshev (Type II)' );
xlabel( 'normalized frequency' );
ylabel( 'power' );

xlim( [0, 1] );
ylim( [0, 1] * 1.1 );

plot( linspace( 0, 1, numel( h3 ) ), abs( h3 ).^2, ... % plot filter response
	'Color', 'blue', 'LineWidth', 2 );

plot( [1, 1] * cutoff, get( gca(), 'YLim' ), ... % plot cutoff frequency
	'Color', 'red', 'Linewidth', 2, 'LineStyle', '--' );

		% elliptic
subplot( 2, 2, 4 );

title( 'Elliptic' );
xlabel( 'normalized frequency' );

xlim( [0, 1] );
ylim( [0, 1] * 1.1 );

plot( linspace( 0, 1, numel( h4 ) ), abs( h4 ).^2, ... % plot filter response
	'Color', 'blue', 'LineWidth', 2 );

plot( [1, 1] * cutoff, get( gca(), 'YLim' ), ... % plot cutoff frequency
	'Color', 'red', 'Linewidth', 2, 'LineStyle', '--' );

	% -----------------------------------------------------------------------
	% write plot image
	% THIS PART IS NOT IMPORTANT FOR FOLLOWING THE LECTURE!
	% -----------------------------------------------------------------------
print( fig1, 'filters', '-depsc2', '-loose' );

