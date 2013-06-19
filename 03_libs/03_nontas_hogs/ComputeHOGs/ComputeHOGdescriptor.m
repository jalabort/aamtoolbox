function outputVar = ComputeHOGdescriptor(inputImage,HOGoptions)
% ComputeHOGdescriptor  Compute the HOG descriptor of an input image.
% 
% outputVar = ComputeHOGdescriptor(inputImage,HOGoptions)
%
% Inputs:
% inputImage - The input image either in RGB or grayscale format.
% HOGoptions - Struct of the options defined by the user with fields:
% HOGoptions.WindowSize.MetricUnit - string 'blocks' or 'pixels' that
%                 defines the metric unit of the given window size height 
%                 and width. Default value is 'pixels'.
%                      .Height - int defining the window height. Default
%                 value is 30.
%                      .Width - int defining the window width. Default
%                 value is 30.
%           .WindowStep.MetricUnit - string 'cells' or 'pixels' that
%                 defines the metric unit of the given window size height 
%                 and width. Default value is 'pixels'.
%                      .Vertical - int defining the vertical window step.
%                 Default value is 1.
%                      .Horizontal - int defining the horizontal window 
%                 step. Default value is 1.
%                      .ReturnOnlyWindowsWithinImageLimits - set to 1 to
%                 return only the windows within the image size and 0 to
%                 return also the windows that expand outside the image
%                 borders. Default value is 1.
%            .ReturnOnlyWindowsWithinImageLimits - set to 1 to return only
%                 the winows that fit inside the image size without any
%                 padding and to 0 to return all windows with all possible
%                 window centers using padding.
%            .Method - string 'dalaltriggs' or 'zhuramanan' that defines
%                 the method to use for the computation of HOG descriptors. 
%                 the default vaue is 'dalaltriggs'.
%            .NumberOfOrientationBins - int that defines the number of
%                 histogram bins for the gradients' orientation clustering
%                 for 'dalaltriggs' method. Default value is 9.
%            .CellHeightAndWidthInPixels - int that defines the cell height
%                 and width in pixels for 'dalaltriggs' method. Default
%                 value is 8.
%            .BlockHeightAndWidthInCells - int that defines the block
%                 height and width in cells for 'dalaltriggs' method.
%                 Default value is 2.
%            .SignedOrUnsignedGradients - set to 1 to use signed gradients
%                 or 0 to use unsigned gradients for 'dalaltriggs' method.
%                 Default value is 0.
%            .L2normClipping - double that defines the clipping of the
%                 L2-norm for 'dalaltriggs' method. Default value is 0.2.
%            .Output.Windows.Format - string 'matrix' or 'vector' or 'both'. 
%                 If set to 'matrix' the output will be a matrix of size
%                 numberOfWindows_Y x numberOfWindows_X x ..., if set to
%                 'vector' the output will be a matrix of
%                 (numberOfWindows_Y*numberOfWindows_X) x ... and if set to
%                 'both' the output will be both matrices. Default value is
%                 'both'.
%            .Output.Descriptors.Format - string 'matrix' or 'vector' or 'both'. 
%                 If set to 'matrix' the output will be a matrix of size
%                 ... x numberOfBlocks_Y x numberOfBlocks_X x descriptorLength, 
%                 if set to 'vector' the output will be a matrix of
%                 ... x (numberOfBlocks_Y*numberOfBlocks_X*descriptorLength)
%                 and if set to 'both' the output will be both matrices.
%                 Default value is 'both'.
%            .Output.Windows.Centers - set to 1 to return the center's
%                 coordinates of the windows and to 0 in order
%                 not to return them. The size of the coordinates matrix
%                 will be numberOfWindows_Y x numberOfWindows_X x 2 for 
%                 HOGoptions.Output.Windows.Format='matrix', 
%                 (numberOfWindows_Y*numberOfWindows_X) x 2 for 
%                 HOGoptions.Output.Windows.Format='vector' and both
%                 matrices for HOGoptions.Output.Windows.Format='both'.
%                 Default value is 1.
%            .GroupOutputMatricesInCellOrStruct - string 'cell' or 'struct'
%                 to group the output matrix in a cell or struct
%                 respectively. Default value is 'struct'.
%            .PrintInformation - set to 1 to print some information like
%                 the number of windows that fit inside the image and to 0
%                 to print nothing. Default value is 0.
%
% Output:
% outputVar - is a cell or struct depending on the
%             GroupOutputMatricesInCellOrStruct option. The number and
%             sizes of the matrices depends on the Output.Windows.Format, 
%             Output.Descriptors.Format and Output.Windows.Centers
%             options.
%
% outputVar = ComputeHOGdescriptor(inputImage)
% If the options are not given, then the default options values are
% selected.
%
% Epameinondas Antonakos
% 28/03/2013 - created
% 10/06/2013 - bug fixes

