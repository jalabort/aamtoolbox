% HOG descriptors example of sparse HOG.
% Set the window size equal to image size so that the whole image is
% assumed as a single window. Use the 'zhuramanan' method.
% For help on the options type 'help ComputeHOGdescriptor'.

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

%options.Method = 'zhuramanan'; % 'dalaltriggs' and 'zhuramanan'

options.ReturnOnlyWindowsWithinImageLimits = 1;
options.NumberOfOrientationBins = 9;
options.CellHeightAndWidthInPixels = 16;
options.BlockHeightAndWidthInCells = 2;
%options.SignedOrUnsignedGradients = 1;
options.L2normClipping = 0.2;
options.sbin = 4;

options.Output.Windows.Format = 'vector'; % 'martix' = [ numberOfWindowsVertically x numberOfWindowsHorizontally x ... ];
                                             % 'vector' = [ (numberOfWindowsVertically*numberOfWindowsHorizontally) x ... ]
                                             % 'both' Matrix and Vector
options.Output.Windows.Centers = 0; % 0 or 1
options.Output.Descriptors.Format = 'both'; % 'martix' = [ numberOfWindowsVertically x numberOfWindowsHorizontally x ... ];
                                               % 'vector' = [ (numberOfWindowsVertically*numberOfWindowsHorizontally) x ... ]
                                               % 'both' Matrix and Vector
options.GroupOutputMatricesInCellOrStruct = 'cell'; % 'cell', 'struct'

options.PrintInformation = 1;


cas = {'dalaltriggs',0; 'dalaltriggs',1; 'zhuramanan',1};

for casnum=1:3
    options.Method = cas{casnum,1};
    options.SignedOrUnsignedGradients = cas{casnum,2};
    
    figure;
    si = 0;
    for cellsize=[1 2 4 8]
        fprintf('Case: %d/%d,  CellSize: %d\n',casnum,3,cellsize);
        if casnum==3
            options.sbin = cellsize;
        else
            options.CellHeightAndWidthInPixels = cellsize;
        end;
        
        % COMPUTE HOG DESCRIPTORS
        t=cputime;
        outputVar = ComputeHOGdescriptor(inputImage,options);
        fprintf('\n\nElapsed time = %.5f secs\n\n',cputime-t);
        
        % PLOT HOG DESCRIPTORS
        si = si + 1;
        subplot(2,2,si); PlotSparseHOGdescriptors(squeeze(outputVar{1}));
        title(sprintf('%s, %d, %d',cas{casnum,1},cas{casnum,2},cellsize));
    end;
end;

% RMPATH
rmpath(genpath(pwd));