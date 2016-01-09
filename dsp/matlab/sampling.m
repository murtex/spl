clearvars -except 'fig_sampling';

	% prepare "continuous" sine signal
L = 1; % length in seconds

f = 2; % sine frequency
dt = 1/1000; % temporal resolution

t = linspace( 0, L, L/dt ); % continuous signal
xt = sin( 2*pi*f * t );

	% quantize continuous signal
fS = 100; % sampling rate, TEST!
nS = 3; % bits per sample, TEST!

N = floor( L*fS + 1 ); % number of samples
i = 1:N; % sample indices

ti = (i-1) / fS; % discrete signal
xi = round( 2^(nS-1) * sin( 2*pi*f * ti ) ) / 2^(nS-1);

	% plot signals
if exist( 'fig_sampling', 'var' ) ~= 1 || ~ishandle( fig_sampling ) % prepare figure window
	fig_sampling = figure( ...
		'defaultAxesNextPlot', 'add', ...
		'defaultAxesXGrid', 'on', 'defaultAxesYGrid', 'on' );
else
	clf( fig_sampling );
end

title( sprintf( 'SAMPLING (continuous signal: %.1fHz, sampling rate: %.1fHz, bits per sample: %d)', ...
	f, fS, nS ) );

xlabel( 'time in seconds' ); % set plot axes
ylabel( 'amplitude' );

xlim( [0, L] );
ylim( [-1, 1] );

plot( t, xt, ... % plot continuous signal
	'Color', 'blue' );

stem( ti, xi, ... % plot discrete signal
	'Color', 'red', 'MarkerSize', 2, 'MarkerFaceColor', 'red', ...
	'ShowBaseLine', 'off' );

legend( {'continuous signal', 'quantized signal'}, ... % show legend
	'Location', 'southwest' );

	% write plot, TODO!

