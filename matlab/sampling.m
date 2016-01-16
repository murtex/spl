clearvars( '-except', 'fig_sampling' );

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
	
	% reconstruct signal, TODO: Whittaker-Shannon interpolation!
	
	% plot sampling
if exist( 'fig_sampling', 'var' ) ~= 1 || ~ishandle( fig_sampling ) % prepare figure window
	fig_sampling = figure( ...
		'Name', 'SAMPLING', ...
		'Color', [0.9, 0.9, 0.9], 'InvertHardcopy', 'off', ...
		'defaultAxesFontName', 'DejaVu Sans Mono', 'defaultAxesFontSize', 20, 'defaultAxesFontWeight', 'bold', ...
		'defaultAxesNextPlot', 'add', ...
		'defaultAxesBox', 'on', 'defaultAxesLayer', 'top', ...
		'defaultAxesXGrid', 'on', 'defaultAxesYGrid', 'on' );
end

figure( fig_sampling ); % set and clear current figure
clf( fig_sampling );

title( 'SAMPLING' );

xlabel( 'time in seconds' );
ylabel( 'amplitude' );

xlim( [0, L] ); % set axes
ylim( [-1, 1] );

plot( t, xt, ... % plot continuous signal
	'Color', 'blue', 'LineWidth', 2 );

stem( ti, xi, ... % plot discrete signal
	'Color', 'red', 'LineWidth', 2, 'MarkerSize', 4, 'MarkerFaceColor', 'red', ...
	'ShowBaseLine', 'off' );

legend( ... % show legend
	{sprintf( 'continuous sine (%.1fHz)', f ), sprintf( 'quantization (%.1fHz, %dbit)', fS, nS )}, ...
	'Location', 'southeast' );

	% plot reconstruction, TODO!

	% write image
print( fig_sampling, 'sampling', '-depsc2' );

