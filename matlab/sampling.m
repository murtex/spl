clearvars( '-except', 'fig_ad', 'fig_da' );

	% prepare continuous sine signal
L = 1; % length in seconds

f = 1; % sine frequency
dt = 1/1000; % temporal resolution

t = linspace( 0, L, L/dt ); % "continuous" signal, TEST!
xt = sin( 2*pi*f * t );

	% quantize continuous signal
fS = 48; % sampling rate, TEST!
nS = 3; % bits per sample, TEST!

N = floor( L*fS + 1 ); % number of samples
i = 1:N; % sample indices

ti = (i-1) / fS; % discrete signal
xi = round( 2^(nS-1) * sin( 2*pi*f * ti ) ) / 2^(nS-1);

	% -----------------------------------------------------------------------
	% the next lines are not important for following the lecture!
	% -----------------------------------------------------------------------
	
	% reconstruct signal (whittaker-shannon interpolation)
for j = 1:numel( t )
	sa = pi * (t(j) - (i-1) / fS) * fS; % sinc function
	sa(find( sa == 0)) = 1;
	h = sin( sa ) ./ sa;
	xr(j) = sum( xi .* h ); % reconstructed amplitude
end

fR = sum( abs( diff( xr >= 0 ) ) ) / L / 2; % estimate frequency using zero-crossings
	
	% plot quantization
if exist( 'fig_ad', 'var' ) ~= 1 || ~ishandle( fig_ad ) % prepare figure window
	fig_ad = figure( ...
		'Name', 'QUANTIZATION', ...
		'Color', [0.9, 0.9, 0.9], 'InvertHardcopy', 'off', ...
		'defaultAxesFontName', 'DejaVu Sans Mono', 'defaultAxesFontSize', 20, 'defaultAxesFontWeight', 'bold', ...
		'defaultAxesNextPlot', 'add', ...
		'defaultAxesBox', 'on', 'defaultAxesLayer', 'top', ...
		'defaultAxesXGrid', 'on', 'defaultAxesYGrid', 'on' );
end

figure( fig_ad ); % set and clear current figure
clf( fig_ad );

title( 'QUANTIZATION' );

xlabel( 'time in seconds' );
ylabel( 'amplitude' );

xlim( [0, L] ); % set axes
ylim( [-1, 1] * max( abs( cat( 2, xt, xi, xr ) ) ) * 1.1 );

plot( t, xt, ... % plot continuous signal
	'Color', 'blue', 'LineWidth', 2 );

stem( ti, xi, ... % plot discrete signal
	'Color', 'red', 'LineWidth', 2, 'MarkerSize', 4, 'MarkerFaceColor', 'red', ...
	'ShowBaseLine', 'off' );

legend( ... % show legend
	{sprintf( 'continuous sine (%.1fHz)', f ), sprintf( 'quantization (%.1fHz, %dbit)', fS, nS )}, ...
	'Location', 'southeast' );

	% plot reconstruction
if exist( 'fig_da', 'var' ) ~= 1 || ~ishandle( fig_da ) % prepare figure window
	fig_da = figure( ...
		'Name', 'RECONSTRUCTION', ...
		'Color', [0.9, 0.9, 0.9], 'InvertHardcopy', 'off', ...
		'defaultAxesFontName', 'DejaVu Sans Mono', 'defaultAxesFontSize', 20, 'defaultAxesFontWeight', 'bold', ...
		'defaultAxesNextPlot', 'add', ...
		'defaultAxesBox', 'on', 'defaultAxesLayer', 'top', ...
		'defaultAxesXGrid', 'on', 'defaultAxesYGrid', 'on' );
end

figure( fig_da ); % set and clear current figure
clf( fig_da );

title( 'RECONSTRUCTION' );

xlabel( 'time in seconds' );
ylabel( 'amplitude' );

xlim( [0, L] ); % set axes
ylim( [-1, 1] * max( abs( cat( 2, xt, xi, xr ) ) ) * 1.1 );

stem( ti, xi, ... % plot discrete signal
	'Color', 'red', 'LineWidth', 2, 'MarkerSize', 4, 'MarkerFaceColor', 'red', ...
	'ShowBaseLine', 'off' );

plot( t, xr, ... % plot reconstructed signal
	'Color', 'blue', 'LineWidth', 2 );

legend( ... % show legend
	{'quantized signal', sprintf( 'reconstruction (~%.1fHz)', fR )}, ...
	'Location', 'southeast' );

	% write image
print( fig_ad, 'sampling_ad', '-depsc2' );
print( fig_da, 'sampling_da', '-depsc2' );

