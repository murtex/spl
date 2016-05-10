clearvars( '-except', '-regexp', '^fig\d*$' );
ws = warning();
warning( 'off', 'MATLAB:audiovideo:wavread:functionToBeRemoved' );

	% -----------------------------------------------------------------------
	% read a test sound from wave file
	% https://github.com/murtex/spl/blob/master/matlab/sound.wav?raw=true
	% -----------------------------------------------------------------------
[xi, fS, nS] = wavread( 'sound.wav' ); % wave filename, EXERCISE

xi = xi(1:end, 1); % restrict to first channel
xi = xi / max( abs( xi ) ); % normalize signal

N = numel( xi ); % number of samples
L = (N - 1) / fS; % length in seconds
ti = linspace( 0, L, N ); % discrete time values

    % -----------------------------------------------------------------------
    % trim test signal length
    % -----------------------------------------------------------------------
xi(ti > 0.4) = [];
ti(ti > 0.4) = [];

N = numel( xi ); % adjust constants
L = (N - 1) / fS;

    % -----------------------------------------------------------------------
    % set up second order butterworth filter and filter test signal
    % -----------------------------------------------------------------------
m = 2; % filter order, EXERCISE
cutoff = 100; % cutoff frequency, EXERCISE
[b, a] = butter( m, cutoff / (fS/2), 'low' ); % low-pass, EXERCISE

xif = filter( b, a, xi );

	% -----------------------------------------------------------------------
	% Fourier transform the test and filtered signals
	% -----------------------------------------------------------------------
fNy = fS / 2; % Nyquist frequency

Xk = fft( xi ) / N; % complex Fourier coefficients
Xkf = fft( xif ) / N;

fk = (0:N-1) / N * fS; % frequency values
fk(fk >= fNy) = fk(fk >= fNy) - fS; % imply negative frequencies

	% -----------------------------------------------------------------------
	% compute power spectral density (aka power spectrum)
	% -----------------------------------------------------------------------
Pk = abs( Xk ) .^ 2;
Pkf = abs( Xkf ) .^ 2;

Pk(fk < 0) = []; % remove negative frequency components
Pkf(fk < 0) = [];
Xk(fk < 0) = [];
Xkf(fk < 0) = [];
fk(fk < 0) = [];

Pk(2:end) = 2 * Pk(2:end); % rescale to match total power
Pkf(2:end) = 2 * Pkf(2:end);
Xk(2:end) = sqrt( 2 ) * Xk(2:end);
Xkf(2:end) = sqrt( 2 ) * Xkf(2:end);

PkdB = 10 * log( Pk ); % transform to decibel
PkfdB = 10 * log( Pkf );

	% -----------------------------------------------------------------------
	% plot waveform
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

set( fig1, 'Name', sprintf( 'WAVEFORM (%dHz, %dbit)', fS, nS ) ); % set labels
title( get( fig1, 'Name' ) );

xlabel( 'time in seconds' );
ylabel( 'amplitude' );

xlim( [0, L] ); % set axes
ylim( [-1, 1] * 1.1 );

plot( ti, xi, ... % plot linear waveform
	'Color', 'blue', 'LineWidth', 2 );
plot( ti, xif, ... % filtered
    'Color', 'red', 'LineWidth', 2 );

h = legend( ... % show legend
	{'test signal', 'filtered signal'}, ...
	'Location', 'southeast' );
set( h, 'Color', [0.9825, 0.9825, 0.9825] );

	% -----------------------------------------------------------------------
	% plot power spectrum
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

set( fig2, 'Name', 'POWER SPECTRUM' ); % set labels
title( get( fig2, 'Name' ) );

xlabel( 'frequency in kilohertz' );
ylabel( 'power in decibel' );

xlim( [0, max( fk )] / 1000 ); % set axes
%ylim( [0, 1] * 1.1 );

plot( fk / 1000, PkdB, ... % plot power spectrum
	'Color', 'blue', 'LineWidth', 2 );
plot( fk / 1000, PkfdB, ... % filtered
    'Color', 'red', 'LineWidth', 2 );

h = legend( ... % show legend
	{'test signal', 'filtered signal'}, ...
	'Location', 'northeast' );
set( h, 'Color', [0.9825, 0.9825, 0.9825] );

warning( ws );


