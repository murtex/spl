clearvars( '-except', '-regexp', '^fig\d*$' );

	% -----------------------------------------------------------------------
	% setup comparing window functions
	% THIS PART IS NOT IMPORTANT FOR FOLLOWING THE LECTURE!
	% -----------------------------------------------------------------------
wsize = 512;

w1 = rectwin( wsize );
w2 = hamming( wsize );
w3 = hanning( wsize );
w4 = blackmanharris( wsize );

	% -----------------------------------------------------------------------
	% plot window functions
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

		% rectwin
subplot( 2, 2, 1 );

title( 'Rectangular' );
ylabel( 'magnitude' );

xlim( [-1, 1] * 1.1 );
ylim( [0, 1] * 1.1 );

stairs( ((-1:wsize) - wsize/2) / (wsize/2), [0; w1; 0], ... % plot window function
	'Color', 'blue', 'LineWidth', 2 );

		% hamming
subplot( 2, 2, 2 );

title( 'Hamming' );

xlim( [-1, 1] * 1.1 );
ylim( [0, 1] * 1.1 );

stairs( ((-1:wsize) - wsize/2) / (wsize/2), [0; w2; 0], ... % plot window function
	'Color', 'blue', 'LineWidth', 2 );

		% hann
subplot( 2, 2, 3 );

title( 'Hann(-ing)' );
xlabel( 'time' );
ylabel( 'magnitude' );

xlim( [-1, 1] * 1.1 );
ylim( [0, 1] * 1.1 );

stairs( ((-1:wsize) - wsize/2) / (wsize/2), [0; w3; 0], ... % plot window function
	'Color', 'blue', 'LineWidth', 2 );

		% elliptic
subplot( 2, 2, 4 );

title( 'Blackman-Harris' );
xlabel( 'time' );

xlim( [-1, 1] * 1.1 );
ylim( [0, 1] * 1.1 );

stairs( ((-1:wsize) - wsize/2) / (wsize/2), [0; w4; 0], ... % plot window function
	'Color', 'blue', 'LineWidth', 2 );

