% HOG descriptors example of dense HOG.
% Set the window size equal to one block and scan the whole image with 1 pixel step
% horizontally and vertically. Allow the windows to expand outside the
% image borders. So the output HOG descriptors are computed at all input
% image pixels (output size = imageHeight x imageWidth x size(HOGdescriptor)).
% Use the 'dalaltriggs' method.
% For help on the options type 'help ComputeHOGdescriptor'.
%
% Epameinondas Antonakos - 28/03/2013

% ADDPATH AND COMPILE
addpath(genpath(pwd));
CompileHOGdescriptors;

% LOAD IMAGE
inputImage = imread('image_0829.png');

% DEFINE OPTIONS
options.WindowSize.Height = 16;
options.WindowSize.Width = 16;
options.WindowSize.MetricUnit = 'pixels'; % 'blocks', 'pixels'

options.WindowStep.Vertical = 1;
options.WindowStep.Horizontal = 1;
options.WindowStep.MetricUnit = 'pixels'; % 'cells', 'pixels'

options.Method = 'dalaltriggs'; % 'dalaltriggs' and 'zhuramanan'

options.ReturnOnlyWindowsWithinImageLimits = 0;
options.NumberOfOrientationBins = 9;
options.CellHeightAndWidthInPixels = 8;
options.BlockHeightAndWidthInCells = 2;
options.SignedOrUnsignedGradients = 1;
options.L2normClipping = 0.2;

options.Output.Windows.Format = 'both'; % 'martix' = [ numberOfWindowsVertically x numberOfWindowsHorizontally x ... ];
                                             % 'vector' = [ (numberOfWindowsVertically*numberOfWindowsHorizontally) x ... ]
                                             % 'both' Matrix and Vector
options.Output.Windows.Centers = 1; % 0 or 1
options.Output.Descriptors.Format = 'both'; % 'martix' = [ numberOfWindowsVertically x numberOfWindowsHorizontally x ... ];
                                               % 'vector' = [ (numberOfWindowsVertically*numberOfWindowsHorizontally) x ... ]
                                               % 'both' Matrix and Vector
options.GroupOutputMatricesInCellOrStruct = 'struct'; % 'cell', 'struct'

options.PrintInformation = 1;

options.DescriptorLength = options.NumberOfOrientationBins*options.BlockHeightAndWidthInCells*options.BlockHeightAndWidthInCells;

% COMPUTE HOG DESCRIPTORS
t=cputime;
outputVar = ComputeHOGdescriptor(inputImage,options);
fprintf('\n\nElapsed time = %.5f secs\n\n',cputime-t);

% PLOT HOG DESCRIPTORS
numberOfChannelsToPrint = 8;
sp = numSubplots(numberOfChannelsToPrint+1);
figure;
subplot(sp(1),sp(2),1); imshow(inputImage,[]); title('Original Image');
for i=1:numberOfChannelsToPrint
    subplot(sp(1),sp(2),i+1);
    PlotDenseHOGdescriptors(outputVar.WindowsMatrixDescriptorsVector,i);
    title(sprintf('Channel %d',i));
end;

% RMPATH
rmpath(genpath(pwd));