if nargin==1
    outputVar = mexComputeHOGdescriptorStruct(double(inputImage));
elseif nargin==2
    % Window Size Metric Unit
    if strcmp(HOGoptions.WindowSize.MetricUnit,'blocks')==1
        windowSizeMetricUnit = 1;
    elseif strcmp(HOGoptions.WindowSize.MetricUnit,'pixels')==1
        windowSizeMetricUnit = 2;
    else
        windowSizeMetricUnit = 3;
    end;
    
    % Window Step Metric Unit
    if strcmp(HOGoptions.WindowStep.MetricUnit,'cells')==1
        windowStepMetricUnit = 1;
    elseif strcmp(HOGoptions.WindowStep.MetricUnit,'pixels')==1
        windowStepMetricUnit = 2;
    else
        windowStepMetricUnit = 3;
    end;
    
    % Output Format of Windows
    if strcmp(HOGoptions.Output.Windows.Format,'matrix')==1
        windowsOutputFormat = 0;
    elseif strcmp(HOGoptions.Output.Windows.Format,'vector')==1
        windowsOutputFormat = 1;
    elseif strcmp(HOGoptions.Output.Windows.Format,'both')==1
        windowsOutputFormat = 2;
    else
        windowsOutputFormat = 3;
    end;
    
    % Output Format of Descriptors
    if strcmp(HOGoptions.Output.Descriptors.Format,'matrix')==1
        descriptorsOutputFormat = 0;
    elseif strcmp(HOGoptions.Output.Descriptors.Format,'vector')==1
        descriptorsOutputFormat = 1;
    elseif strcmp(HOGoptions.Output.Descriptors.Format,'both')==1
        descriptorsOutputFormat = 2;
    else
        descriptorsOutputFormat = 3;
    end;
    
    % Method to Compute HOGs
    if strcmp(HOGoptions.Method,'dalaltriggs')==1
        method = 1;
    elseif strcmp(HOGoptions.Method,'zhuramanan')==1
        method = 2;
    else
        method = 3;
    end;
    
    % Options Vector
    HOGoptionsVector = [HOGoptions.WindowSize.Height,...
        HOGoptions.WindowSize.Width,...
        windowSizeMetricUnit,...
        HOGoptions.WindowStep.Horizontal,...
        HOGoptions.WindowStep.Vertical,...
        windowStepMetricUnit,...
        HOGoptions.ReturnOnlyWindowsWithinImageLimits,...
        HOGoptions.NumberOfOrientationBins,...
        HOGoptions.CellHeightAndWidthInPixels,...
        HOGoptions.BlockHeightAndWidthInCells,...
        HOGoptions.SignedOrUnsignedGradients,...
        HOGoptions.L2normClipping,...
        windowsOutputFormat,...
        HOGoptions.Output.Windows.Centers,...
        descriptorsOutputFormat,...
        method,...
        HOGoptions.CellHeightAndWidthInPixels,...
        HOGoptions.PrintInformation];

    % COMPUTE HOGs
    if strcmp(HOGoptions.GroupOutputMatricesInCellOrStruct,'cell')
        if size(inputImage,3)==3
            outputVar = mexComputeHOGdescriptorCell(double(inputImage),HOGoptionsVector);
        elseif size(inputImage,3)==1
            if method==1
                inputImage = double(inputImage);
                outputVar = mexComputeHOGdescriptorCell(inputImage./max(max(inputImage)),HOGoptionsVector);
            elseif method==2
                inputImage = repmat(inputImage,[1,1,3]);
                outputVar = mexComputeHOGdescriptorCell(double(inputImage),HOGoptionsVector);
            end;
        end;
    elseif strcmp(HOGoptions.GroupOutputMatricesInCellOrStruct,'struct')
        if size(inputImage,3)==3
            outputVar = mexComputeHOGdescriptorStruct(double(inputImage),HOGoptionsVector);
        elseif size(inputImage,3)==1
            if method==1
                inputImage = double(inputImage);
                outputVar = mexComputeHOGdescriptorStruct(inputImage./max(max(inputImage)),HOGoptionsVector);
            elseif method==2
                inputImage = repmat(inputImage,[1,1,3]);
                outputVar = mexComputeHOGdescriptorStruct(double(inputImage),HOGoptionsVector);
            end;
        end;
    else
        error('ERROR:ComputeImageHOGdescriptor:Output matrices can be grouped either as cell or struct.');
    end;
else
    error('ERROR:ComputeImageHOGdescriptor:Wrong number of inputs.');
end;

end