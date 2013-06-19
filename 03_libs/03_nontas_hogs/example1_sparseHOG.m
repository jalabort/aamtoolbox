% HOG descriptors example of sparse HOG.
% Set the window size equal to image size so that the whole image is
% assumed as a single window. Use the 'zhuramanan' method.
% For help on the options type 'help ComputeHOGdescriptor'.
%
% Epameinondas Antonakos - 28/03/2013

% ADDPATH AND COMPILE
addpath(genpath(pwd));
CompileHOGdescriptors;

% LOAD IMAGE
inputImage = imread('im0368.png');

% DEFINE OPTIONS
options.WindowSize.Height = size(inputImage,1);
options.WindowSize.Width = size(inputImage,2);
options.WindowSize.MetricUnit = 'pixels'; % 'blocks', 'pixels'

options.WindowStep.Vertical = size(inputImage,1)/2;
options.WindowStep.Horizontal = size(inputImage,2)/2;
options.WindowStep.MetricUnit = 'pixels'; % 'cells', 'pixels'

options.Method = 'dalaltriggs'; % 'dalaltriggs' and 'zhuramanan'

options.ReturnOnlyWindowsWithinImageLimits = 1;
options.NumberOfOrientationBins = 9;
options.CellHeightAndWidthInPixels = 4;
options.BlockHeightAndWidthInCells = 2;
options.SignedOrUnsignedGradients = 1;
options.L2normClipping = 0.2;

options.Output.Windows.Format = 'vector'; % 'martix' = [ numberOfWindowsVertically x numberOfWindowsHorizontally x ... ];
                                             % 'vector' = [ (numberOfWindowsVertically*numberOfWindowsHorizontally) x ... ]
                                             % 'both' Matrix and Vector
options.Output.Windows.Centers = 0; % 0 or 1
options.Output.Descriptors.Format = 'matrix'; % 'martix' = [ numberOfWindowsVertically x numberOfWindowsHorizontally x ... ];
                                               % 'vector' = [ (numberOfWindowsVertically*numberOfWindowsHorizontally) x ... ]
                                               % 'both' Matrix and Vector
options.GroupOutputMatricesInCellOrStruct = 'cell'; % 'cell', 'struct'

options.PrintInformation = 1;

% COMPUTE HOG DESCRIPTORS
t=cputime;
outputVar = ComputeHOGdescriptor(inputImage,options);
fprintf('\n\nElapsed time = %.5f secs\n\n',cputime-t);

% PLOT HOG DESCRIPTORS
figure;
subplot(1,2,1); imshow(inputImage,[]); title('Original Image');
subplot(1,2,2); PlotSparseHOGdescriptors(squeeze(outputVar{1}));

% RMPATH
rmpath(genpath(pwd));