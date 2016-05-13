clearvars();
ws = warning();
warning( 'off', 'MATLAB:audiovideo:wavread:functionToBeRemoved' );

	% -----------------------------------------------------------------------
    % load wave file
	% -----------------------------------------------------------------------
[xi, fS, nS] = wavread( 'sound.wav' );

N = numel( xi ); % number of samples
L = (N - 1) / fS; % length in seconds
ti = linspace( 0, L, N ); % discrete time values

    % -----------------------------------------------------------------------
    % segment signal
	% THIS PART IS NOT IMPORTANT FOR FOLLOWING THE LECTURE!
    % -----------------------------------------------------------------------
wsize = 10; % window size in milliseconds
woverlap = 10; % window overlap in percent
wfunc = @rectwin;

wsizen = ceil( wsize/1000 * fS ); % windowing in number of samples
woverlapn = ceil( woverlap/100 * wsize/1000 * fS );
wstriden = wsizen - woverlapn;

nsegs = ceil( N / wstriden ); % number of segments

Nz = (nsegs-1)*wstriden + wsizen; % zero-pad signal
xiz = cat( 1, xi, zeros( Nz - N, 1 ) );

xj = zeros( wsizen, nsegs ); % split segments
tj = zeros( 1, nsegs );
for i = 1:nsegs
    xj(:, i) = xiz((i-1)*wstriden+1:(i-1)*wstriden+wsizen); % split signal
    xj(:, i) = xj(:, i) .* wfunc( wsizen ); % apply window function
    tj(i) = round( (i-1)*wstriden + wsizen/2 + 1 );
end

    % -----------------------------------------------------------------------
    % fourier transform to power spectra
	% THIS PART IS NOT IMPORTANT FOR FOLLOWING THE LECTURE!
    % -----------------------------------------------------------------------
fNy = fS / 2; % prepare frequencies
f = (0:wsizen-1) / wsizen * fS;
f(f >= fNy) = f(f >= fNy) - fS;

Pj = []; % pre-allocation
for i = 1:nsegs
    X = fft( xj(:, i) ) / wsizen; % fourier coefficients
    P = abs( X ) .^ 2; % power
    P(f < 0) = []; % one-sided power
    P(2:end) = 2 * P(2:end); % rescaling
    Pj = cat( 2, Pj, P ); % accumulate
end

f(f < 0) = []; % positive frequencies only

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

%xlim( [0, L] ); % set axes
%ylim( [min( fk ), max( fk )] / 1000 );

colormap( flipud( colormap( 'gray' ) ) );
%imagesc( tj, fk / 1000, Pj );

warning( ws );
