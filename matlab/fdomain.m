clearvars( '-except', '-regexp', '^fig\d*$' );

	% -----------------------------------------------------------------------
	% a discrete test signal (square wave with frequency f and length L)
	% -----------------------------------------------------------------------
f = 1;
L = 1;

fS = 48; % sampling rate, EXERCISE!
N = floor( L * fS );

ti = (0:N-1) / fS; % quantized time values
xi = 2*(2*floor( f * ti ) - floor( 2*f * ti ) + 1) - 1; % quantized square wave

	% -----------------------------------------------------------------------
	% Fourier transform the test signal
	% -----------------------------------------------------------------------
fNy = fS / 2; % Nyquist frequency

Xk = fft( xi ) / N; % complex Fourier coefficients

fk = (0:N-1) / N * fS; % frequency values
fk(fk > fNy) = fk(fk > fNy) - fS; % imply negative frequencies

	% -----------------------------------------------------------------------
	% compute the power spectral density (aka power spectrum)
	% -----------------------------------------------------------------------
Pk = abs( Xk );

%Pk = abs( Xk ) .^ 2;

%Pk(fk < 0) = []; % remove negative frequency components
%fk(fk < 0) = [];

	% -----------------------------------------------------------------------
	% plot Fourier decomposition
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

set( fig1, 'Name', 'FOURIER DECOMPOSITION' ); % set labels
title( get( fig1, 'Name' ) );

xlabel( 'time in seconds' );
ylabel( 'amplitude' );

xlim( [0, L] ); % set axes

stem( ti, xi, ... % plot discrete signal
	'Color', 'red', 'LineWidth', 2, 'MarkerSize', 4, 'MarkerFaceColor', 'red', ...
	'ShowBaseLine', 'off' );

legend( {sprintf( 'square wave (%.1fHz, @%.1fHz)', f, fS )}, ...
	'Location', 'southeast' );

	% -----------------------------------------------------------------------
	% plot power spectrum
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

set( fig2, 'Name', 'POWER SPECTRUM' ); % set labels
title( get( fig2, 'Name' ) );

xlabel( 'frequency in hertz' );
ylabel( 'power' );

xlim( [-fS, fS] / 2 ); % set axes

stem( fk, Pk, ... % plot power spectrum
	'Color', 'red', 'LineWidth', 2, 'MarkerSize', 4, 'MarkerFaceColor', 'red', ...
	'ShowBaseLine', 'off' );

	% DEBUG
pow1 = mean( xi .* xi )
pow2 = sum( Pk )

	% -----------------------------------------------------------------------
	% write plot images
	% THIS PART IS NOT IMPORTANT FOR FOLLOWING THE LECTURE!
	% -----------------------------------------------------------------------
print( fig1, 'fdomain_decomp', '-depsc2' );
print( fig2, 'fdomain_powspec', '-depsc2' );

