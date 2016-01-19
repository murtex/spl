clearvars( '-except', 'fig_ad', 'fig_da' );

	% -----------------------------------------------------------------------
	% set up a continuous test signal (sine with frequency f and length L)
	% -----------------------------------------------------------------------
f = 1;
L = 1;

x = @( t ) sin( 2*pi*f * t ); % continuous sine with frequency f

	% -----------------------------------------------------------------------
	% quantize the test signal (using sampling rate fS and nS bits/sample)
	% -----------------------------------------------------------------------
fS = 48; % sampling rate, EXERCISE!
nS = 3; % bits per sample, EXERCISE!

N = floor( L * fS );
ti = (0:N-1) / fS; % quantized time values
xi = round( 2^(nS-1) * x( ti ) ) / 2^(nS-1); % quantized amplitudes

	% -----------------------------------------------------------------------
	% reconstruct the signal from qunatization (Whittaker-Shannon)
	% THIS PART IS NOT IMPORTANT FOR FOLLOWING THE LECTURE!
	% -----------------------------------------------------------------------
dt = 1 / 2000; % temporal resolution
t = linspace( 0, L, L / dt );

for j = 1:numel( t )
	sincarg = (t(j) - ti) * fS; % sinc function
	sincarg(find( sincarg == 0)) = 1;
	sincval = sin( pi * sincarg ) ./ (pi * sincarg);

	xr(j) = sum( xi .* sincval ); % reconstructed amplitude
end

fR = sum( abs( diff( xr >= 0 ) ) ) / L / 2; % estimate frequency using zero-crossings, TODO

	% -----------------------------------------------------------------------
	% plot A/D conversion figure
	% THIS PART IS NOT IMPORTANT FOR FOLLOWING THE LECTURE!
	% -----------------------------------------------------------------------
if exist( 'fig_ad', 'var' ) ~= 1 || ~ishandle( fig_ad ) % prepare figure window
	fig_ad = figure( ...
		'Name', 'A/D CONVERSION', ...
		'Color', [0.9, 0.9, 0.9], 'InvertHardcopy', 'off', ...
		'PaperPosition', [0, 0, 8, 6], ...
		'defaultAxesFontName', 'DejaVu Sans Mono', 'defaultAxesFontSize', 20, 'defaultAxesFontWeight', 'bold', ...
		'defaultAxesNextPlot', 'add', ...
		'defaultAxesBox', 'on', 'defaultAxesLayer', 'top', ...
		'defaultAxesXGrid', 'on', 'defaultAxesYGrid', 'on' );
end

figure( fig_ad ); % set and clear current figure
clf( fig_ad );

title( 'A/D CONVERSION' ); % set labels

xlabel( 'time in seconds' );
ylabel( 'amplitude' );

xlim( [0, L] ); % set axes
ylim( [-1, 1] * max( abs( cat( 2, x( t ), xi, xr ) ) ) * 1.1 );

plot( t, x( t ), ... % plot continuous signal
	'Color', 'blue', 'LineWidth', 2 );

stem( ti, xi, ... % plot discrete signal
	'Color', 'red', 'LineWidth', 2, 'MarkerSize', 4, 'MarkerFaceColor', 'red', ...
	'ShowBaseLine', 'off' );

legend( ... % show legend
	{sprintf( 'continuous sine (%.1fHz)', f ), sprintf( 'quantization (%.1fHz, %dbit)', fS, nS )}, ...
	'Location', 'southeast' );
	
print( fig_ad, 'sampling_ad', '-depsc2' ); % write figure

	% -----------------------------------------------------------------------
	% plot D/A conversion figure
	% THIS PART IS NOT IMPORTANT FOR FOLLOWING THE LECTURE!
	% -----------------------------------------------------------------------
if exist( 'fig_da', 'var' ) ~= 1 || ~ishandle( fig_da ) % prepare figure window
	fig_da = figure( ...
		'Name', 'D/A CONVERSION', ...
		'Color', [0.9, 0.9, 0.9], 'InvertHardcopy', 'off', ...
		'PaperPosition', [0, 0, 8, 6], ...
		'defaultAxesFontName', 'DejaVu Sans Mono', 'defaultAxesFontSize', 20, 'defaultAxesFontWeight', 'bold', ...
		'defaultAxesNextPlot', 'add', ...
		'defaultAxesBox', 'on', 'defaultAxesLayer', 'top', ...
		'defaultAxesXGrid', 'on', 'defaultAxesYGrid', 'on' );
end

figure( fig_da ); % set and clear current figure
clf( fig_da );

title( 'D/A CONVERSION' ); % set labels

xlabel( 'time in seconds' );
ylabel( 'amplitude' );

xlim( [0, L] ); % set axes
ylim( [-1, 1] * max( abs( cat( 2, x( t ), xi, xr ) ) ) * 1.1 );

stem( ti, xi, ... % plot discrete signal
	'Color', 'red', 'LineWidth', 2, 'MarkerSize', 4, 'MarkerFaceColor', 'red', ...
	'ShowBaseLine', 'off' );

plot( t, xr, ... % plot reconstructed signal
	'Color', 'blue', 'LineWidth', 2 );

legend( ... % show legend
	{'quantized signal', sprintf( 'reconstruction (~%.1fHz)', fR )}, ...
	'Location', 'southeast' );

print( fig_da, 'sampling_da', '-depsc2' ); % write figure

