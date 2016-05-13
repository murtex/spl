clearvars( '-except', '-regexp', '^fig\d*$' );
ws = warning();
warning( 'off', 'MATLAB:audiovideo:wavread:functionToBeRemoved' );

    % load wave file
[xi, fS, nS] = wavread( 'sound.wav' ); % wave filename, EXERCISE

N = numel( xi ); % number of samples
L = (N - 1) / fS; % length in seconds
ti = linspace( 0, L, N ); % discrete time values

	% -----------------------------------------------------------------------
    % compute spectrogram
	% -----------------------------------------------------------------------
wsize = 10; % window size in milliseconds
woverlap = 66; % window overlap in percent
wfunc = @blackmanharris; % window winction

[Xk, fk, tj] = spectrogram( xi, ...
    wfunc( wsize/1000 * fS ), ... % window funciton
    ceil( woverlap/100 * wsize/1000 * fS ), ... % window overlap
    512, fS ); % fft

Xk = Xk(2:end, :); % remove constant DC
fk = fk(2:end);

	% -----------------------------------------------------------------------
    % convert to power spectrum
	% -----------------------------------------------------------------------
Pk = abs( Xk ) .^ 2;
PkdB = 10 * log10( Pk );

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

	% -----------------------------------------------------------------------
	% plot spectrogram
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

set( fig2, 'Name', sprintf( 'SPECTROGRAM (%dms, %d%%)', wsize, woverlap ) ); % set labels
title( get( fig2, 'Name' ) );

xlabel( 'time in seconds' );
ylabel( 'frequency in kilohertz' );

xlim( [0, L] ); % set axes
ylim( [min( fk ), max( fk )] / 1000 );

colormap( flipud( colormap( 'gray' ) ) );
imagesc( tj, fk / 1000, PkdB );

warning( ws );

