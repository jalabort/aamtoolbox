#include <stdlib.h>
#include <math.h>
#include <mex.h>
#include <vector>

#define eps 0.0001 // small value, used to avoid division by zero

using namespace std;

static inline double min(double x, double y) { return (x <= y ? x : y); }
static inline double max(double x, double y) { return (x <= y ? y : x); }
static inline int min(int x, int y) { return (x <= y ? x : y); }
static inline int max(int x, int y) { return (x <= y ? y : x); }

void ZhuRamananHOGdescriptor(double *inputImage, int sbin, int *imageSize, double *descriptorMatrix);

void DalalTriggsHOGdescriptor(double *inputImage, double *params, int *imageSize, double *descriptorVector, unsigned int grayscale);

void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{
    const float pi = 3.1415926536;
    double *inputImage, *options, *params, *windowImage, *descriptorVector, *descriptorMatrix;
    double *WindowsMatrixDescriptorsMatrix, *WindowsMatrixDescriptorsVector, *WindowsVectorDescriptorsMatrix, *WindowsVectorDescriptorsVector;
    double *WindowsCentersMatrix, *WindowsCentersVector;
    mxArray *windowImageTemp, *descriptorVectorTemp, *descriptorMatrixTemp;
    int imageSize[2], windowSize[2], hist1, hist2,windowHeight,windowWidth,windowStepHorizontal,windowStepVertical;
    int numberOfWindowsHorizontally,numberOfWindowsVertically,numberOfWindows;
    int numberOfBlocksPerWindowHorizontally,numberOfBlocksPerWindowVertically;
    int descriptorLengthPerBlock,descriptorLengthPerWindow,numberOfOutputs,imageWidth,imageHeight;
    int rowCenter,rowFrom,rowTo,columnCenter,columnFrom,columnTo,windowCounter,out[3];
    unsigned int inputImageIsGrayscale,i,j,k,d,d1,d2,d3,d4,d5,windowIndexHorizontal,windowIndexVertical;
    double binsSize;
    mwSize dims2[2],dims3[3],dims4[4],dims5[5];
    
    // Load input image, find its size and return error messages if necessary
    if (nrhs==0)
        mexErrMsgTxt("ERROR:ComputeHOGdescriptor:No input image given.");
    if (mxGetClassID(prhs[0])!=mxDOUBLE_CLASS)
        mexErrMsgTxt("ERROR:ComputeHOGdescriptor:Input image must be of type double.");
    inputImage = mxGetPr(prhs[0]);
    imageSize[0] = mxGetM(prhs[0]);
    imageSize[1] = mxGetN(prhs[0]);
    inputImageIsGrayscale = 1;
    if (mxGetNumberOfDimensions(prhs[0])==3)
    {
        imageSize[1] /= 3;
        inputImageIsGrayscale = 0;
    }
    imageWidth = imageSize[1];
    imageHeight = imageSize[0];
    
    // Load options and return error messages if necessary
    if (nrhs>1)
    {
        options = mxGetPr(prhs[1]);
        if (options[0]<0)
            mexErrMsgTxt("ERROR:ComputeHOGdescriptor:Window height must be positive.");
        if (options[1]<0)
            mexErrMsgTxt("ERROR:ComputeHOGdescriptor:Window width must be positive.");
        if (options[2]!=1 && options[2]!=2)
            mexErrMsgTxt("ERROR:ComputeHOGdescriptor:Set WindowSizeMetricUnit=1 for blocks and 2 for pixels.");
        if (options[3]<=0)
            mexErrMsgTxt("ERROR:ComputeHOGdescriptor:Horizontal window step must be positive.");
        if (options[4]<=0)
            mexErrMsgTxt("ERROR:ComputeHOGdescriptor:Vertical window step must be positive.");
        if (options[5]!=1 && options[5]!=2)
            mexErrMsgTxt("ERROR:ComputeHOGdescriptor:Set WindowStepMetricUnit=1 for cells and 2 for pixels.");
        if (options[6]!=0 && options[6]!=1)
            mexErrMsgTxt("ERROR:ComputeHOGdescriptor:Set ReturnOnlyWindowsWithinImageLimits={0,1} depending if you want to pad edge windows or not.");
        if (options[7]<=0)
            mexErrMsgTxt("ERROR:ComputeHOGdescriptor:Number of orientation bins must be positive.");
        if (options[8]<=0)
            mexErrMsgTxt("ERROR:ComputeHOGdescriptor:Cell size (in pixels) must be positive.");
        if (options[9]<=0)
            mexErrMsgTxt("ERROR:ComputeHOGdescriptor:Block size (in cells) must be positive.");
        if (options[10]!=0 && options[10]!=1)
            mexErrMsgTxt("ERROR:ComputeHOGdescriptor:Set SignedOrUnsignedGradients={0,1} depending if you want signed or unsigned gradients.");
        if (options[11]<=0)
            mexErrMsgTxt("ERROR:ComputeHOGdescriptor:Value for L2-norm clipping must be positive.");
        if (options[12]!=0 && options[12]!=1 && options[12]!=2)
            mexErrMsgTxt("ERROR:ComputeHOGdescriptor:Set OutputWindowsFormat={0,1,2} depending if you want to return Matrix, Vector or Both.");
        if (options[13]!=0 && options[13]!=1)
            mexErrMsgTxt("ERROR:ComputeHOGdescriptor:Set OutputWindowsCenters={0,1} depending if you want to return the windows' upper left corners or not.");
        if (options[14]!=0 && options[14]!=1 && options[14]!=2)
            mexErrMsgTxt("ERROR:ComputeHOGdescriptor:Set OutputDescriptorsFormat={0,1,2} depending if you want to return Matrix, Vector or Both.");
        if (options[15]!=1 && options[15]!=2)
            mexErrMsgTxt("ERROR:ComputeHOGdescriptor:Set Method=1 for DalalTriggs and 2 for ZhuRamanan.");
        if (options[16]<=0)
            mexErrMsgTxt("ERROR:ComputeHOGdescriptor:sbin must be positive.");
        if (options[17]!=0 && options[17]!=1)
            mexErrMsgTxt("ERROR:ComputeHOGdescriptor:Set PrintInformation=1 to enable it and 2 to disable.");
    }
    else
    {
        options = new double[18];
        options[0] = 30; //windowHeight
        options[1] = 30; //windowWidth
        options[2] = 1; //windowSizeMetricUnit
        options[3] = 1; //windowStepHorizontal
        options[4] = 1; //windowStepVertical
        options[5] = 2; //windowStepMetricUnit
        options[6] = 1; //ReturnOnlyWindowsWithinImageLimits
        options[7] = 9; //NumberOfOrientationBins
        options[8] = 8; //CellHeightAndWidthInPixels
        options[9] = 2; //BlockHeightAndWidthInCells
        options[10] = 0; //SignedOrUnsignedGradients
        options[11] = 0.2; //L2normClipping
        options[12] = 2; //OutputWindowsFormat
        options[13] = 1; //OutputWindowsCenters
        options[14] = 2; //OutputDescriptorsFormat
        options[15] = 1; //Method
        options[16] = 4; //sbin
        options[17] = 0; //PrintInformation
    }
    // Load HOG-related options
    unsigned int returnOnlyWindowsWithinImageLimits = (unsigned int) options[6];    
    int numberOfOrientationBins = (int) options[7];
    double cellHeightAndWidthInPixels = options[8];
    int blockHeightAndWidthInCells = (int) options[9];
    unsigned int signedOrUnsignedGradients = (unsigned int) options[10];
    double l2normClipping = options[11];
    unsigned int outputWindowsFormat = (unsigned int) options[12];
    unsigned int outputWindowsCenters = (unsigned int) options[13];
    unsigned int outputDescriptorsFormat = (unsigned int) options[14];
    unsigned int method = (unsigned int) options[15];
    int sbin = (int) options[16];
    unsigned int printInformation = (unsigned int) options[17];
    // Return error if input image is grayscale and method is zhu-ramanan
    if (method==2 && inputImageIsGrayscale==1)
        mexErrMsgTxt("ERROR:ComputeHOGdescriptor:ZhuRamanan method is not yet implemented for grayscale images.");
    // Load windowSize-related options
    if (options[2]==1)
    {
        int windowHeightInBlocks = (int) options[0];
        int windowWidthInBlocks = (int) options[1];
        windowHeight = (int) windowHeightInBlocks*blockHeightAndWidthInCells*cellHeightAndWidthInPixels;
        windowWidth = (int) windowWidthInBlocks*blockHeightAndWidthInCells*cellHeightAndWidthInPixels;
    }
    else if (options[2]==2)
    {
        windowHeight = (int) options[0];
        windowWidth = (int) options[1];
    }
    // Load windowStep-related options
    if (options[5]==1)
    {
        int windowStepHorizontalInCells = (int) options[3];
        int windowStepVerticalInCells = (int) options[4];
        windowStepHorizontal = (int) windowStepHorizontalInCells*cellHeightAndWidthInPixels;
        windowStepVertical = (int) windowStepVerticalInCells*cellHeightAndWidthInPixels;
    }
    else if (options[5]==2)
    {
        windowStepHorizontal = (int) options[3];
        windowStepVertical = (int) options[4];
    }
    
    // Find number of windows based on options and initialize window matrix
    if (returnOnlyWindowsWithinImageLimits==1)
    {
        numberOfWindowsHorizontally = 1+floor((imageWidth-windowWidth)/windowStepHorizontal);
        numberOfWindowsVertically = 1+floor((imageHeight-windowHeight)/windowStepVertical);
    }
    else
    {
        numberOfWindowsHorizontally = ceil(imageWidth/windowStepHorizontal);
        numberOfWindowsVertically = ceil(imageHeight/windowStepVertical);
    }
    numberOfWindows = numberOfWindowsHorizontally*numberOfWindowsVertically;
    if (inputImageIsGrayscale==1)
        windowImageTemp = mxCreateDoubleMatrix(windowHeight,windowWidth,mxREAL);
    else
    {
        mwSize dims[3];
        dims[0] = windowHeight;
        dims[1] = windowWidth;
        dims[2] = 3;
        windowImageTemp = mxCreateNumericArray(3,dims,mxDOUBLE_CLASS,mxREAL);
    }
    windowImage = mxGetPr(windowImageTemp);
    
    // Find descriptor length and hist1 and hist 2
    binsSize = (1+(signedOrUnsignedGradients==1))*pi/numberOfOrientationBins;
    windowSize[0] = windowHeight;
    windowSize[1] = windowWidth;
    if (method==1)
    {
        descriptorLengthPerBlock = blockHeightAndWidthInCells*blockHeightAndWidthInCells*numberOfOrientationBins;
        hist1 = 2+ceil(-0.5 + windowHeight/cellHeightAndWidthInPixels);
        hist2 = 2+ceil(-0.5 + windowWidth/cellHeightAndWidthInPixels);
        descriptorLengthPerWindow = (hist1-2-(blockHeightAndWidthInCells-1))*(hist2-2-(blockHeightAndWidthInCells-1))*descriptorLengthPerBlock;
        descriptorVectorTemp = mxCreateDoubleMatrix(descriptorLengthPerWindow,1,mxREAL);
        descriptorVector = mxGetPr(descriptorVectorTemp);
        // both ways of calculating number of blocks are equal
        //numberOfBlocksPerWindowVertically = 1+floor((windowHeight-blockHeightAndWidthInCells*cellHeightAndWidthInPixels)/cellHeightAndWidthInPixels);
        //numberOfBlocksPerWindowHorizontally = 1+floor((windowWidth-blockHeightAndWidthInCells*cellHeightAndWidthInPixels)/cellHeightAndWidthInPixels);
        numberOfBlocksPerWindowVertically = hist1-2-(blockHeightAndWidthInCells-1);
        numberOfBlocksPerWindowHorizontally = hist2-2-(blockHeightAndWidthInCells-1);
        dims3[0] = numberOfBlocksPerWindowVertically;
        dims3[1] = numberOfBlocksPerWindowHorizontally;
        dims3[2] = descriptorLengthPerBlock;
        descriptorMatrixTemp = mxCreateNumericArray(3,dims3,mxDOUBLE_CLASS,mxREAL);
        descriptorMatrix = mxGetPr(descriptorMatrixTemp);
    }
    else if (method==2)
    {
        hist1 = (int)round((double)windowHeight/(double)sbin);
        hist2 = (int)round((double)windowWidth/(double)sbin);
        out[0] = max(hist1-2,0);
        out[1] = max(hist2-2,0);
        out[2] = 27+4;
        descriptorMatrixTemp = mxCreateNumericArray(3,out,mxDOUBLE_CLASS,mxREAL);
        descriptorMatrix = mxGetPr(descriptorMatrixTemp);
        numberOfBlocksPerWindowHorizontally = out[1];
        numberOfBlocksPerWindowVertically = out[0];
        descriptorLengthPerBlock = out[2];
        descriptorLengthPerWindow = numberOfBlocksPerWindowHorizontally*numberOfBlocksPerWindowVertically*descriptorLengthPerBlock;
    }
    
    // Print information if asked
    if (printInformation==1)
    {
        printf("Input image is grayscale = %d\n",inputImageIsGrayscale);
        printf("Windows Size = %d x %d pixels\n",windowHeight,windowWidth);
        printf("Windows Step = %d x %d pixels\n",windowStepVertical,windowStepHorizontal);
        printf("Number of Windows = %d x %d = %d\n",numberOfWindowsVertically,numberOfWindowsHorizontally,numberOfWindows);
        printf("Descriptor per window = %d x %d x %d = %d x 1\n",numberOfBlocksPerWindowVertically,numberOfBlocksPerWindowHorizontally,descriptorLengthPerBlock,descriptorLengthPerWindow);
        if (method==1)
            printf("Method of Dalal & Triggs\n");
        else if (method==2)
            printf("Method of Zhu & Ramanan\n");
    }
    

    // Find number of outputs
    if (outputWindowsCenters==0)
    {
        if (outputWindowsFormat==0)
        {
            if (outputDescriptorsFormat==0)
                numberOfOutputs = 1;
            else if (outputDescriptorsFormat==1)
                numberOfOutputs = 1;
            else if (outputDescriptorsFormat==2)
                numberOfOutputs = 2;
        }
        else if (outputWindowsFormat==1)
        {
            if (outputDescriptorsFormat==0)
                numberOfOutputs = 1;
            else if (outputDescriptorsFormat==1)
                numberOfOutputs = 1;
            else if (outputDescriptorsFormat==2)
                numberOfOutputs = 2;
        }
        else if (outputWindowsFormat==2)
        {
            if (outputDescriptorsFormat==0)
                numberOfOutputs = 2;
            else if (outputDescriptorsFormat==1)
                numberOfOutputs = 2;
            else if (outputDescriptorsFormat==2)
                numberOfOutputs = 4;
        }
    }
    else if (outputWindowsCenters==1)
    {
        if (outputWindowsFormat==0)
        {
            if (outputDescriptorsFormat==0)
                numberOfOutputs = 2;
            else if (outputDescriptorsFormat==1)
                numberOfOutputs = 2;
            else if (outputDescriptorsFormat==2)
                numberOfOutputs = 3;
        }
        else if (outputWindowsFormat==1)
        {
            if (outputDescriptorsFormat==0)
                numberOfOutputs = 2;
            else if (outputDescriptorsFormat==1)
                numberOfOutputs = 2;
            else if (outputDescriptorsFormat==2)
                numberOfOutputs = 3;
        }
        else if (outputWindowsFormat==2)
        {
            if (outputDescriptorsFormat==0)
                numberOfOutputs = 4;
            else if (outputDescriptorsFormat==1)
                numberOfOutputs = 4;
            else if (outputDescriptorsFormat==2)
                numberOfOutputs = 6;
        }
    }
    if (nlhs>numberOfOutputs)
        mexErrMsgTxt("ERROR:ComputeHOGdescriptor:Too many output arguments.");
    
    // Initialize output matrices
    if (outputWindowsCenters==0)
    {
        if (outputWindowsFormat==0)
        {
            if (outputDescriptorsFormat==0)
            {   // Matrix-Matrix
                dims5[0] = numberOfWindowsVertically;
                dims5[1] = numberOfWindowsHorizontally;
                dims5[2] = numberOfBlocksPerWindowVertically;
                dims5[3] = numberOfBlocksPerWindowHorizontally;
                dims5[4] = descriptorLengthPerBlock;
                plhs[0] = mxCreateNumericArray(5,dims5,mxDOUBLE_CLASS,mxREAL);
                WindowsMatrixDescriptorsMatrix = mxGetPr(plhs[0]);
            }
            else if (outputDescriptorsFormat==1)
            {   // Matrix-Vector
                dims3[0] = numberOfWindowsVertically;
                dims3[1] = numberOfWindowsHorizontally;
                dims3[2] = descriptorLengthPerWindow;
                plhs[0] = mxCreateNumericArray(3,dims3,mxDOUBLE_CLASS,mxREAL);
                WindowsMatrixDescriptorsVector = mxGetPr(plhs[0]);
            }
            else if (outputDescriptorsFormat==2)
            {   // Matrix-Matrix and Matrix-Vector
                dims5[0] = numberOfWindowsVertically;
                dims5[1] = numberOfWindowsHorizontally;
                dims5[2] = numberOfBlocksPerWindowVertically;
                dims5[3] = numberOfBlocksPerWindowHorizontally;
                dims5[4] = descriptorLengthPerBlock;
                plhs[0] = mxCreateNumericArray(5,dims5,mxDOUBLE_CLASS,mxREAL);
                WindowsMatrixDescriptorsMatrix = mxGetPr(plhs[0]);
                
                dims3[0] = numberOfWindowsVertically;
                dims3[1] = numberOfWindowsHorizontally;
                dims3[2] = descriptorLengthPerWindow;
                plhs[1] = mxCreateNumericArray(3,dims3,mxDOUBLE_CLASS,mxREAL);
                WindowsMatrixDescriptorsVector = mxGetPr(plhs[1]);
            }
        }
        else if (outputWindowsFormat==1)
        {
            if (outputDescriptorsFormat==0)
            {   // Vector-Matrix
                dims4[0] = numberOfWindows;
                dims4[1] = numberOfBlocksPerWindowVertically;
                dims4[2] = numberOfBlocksPerWindowHorizontally;
                dims4[3] = descriptorLengthPerBlock;
                plhs[0] = mxCreateNumericArray(4,dims4,mxDOUBLE_CLASS,mxREAL);
                WindowsVectorDescriptorsMatrix = mxGetPr(plhs[0]);
            }
            else if (outputDescriptorsFormat==1)
            {   // Vector-Vector
                dims2[0] = numberOfWindows;
                dims2[1] = descriptorLengthPerWindow;
                plhs[0] = mxCreateNumericArray(2,dims2,mxDOUBLE_CLASS,mxREAL);
                WindowsVectorDescriptorsVector = mxGetPr(plhs[0]);
            }
            else if (outputDescriptorsFormat==2)
            {   // Vector-Matrix and Vector-Vector
                dims4[0] = numberOfWindows;
                dims4[1] = numberOfBlocksPerWindowVertically;
                dims4[2] = numberOfBlocksPerWindowHorizontally;
                dims4[3] = descriptorLengthPerBlock;
                plhs[0] = mxCreateNumericArray(4,dims4,mxDOUBLE_CLASS,mxREAL);
                WindowsVectorDescriptorsMatrix = mxGetPr(plhs[0]);
                
                dims2[0] = numberOfWindows;
                dims2[1] = descriptorLengthPerWindow;
                plhs[1] = mxCreateNumericArray(2,dims2,mxDOUBLE_CLASS,mxREAL);
                WindowsVectorDescriptorsVector = mxGetPr(plhs[1]);
            }
        }
        else if (outputWindowsFormat==2)
        {
            if (outputDescriptorsFormat==0)
            {   // Matrix-Matrix and Vector-Matrix
                dims5[0] = numberOfWindowsVertically;
                dims5[1] = numberOfWindowsHorizontally;
                dims5[2] = numberOfBlocksPerWindowVertically;
                dims5[3] = numberOfBlocksPerWindowHorizontally;
                dims5[4] = descriptorLengthPerBlock;
                plhs[0] = mxCreateNumericArray(5,dims5,mxDOUBLE_CLASS,mxREAL);
                WindowsMatrixDescriptorsMatrix = mxGetPr(plhs[0]);
                
                dims4[0] = numberOfWindows;
                dims4[1] = numberOfBlocksPerWindowVertically;
                dims4[2] = numberOfBlocksPerWindowHorizontally;
                dims4[3] = descriptorLengthPerBlock;
                plhs[1] = mxCreateNumericArray(4,dims4,mxDOUBLE_CLASS,mxREAL);
                WindowsVectorDescriptorsMatrix = mxGetPr(plhs[1]);
            }
            else if (outputDescriptorsFormat==1)
            {   // Matrix-Vector and Vector-Vector
                dims3[0] = numberOfWindowsVertically;
                dims3[1] = numberOfWindowsHorizontally;
                dims3[2] = descriptorLengthPerWindow;
                plhs[0] = mxCreateNumericArray(3,dims3,mxDOUBLE_CLASS,mxREAL);
                WindowsMatrixDescriptorsVector = mxGetPr(plhs[0]);
                
                dims2[0] = numberOfWindows;
                dims2[1] = descriptorLengthPerWindow;
                plhs[1] = mxCreateNumericArray(2,dims2,mxDOUBLE_CLASS,mxREAL);
                WindowsVectorDescriptorsVector = mxGetPr(plhs[1]);
            }
            else if (outputDescriptorsFormat==2)
            {   // Matrix-Matrix and Vector-Matrix and Matrix-Vector and Vector-Vector
                dims5[0] = numberOfWindowsVertically;
                dims5[1] = numberOfWindowsHorizontally;
                dims5[2] = numberOfBlocksPerWindowVertically;
                dims5[3] = numberOfBlocksPerWindowHorizontally;
                dims5[4] = descriptorLengthPerBlock;
                plhs[0] = mxCreateNumericArray(5,dims5,mxDOUBLE_CLASS,mxREAL);
                WindowsMatrixDescriptorsMatrix = mxGetPr(plhs[0]);
                
                dims4[0] = numberOfWindows;
                dims4[1] = numberOfBlocksPerWindowVertically;
                dims4[2] = numberOfBlocksPerWindowHorizontally;
                dims4[3] = descriptorLengthPerBlock;
                plhs[1] = mxCreateNumericArray(4,dims4,mxDOUBLE_CLASS,mxREAL);
                WindowsVectorDescriptorsMatrix = mxGetPr(plhs[1]);
                
                dims3[0] = numberOfWindowsVertically;
                dims3[1] = numberOfWindowsHorizontally;
                dims3[2] = descriptorLengthPerWindow;
                plhs[2] = mxCreateNumericArray(3,dims3,mxDOUBLE_CLASS,mxREAL);
                WindowsMatrixDescriptorsVector = mxGetPr(plhs[2]);
                
                dims2[0] = numberOfWindows;
                dims2[1] = descriptorLengthPerWindow;
                plhs[3] = mxCreateNumericArray(2,dims2,mxDOUBLE_CLASS,mxREAL);
                WindowsVectorDescriptorsVector = mxGetPr(plhs[3]);
            }
        }
    }
    else if (outputWindowsCenters==1)
    {
        if (outputWindowsFormat==0)
        {
            if (outputDescriptorsFormat==0)
            {   // Matrix-Matrix
                dims5[0] = numberOfWindowsVertically;
                dims5[1] = numberOfWindowsHorizontally;
                dims5[2] = numberOfBlocksPerWindowVertically;
                dims5[3] = numberOfBlocksPerWindowHorizontally;
                dims5[4] = descriptorLengthPerBlock;
                plhs[0] = mxCreateNumericArray(5,dims5,mxDOUBLE_CLASS,mxREAL);
                WindowsMatrixDescriptorsMatrix = mxGetPr(plhs[0]);
                
                dims3[0] = numberOfWindowsVertically;
                dims3[1] = numberOfWindowsHorizontally;
                dims3[2] = 2;
                plhs[1] = mxCreateNumericArray(3,dims3,mxDOUBLE_CLASS,mxREAL);
                WindowsCentersMatrix = mxGetPr(plhs[1]);
            }
            else if (outputDescriptorsFormat==1)
            {   // Matrix-Vector
                dims3[0] = numberOfWindowsVertically;
                dims3[1] = numberOfWindowsHorizontally;
                dims3[2] = descriptorLengthPerWindow;
                plhs[0] = mxCreateNumericArray(3,dims3,mxDOUBLE_CLASS,mxREAL);
                WindowsMatrixDescriptorsVector = mxGetPr(plhs[0]);
                
                dims3[0] = numberOfWindowsVertically;
                dims3[1] = numberOfWindowsHorizontally;
                dims3[2] = 2;
                plhs[1] = mxCreateNumericArray(3,dims3,mxDOUBLE_CLASS,mxREAL);
                WindowsCentersMatrix = mxGetPr(plhs[1]);
            }
            else if (outputDescriptorsFormat==2)
            {   // Matrix-Matrix and Matrix-Vector
                dims5[0] = numberOfWindowsVertically;
                dims5[1] = numberOfWindowsHorizontally;
                dims5[2] = numberOfBlocksPerWindowVertically;
                dims5[3] = numberOfBlocksPerWindowHorizontally;
                dims5[4] = descriptorLengthPerBlock;
                plhs[0] = mxCreateNumericArray(5,dims5,mxDOUBLE_CLASS,mxREAL);
                WindowsMatrixDescriptorsMatrix = mxGetPr(plhs[0]);
                
                dims3[0] = numberOfWindowsVertically;
                dims3[1] = numberOfWindowsHorizontally;
                dims3[2] = descriptorLengthPerWindow;
                plhs[1] = mxCreateNumericArray(3,dims3,mxDOUBLE_CLASS,mxREAL);
                WindowsMatrixDescriptorsVector = mxGetPr(plhs[1]);
                
                dims3[0] = numberOfWindowsVertically;
                dims3[1] = numberOfWindowsHorizontally;
                dims3[2] = 2;
                plhs[2] = mxCreateNumericArray(3,dims3,mxDOUBLE_CLASS,mxREAL);
                WindowsCentersMatrix = mxGetPr(plhs[2]);
            }
        }
        else if (outputWindowsFormat==1)
        {
            if (outputDescriptorsFormat==0)
            {   // Vector-Matrix
                dims4[0] = numberOfWindows;
                dims4[1] = numberOfBlocksPerWindowVertically;
                dims4[2] = numberOfBlocksPerWindowHorizontally;
                dims4[3] = descriptorLengthPerBlock;
                plhs[0] = mxCreateNumericArray(4,dims4,mxDOUBLE_CLASS,mxREAL);
                WindowsVectorDescriptorsMatrix = mxGetPr(plhs[0]);
                
                dims2[0] = numberOfWindows;
                dims2[1] = 2;
                plhs[1] = mxCreateNumericArray(2,dims2,mxDOUBLE_CLASS,mxREAL);
                WindowsCentersVector = mxGetPr(plhs[1]);
            }
            else if (outputDescriptorsFormat==1)
            {   // Vector-Vector
                dims2[0] = numberOfWindows;
                dims2[1] = descriptorLengthPerWindow;
                plhs[0] = mxCreateNumericArray(2,dims2,mxDOUBLE_CLASS,mxREAL);
                WindowsVectorDescriptorsVector = mxGetPr(plhs[0]);
                
                dims2[0] = numberOfWindows;
                dims2[1] = 2;
                plhs[1] = mxCreateNumericArray(2,dims2,mxDOUBLE_CLASS,mxREAL);
                WindowsCentersVector = mxGetPr(plhs[1]);
            }
            else if (outputDescriptorsFormat==2)
            {   // Vector-Matrix and Vector-Vector
                dims4[0] = numberOfWindows;
                dims4[1] = numberOfBlocksPerWindowVertically;
                dims4[2] = numberOfBlocksPerWindowHorizontally;
                dims4[3] = descriptorLengthPerBlock;
                plhs[0] = mxCreateNumericArray(4,dims4,mxDOUBLE_CLASS,mxREAL);
                WindowsVectorDescriptorsMatrix = mxGetPr(plhs[0]);
                
                dims2[0] = numberOfWindows;
                dims2[1] = descriptorLengthPerWindow;
                plhs[1] = mxCreateNumericArray(2,dims2,mxDOUBLE_CLASS,mxREAL);
                WindowsVectorDescriptorsVector = mxGetPr(plhs[1]);
                
                dims2[0] = numberOfWindows;
                dims2[1] = 2;
                plhs[2] = mxCreateNumericArray(2,dims2,mxDOUBLE_CLASS,mxREAL);
                WindowsCentersVector = mxGetPr(plhs[2]);
            }
        }
        else if (outputWindowsFormat==2)
        {
            if (outputDescriptorsFormat==0)
            {   // Matrix-Matrix and Vector-Matrix
                dims5[0] = numberOfWindowsVertically;
                dims5[1] = numberOfWindowsHorizontally;
                dims5[2] = numberOfBlocksPerWindowVertically;
                dims5[3] = numberOfBlocksPerWindowHorizontally;
                dims5[4] = descriptorLengthPerBlock;
                plhs[0] = mxCreateNumericArray(5,dims5,mxDOUBLE_CLASS,mxREAL);
                WindowsMatrixDescriptorsMatrix = mxGetPr(plhs[0]);
                
                dims4[0] = numberOfWindows;
                dims4[1] = numberOfBlocksPerWindowVertically;
                dims4[2] = numberOfBlocksPerWindowHorizontally;
                dims4[3] = descriptorLengthPerBlock;
                plhs[1] = mxCreateNumericArray(4,dims4,mxDOUBLE_CLASS,mxREAL);
                WindowsVectorDescriptorsMatrix = mxGetPr(plhs[1]);
                
                dims3[0] = numberOfWindowsVertically;
                dims3[1] = numberOfWindowsHorizontally;
                dims3[2] = 2;
                plhs[2] = mxCreateNumericArray(3,dims3,mxDOUBLE_CLASS,mxREAL);
                WindowsCentersMatrix = mxGetPr(plhs[2]);
                
                dims2[0] = numberOfWindows;
                dims2[1] = 2;
                plhs[3] = mxCreateNumericArray(2,dims2,mxDOUBLE_CLASS,mxREAL);
                WindowsCentersVector = mxGetPr(plhs[3]);
            }
            else if (outputDescriptorsFormat==1)
            {   // Matrix-Vector and Vector-Vector
                dims3[0] = numberOfWindowsVertically;
                dims3[1] = numberOfWindowsHorizontally;
                dims3[2] = descriptorLengthPerWindow;
                plhs[0] = mxCreateNumericArray(3,dims3,mxDOUBLE_CLASS,mxREAL);
                WindowsMatrixDescriptorsVector = mxGetPr(plhs[0]);
                
                dims2[0] = numberOfWindows;
                dims2[1] = descriptorLengthPerWindow;
                plhs[1] = mxCreateNumericArray(2,dims2,mxDOUBLE_CLASS,mxREAL);
                WindowsVectorDescriptorsVector = mxGetPr(plhs[1]);
                
                dims3[0] = numberOfWindowsVertically;
                dims3[1] = numberOfWindowsHorizontally;
                dims3[2] = 2;
                plhs[2] = mxCreateNumericArray(3,dims3,mxDOUBLE_CLASS,mxREAL);
                WindowsCentersMatrix = mxGetPr(plhs[2]);
                
                dims2[0] = numberOfWindows;
                dims2[1] = 2;
                plhs[3] = mxCreateNumericArray(2,dims2,mxDOUBLE_CLASS,mxREAL);
                WindowsCentersVector = mxGetPr(plhs[3]);
            }
            else if (outputDescriptorsFormat==2)
            {   // Matrix-Matrix and Vector-Matrix and Matrix-Vector and Vector-Vector
                dims5[0] = numberOfWindowsVertically;
                dims5[1] = numberOfWindowsHorizontally;
                dims5[2] = numberOfBlocksPerWindowVertically;
                dims5[3] = numberOfBlocksPerWindowHorizontally;
                dims5[4] = descriptorLengthPerBlock;
                plhs[0] = mxCreateNumericArray(5,dims5,mxDOUBLE_CLASS,mxREAL);
                WindowsMatrixDescriptorsMatrix = mxGetPr(plhs[0]);
                
                dims4[0] = numberOfWindows;
                dims4[1] = numberOfBlocksPerWindowVertically;
                dims4[2] = numberOfBlocksPerWindowHorizontally;
                dims4[3] = descriptorLengthPerBlock;
                plhs[1] = mxCreateNumericArray(4,dims4,mxDOUBLE_CLASS,mxREAL);
                WindowsVectorDescriptorsMatrix = mxGetPr(plhs[1]);
                
                dims3[0] = numberOfWindowsVertically;
                dims3[1] = numberOfWindowsHorizontally;
                dims3[2] = descriptorLengthPerWindow;
                plhs[2] = mxCreateNumericArray(3,dims3,mxDOUBLE_CLASS,mxREAL);
                WindowsMatrixDescriptorsVector = mxGetPr(plhs[2]);
                
                dims2[0] = numberOfWindows;
                dims2[1] = descriptorLengthPerWindow;
                plhs[3] = mxCreateNumericArray(2,dims2,mxDOUBLE_CLASS,mxREAL);
                WindowsVectorDescriptorsVector = mxGetPr(plhs[3]);
                
                dims3[0] = numberOfWindowsVertically;
                dims3[1] = numberOfWindowsHorizontally;
                dims3[2] = 2;
                plhs[4] = mxCreateNumericArray(3,dims3,mxDOUBLE_CLASS,mxREAL);
                WindowsCentersMatrix = mxGetPr(plhs[4]);
                
                dims2[0] = numberOfWindows;
                dims2[1] = 2;
                plhs[5] = mxCreateNumericArray(2,dims2,mxDOUBLE_CLASS,mxREAL);
                WindowsCentersVector = mxGetPr(plhs[5]);
            }
        }
    }
    
    // Processing
    if (method==1)
    {
        params = new double[5];
        params[0] = options[7];
        params[1] = options[8];
        params[2] = options[9];
        params[3] = options[10];
        params[4] = options[11];
        windowCounter = -1;
        for (windowIndexVertical=0; windowIndexVertical<numberOfWindowsVertically; windowIndexVertical++)
        {
            for (windowIndexHorizontal=0; windowIndexHorizontal<numberOfWindowsHorizontally; windowIndexHorizontal++)
            {
                // Update window counter
                windowCounter = windowCounter + 1;
                
                // Find window edges coordinates
                //if (windowHeight==imageHeight && windowWidth==imageWidth)
                //{
                //    windowIndexVertical = windowIndexVertical + 1;
                //    windowIndexHorizontal = windowIndexHorizontal + 1;
                //    windowStepVertical = floor(imageHeight/2);
                //    windowStepHorizontal = floor(imageWidth/2);
                //}
                //rowCenter = windowIndexVertical*windowStepVertical;
                //rowFrom = rowCenter - (int)floor(windowHeight/2);
                //rowTo = rowCenter + (int)ceil(windowHeight/2) - 1;
                
                //columnCenter = windowIndexHorizontal*windowStepHorizontal;
                //columnFrom = columnCenter - (int)floor(windowWidth/2);
                //columnTo = columnCenter + (int)ceil(windowWidth/2) - 1;
                ////rowFrom = windowIndexVertical*windowStepVertical;
                ////rowTo = windowIndexVertical*windowStepVertical + windowHeight - 1;
                ////columnFrom = windowIndexHorizontal*windowStepHorizontal;
                ////columnTo = windowIndexHorizontal*windowStepHorizontal + windowWidth - 1;
                
                if (returnOnlyWindowsWithinImageLimits==1)
                {
                    rowFrom = windowIndexVertical*windowStepVertical;
                    rowTo = rowFrom + windowHeight - 1;
                    rowCenter = rowFrom + (int)round((double)windowHeight/2) - 1;
                    columnFrom = windowIndexHorizontal*windowStepHorizontal;
                    columnTo = columnFrom + windowWidth - 1;
                    columnCenter = columnFrom + (int)round((double)windowWidth/2) - 1;
                }
                else
                {
                    rowCenter = windowIndexVertical*windowStepVertical;
                    rowFrom = rowCenter - (int)round((double)windowHeight/2) + 1;
                    rowTo = rowFrom + windowHeight - 1;
                    columnCenter = windowIndexHorizontal*windowStepHorizontal;
                    columnFrom = columnCenter - (int)ceil((double)windowWidth/2) + 1;
                    columnTo = columnFrom + windowWidth - 1;
                }
                
                //mexPrintf("Rows(%d)=[%d | %d | %d]   Columns(%d)=[%d | %d | %d]\n",windowIndexVertical,rowFrom,rowCenter,rowTo,windowIndexHorizontal,columnFrom,columnCenter,columnTo);

                // Create window image
                if (inputImageIsGrayscale==1)
                {
                    for (i=rowFrom; i<=rowTo; i++)
                    {
                        for (j=columnFrom; j<=columnTo; j++)
                        {
                            if (i<0 || i>imageHeight-1 || j<0 || j>imageWidth-1)
                                windowImage[(i-rowFrom)+windowHeight*(j-columnFrom)] = 0;
                            else
                                windowImage[(i-rowFrom)+windowHeight*(j-columnFrom)] = inputImage[i+imageHeight*j];
                        }
                    }
                }
                else
                {
                    for (i=rowFrom; i<=rowTo; i++)
                    {
                        for (j=columnFrom; j<=columnTo; j++)
                        {
                            if (i<0 || i>imageHeight-1 || j<0 || j>imageWidth-1)
                            {
                                for (k=0; k<3; k++)
                                    windowImage[(i-rowFrom)+windowHeight*((j-columnFrom)+windowWidth*k)] = 0;
                            }
                            else
                            {
                                for (k=0; k<3; k++)
                                    windowImage[(i-rowFrom)+windowHeight*((j-columnFrom)+windowWidth*k)] = inputImage[i+imageHeight*(j+imageWidth*k)];
                            }
                        }
                    }
                }
                
                // Compute descriptor of window
                DalalTriggsHOGdescriptor(windowImage,params,windowSize,descriptorVector,inputImageIsGrayscale);
                d=0;
                for (d2=0; d2<numberOfBlocksPerWindowHorizontally; d2++) {
                    for (d1=0; d1<numberOfBlocksPerWindowVertically; d1++) {
                        for (d3=0; d3<descriptorLengthPerBlock; d3++) {
                            descriptorMatrix[d1+numberOfBlocksPerWindowVertically*(d2+numberOfBlocksPerWindowHorizontally*d3)] = descriptorVector[d];
                            d = d + 1; }}}
                
                // Store results
                if (outputWindowsCenters==0)
                {
                    if (outputWindowsFormat==0)
                    {
                        if (outputDescriptorsFormat==0)
                        {   // Matrix-Matrix
                            for (d2=0; d2<numberOfBlocksPerWindowHorizontally; d2++)
                                for (d1=0; d1<numberOfBlocksPerWindowVertically; d1++)
                                    for (d3=0; d3<descriptorLengthPerBlock; d3++)
                                        WindowsMatrixDescriptorsMatrix[windowIndexVertical+numberOfWindowsVertically*(windowIndexHorizontal+numberOfWindowsHorizontally*(d1+numberOfBlocksPerWindowVertically*(d2+numberOfBlocksPerWindowHorizontally*d3)))] = descriptorMatrix[d1+numberOfBlocksPerWindowVertically*(d2+numberOfBlocksPerWindowHorizontally*d3)];
                        }
                        else if (outputDescriptorsFormat==1)
                        {   // Matrix-Vector
                            d = 0;
                            for (d2=0; d2<numberOfBlocksPerWindowHorizontally; d2++) {
                                for (d1=0; d1<numberOfBlocksPerWindowVertically; d1++) {
                                    for (d3=0; d3<descriptorLengthPerBlock; d3++) {
                                        WindowsMatrixDescriptorsVector[windowIndexVertical+numberOfWindowsVertically*(windowIndexHorizontal+numberOfWindowsHorizontally*d)] = descriptorMatrix[d1+numberOfBlocksPerWindowVertically*(d2+numberOfBlocksPerWindowHorizontally*d3)];
                                        d=d+1; }}}
                        }
                        else if (outputDescriptorsFormat==2)
                        {   // Matrix-Matrix and Matrix-Vector
                            d = 0;
                            for (d2=0; d2<numberOfBlocksPerWindowHorizontally; d2++) {
                                for (d1=0; d1<numberOfBlocksPerWindowVertically; d1++) {
                                    for (d3=0; d3<descriptorLengthPerBlock; d3++) {
                                        WindowsMatrixDescriptorsMatrix[windowIndexVertical+numberOfWindowsVertically*(windowIndexHorizontal+numberOfWindowsHorizontally*(d1+numberOfBlocksPerWindowVertically*(d2+numberOfBlocksPerWindowHorizontally*d3)))] = descriptorMatrix[d1+numberOfBlocksPerWindowVertically*(d2+numberOfBlocksPerWindowHorizontally*d3)];
                                        WindowsMatrixDescriptorsVector[windowIndexVertical+numberOfWindowsVertically*(windowIndexHorizontal+numberOfWindowsHorizontally*d)] = descriptorMatrix[d1+numberOfBlocksPerWindowVertically*(d2+numberOfBlocksPerWindowHorizontally*d3)];
                                        d=d+1; }}}
                        }
                    }
                    else if (outputWindowsFormat==1)
                    {
                        if (outputDescriptorsFormat==0)
                        {   // Vector-Matrix
                            for (d2=0; d2<numberOfBlocksPerWindowHorizontally; d2++)
                                for (d1=0; d1<numberOfBlocksPerWindowVertically; d1++)
                                    for (d3=0; d3<descriptorLengthPerBlock; d3++)
                                        WindowsVectorDescriptorsMatrix[windowCounter+numberOfWindows*(d1+numberOfBlocksPerWindowVertically*(d2+numberOfBlocksPerWindowHorizontally*d3))] = descriptorMatrix[d1+numberOfBlocksPerWindowVertically*(d2+numberOfBlocksPerWindowHorizontally*d3)];
                        }
                        else if (outputDescriptorsFormat==1)
                        {   // Vector-Vector
                            d = 0;
                            for (d2=0; d2<numberOfBlocksPerWindowHorizontally; d2++) {
                                for (d1=0; d1<numberOfBlocksPerWindowVertically; d1++) {
                                    for (d3=0; d3<descriptorLengthPerBlock; d3++) {
                                        WindowsVectorDescriptorsVector[windowCounter+numberOfWindows*d] = descriptorMatrix[d1+numberOfBlocksPerWindowVertically*(d2+numberOfBlocksPerWindowHorizontally*d3)];
                                        d=d+1; }}}
                        }
                        else if (outputDescriptorsFormat==2)
                        {   // Vector-Matrix and Vector-Vector
                            d = 0;
                            for (d2=0; d2<numberOfBlocksPerWindowHorizontally; d2++) {
                                for (d1=0; d1<numberOfBlocksPerWindowVertically; d1++) {
                                    for (d3=0; d3<descriptorLengthPerBlock; d3++) {
                                        WindowsVectorDescriptorsMatrix[windowCounter+numberOfWindows*(d1+numberOfBlocksPerWindowVertically*(d2+numberOfBlocksPerWindowHorizontally*d3))] = descriptorMatrix[d1+numberOfBlocksPerWindowVertically*(d2+numberOfBlocksPerWindowHorizontally*d3)];
                                        WindowsVectorDescriptorsVector[windowCounter+numberOfWindows*d] = descriptorMatrix[d1+numberOfBlocksPerWindowVertically*(d2+numberOfBlocksPerWindowHorizontally*d3)];
                                        d=d+1; }}}
                        }
                    }
                    else if (outputWindowsFormat==2)
                    {
                        if (outputDescriptorsFormat==0)
                        {   // Matrix-Matrix and Vector-Matrix
                            for (d2=0; d2<numberOfBlocksPerWindowHorizontally; d2++) {
                                for (d1=0; d1<numberOfBlocksPerWindowVertically; d1++) {
                                    for (d3=0; d3<descriptorLengthPerBlock; d3++) {
                                        WindowsMatrixDescriptorsMatrix[windowIndexVertical+numberOfWindowsVertically*(windowIndexHorizontal+numberOfWindowsHorizontally*(d1+numberOfBlocksPerWindowVertically*(d2+numberOfBlocksPerWindowHorizontally*d3)))] = descriptorMatrix[d1+numberOfBlocksPerWindowVertically*(d2+numberOfBlocksPerWindowHorizontally*d3)];
                                        WindowsVectorDescriptorsMatrix[windowCounter+numberOfWindows*(d1+numberOfBlocksPerWindowVertically*(d2+numberOfBlocksPerWindowHorizontally*d3))] = descriptorMatrix[d1+numberOfBlocksPerWindowVertically*(d2+numberOfBlocksPerWindowHorizontally*d3)]; } } }
                        }
                        else if (outputDescriptorsFormat==1)
                        {   // Matrix-Vector and Vector-Vector
                            d = 0;
                            for (d2=0; d2<numberOfBlocksPerWindowHorizontally; d2++) {
                                for (d1=0; d1<numberOfBlocksPerWindowVertically; d1++) {
                                    for (d3=0; d3<descriptorLengthPerBlock; d3++) {
                                        WindowsMatrixDescriptorsVector[windowIndexVertical+numberOfWindowsVertically*(windowIndexHorizontal+numberOfWindowsHorizontally*d)] = descriptorMatrix[d1+numberOfBlocksPerWindowVertically*(d2+numberOfBlocksPerWindowHorizontally*d3)];
                                        WindowsVectorDescriptorsVector[windowCounter+numberOfWindows*d] = descriptorMatrix[d1+numberOfBlocksPerWindowVertically*(d2+numberOfBlocksPerWindowHorizontally*d3)];
                                        d=d+1; }}}
                        }
                        else if (outputDescriptorsFormat==2)
                        {   // Matrix-Matrix and Vector-Matrix and Matrix-Vector and Vector-Vector
                            d = 0;
                            for (d2=0; d2<numberOfBlocksPerWindowHorizontally; d2++) {
                                for (d1=0; d1<numberOfBlocksPerWindowVertically; d1++) {
                                    for (d3=0; d3<descriptorLengthPerBlock; d3++) {
                                        WindowsMatrixDescriptorsMatrix[windowIndexVertical+numberOfWindowsVertically*(windowIndexHorizontal+numberOfWindowsHorizontally*(d1+numberOfBlocksPerWindowVertically*(d2+numberOfBlocksPerWindowHorizontally*d3)))] = descriptorMatrix[d1+numberOfBlocksPerWindowVertically*(d2+numberOfBlocksPerWindowHorizontally*d3)];
                                        WindowsVectorDescriptorsMatrix[windowCounter+numberOfWindows*(d1+numberOfBlocksPerWindowVertically*(d2+numberOfBlocksPerWindowHorizontally*d3))] = descriptorMatrix[d1+numberOfBlocksPerWindowVertically*(d2+numberOfBlocksPerWindowHorizontally*d3)];
                                        WindowsMatrixDescriptorsVector[windowIndexVertical+numberOfWindowsVertically*(windowIndexHorizontal+numberOfWindowsHorizontally*d)] = descriptorMatrix[d1+numberOfBlocksPerWindowVertically*(d2+numberOfBlocksPerWindowHorizontally*d3)];
                                        WindowsVectorDescriptorsVector[windowCounter+numberOfWindows*d] = descriptorMatrix[d1+numberOfBlocksPerWindowVertically*(d2+numberOfBlocksPerWindowHorizontally*d3)];
                                        d=d+1; }}}
                        }
                    }
                }
                else if (outputWindowsCenters==1)
                {
                    if (outputWindowsFormat==0)
                    {
                        if (outputDescriptorsFormat==0)
                        {   // Matrix-Matrix
                            for (d2=0; d2<numberOfBlocksPerWindowHorizontally; d2++)
                                for (d1=0; d1<numberOfBlocksPerWindowVertically; d1++)
                                    for (d3=0; d3<descriptorLengthPerBlock; d3++)
                                        WindowsMatrixDescriptorsMatrix[windowIndexVertical+numberOfWindowsVertically*(windowIndexHorizontal+numberOfWindowsHorizontally*(d1+numberOfBlocksPerWindowVertically*(d2+numberOfBlocksPerWindowHorizontally*d3)))] = descriptorMatrix[d1+numberOfBlocksPerWindowVertically*(d2+numberOfBlocksPerWindowHorizontally*d3)];
                        }
                        else if (outputDescriptorsFormat==1)
                        {   // Matrix-Vector
                            d = 0;
                            for (d2=0; d2<numberOfBlocksPerWindowHorizontally; d2++) {
                                for (d1=0; d1<numberOfBlocksPerWindowVertically; d1++) {
                                    for (d3=0; d3<descriptorLengthPerBlock; d3++) {
                                        WindowsMatrixDescriptorsVector[windowIndexVertical+numberOfWindowsVertically*(windowIndexHorizontal+numberOfWindowsHorizontally*d)] = descriptorMatrix[d1+numberOfBlocksPerWindowVertically*(d2+numberOfBlocksPerWindowHorizontally*d3)];
                                        d=d+1; }}}
                        }
                        else if (outputDescriptorsFormat==2)
                        {   // Matrix-Matrix and Matrix-Vector
                            d = 0;
                            for (d2=0; d2<numberOfBlocksPerWindowHorizontally; d2++) {
                                for (d1=0; d1<numberOfBlocksPerWindowVertically; d1++) {
                                    for (d3=0; d3<descriptorLengthPerBlock; d3++) {
                                        WindowsMatrixDescriptorsMatrix[windowIndexVertical+numberOfWindowsVertically*(windowIndexHorizontal+numberOfWindowsHorizontally*(d1+numberOfBlocksPerWindowVertically*(d2+numberOfBlocksPerWindowHorizontally*d3)))] = descriptorMatrix[d1+numberOfBlocksPerWindowVertically*(d2+numberOfBlocksPerWindowHorizontally*d3)];
                                        WindowsMatrixDescriptorsVector[windowIndexVertical+numberOfWindowsVertically*(windowIndexHorizontal+numberOfWindowsHorizontally*d)] = descriptorMatrix[d1+numberOfBlocksPerWindowVertically*(d2+numberOfBlocksPerWindowHorizontally*d3)];
                                        d=d+1; }}}
                        }
                        WindowsCentersMatrix[windowIndexVertical+numberOfWindowsVertically*windowIndexHorizontal] = rowCenter + 1;
                        WindowsCentersMatrix[windowIndexVertical+numberOfWindowsVertically*(windowIndexHorizontal+numberOfWindowsHorizontally)] = columnCenter + 1;
                    }
                    else if (outputWindowsFormat==1)
                    {
                        if (outputDescriptorsFormat==0)
                        {   // Vector-Matrix
                            for (d2=0; d2<numberOfBlocksPerWindowHorizontally; d2++)
                                for (d1=0; d1<numberOfBlocksPerWindowVertically; d1++)
                                    for (d3=0; d3<descriptorLengthPerBlock; d3++)
                                        WindowsVectorDescriptorsMatrix[windowCounter+numberOfWindows*(d1+numberOfBlocksPerWindowVertically*(d2+numberOfBlocksPerWindowHorizontally*d3))] = descriptorMatrix[d1+numberOfBlocksPerWindowVertically*(d2+numberOfBlocksPerWindowHorizontally*d3)];
                        }
                        else if (outputDescriptorsFormat==1)
                        {   // Vector-Vector
                            d = 0;
                            for (d2=0; d2<numberOfBlocksPerWindowHorizontally; d2++) {
                                for (d1=0; d1<numberOfBlocksPerWindowVertically; d1++) {
                                    for (d3=0; d3<descriptorLengthPerBlock; d3++) {
                                        WindowsVectorDescriptorsVector[windowCounter+numberOfWindows*d] = descriptorMatrix[d1+numberOfBlocksPerWindowVertically*(d2+numberOfBlocksPerWindowHorizontally*d3)];
                                        d=d+1; }}}
                        }
                        else if (outputDescriptorsFormat==2)
                        {   // Vector-Matrix and Vector-Vector
                            d = 0;
                            for (d2=0; d2<numberOfBlocksPerWindowHorizontally; d2++) {
                                for (d1=0; d1<numberOfBlocksPerWindowVertically; d1++) {
                                    for (d3=0; d3<descriptorLengthPerBlock; d3++) {
                                        WindowsVectorDescriptorsMatrix[windowCounter+numberOfWindows*(d1+numberOfBlocksPerWindowVertically*(d2+numberOfBlocksPerWindowHorizontally*d3))] = descriptorMatrix[d1+numberOfBlocksPerWindowVertically*(d2+numberOfBlocksPerWindowHorizontally*d3)];
                                        WindowsVectorDescriptorsVector[windowCounter+numberOfWindows*d] = descriptorMatrix[d1+numberOfBlocksPerWindowVertically*(d2+numberOfBlocksPerWindowHorizontally*d3)];
                                        d=d+1; }}}
                        }
                        WindowsCentersVector[windowCounter] = rowCenter + 1;
                        WindowsCentersVector[windowCounter+numberOfWindows] = columnCenter + 1;
                    }
                    else if (outputWindowsFormat==2)
                    {
                        if (outputDescriptorsFormat==0)
                        {   // Matrix-Matrix and Vector-Matrix
                            for (d2=0; d2<numberOfBlocksPerWindowHorizontally; d2++) {
                                for (d1=0; d1<numberOfBlocksPerWindowVertically; d1++) {
                                    for (d3=0; d3<descriptorLengthPerBlock; d3++) {
                                        WindowsMatrixDescriptorsMatrix[windowIndexVertical+numberOfWindowsVertically*(windowIndexHorizontal+numberOfWindowsHorizontally*(d1+numberOfBlocksPerWindowVertically*(d2+numberOfBlocksPerWindowHorizontally*d3)))] = descriptorMatrix[d1+numberOfBlocksPerWindowVertically*(d2+numberOfBlocksPerWindowHorizontally*d3)];
                                        WindowsVectorDescriptorsMatrix[windowCounter+numberOfWindows*(d1+numberOfBlocksPerWindowVertically*(d2+numberOfBlocksPerWindowHorizontally*d3))] = descriptorMatrix[d1+numberOfBlocksPerWindowVertically*(d2+numberOfBlocksPerWindowHorizontally*d3)]; } } }
                        }
                        else if (outputDescriptorsFormat==1)
                        {   // Matrix-Vector and Vector-Vector
                            d = 0;
                            for (d2=0; d2<numberOfBlocksPerWindowHorizontally; d2++) {
                                for (d1=0; d1<numberOfBlocksPerWindowVertically; d1++) {
                                    for (d3=0; d3<descriptorLengthPerBlock; d3++) {
                                        WindowsMatrixDescriptorsVector[windowIndexVertical+numberOfWindowsVertically*(windowIndexHorizontal+numberOfWindowsHorizontally*d)] = descriptorMatrix[d1+numberOfBlocksPerWindowVertically*(d2+numberOfBlocksPerWindowHorizontally*d3)];
                                        WindowsVectorDescriptorsVector[windowCounter+numberOfWindows*d] = descriptorMatrix[d1+numberOfBlocksPerWindowVertically*(d2+numberOfBlocksPerWindowHorizontally*d3)];
                                        d=d+1; }}}
                        }
                        else if (outputDescriptorsFormat==2)
                        {   // Matrix-Matrix and Vector-Matrix and Matrix-Vector and Vector-Vector
                            d = 0;
                            for (d2=0; d2<numberOfBlocksPerWindowHorizontally; d2++) {
                                for (d1=0; d1<numberOfBlocksPerWindowVertically; d1++) {
                                    for (d3=0; d3<descriptorLengthPerBlock; d3++) {
                                        WindowsMatrixDescriptorsMatrix[windowIndexVertical+numberOfWindowsVertically*(windowIndexHorizontal+numberOfWindowsHorizontally*(d1+numberOfBlocksPerWindowVertically*(d2+numberOfBlocksPerWindowHorizontally*d3)))] = descriptorMatrix[d1+numberOfBlocksPerWindowVertically*(d2+numberOfBlocksPerWindowHorizontally*d3)];
                                        WindowsVectorDescriptorsMatrix[windowCounter+numberOfWindows*(d1+numberOfBlocksPerWindowVertically*(d2+numberOfBlocksPerWindowHorizontally*d3))] = descriptorMatrix[d1+numberOfBlocksPerWindowVertically*(d2+numberOfBlocksPerWindowHorizontally*d3)];
                                        WindowsMatrixDescriptorsVector[windowIndexVertical+numberOfWindowsVertically*(windowIndexHorizontal+numberOfWindowsHorizontally*d)] = descriptorMatrix[d1+numberOfBlocksPerWindowVertically*(d2+numberOfBlocksPerWindowHorizontally*d3)];
                                        WindowsVectorDescriptorsVector[windowCounter+numberOfWindows*d] = descriptorMatrix[d1+numberOfBlocksPerWindowVertically*(d2+numberOfBlocksPerWindowHorizontally*d3)];
                                        d=d+1; }}}
                        }
                        WindowsCentersMatrix[windowIndexVertical+numberOfWindowsVertically*windowIndexHorizontal] = rowCenter + 1;
                        WindowsCentersMatrix[windowIndexVertical+numberOfWindowsVertically*(windowIndexHorizontal+numberOfWindowsHorizontally)] = columnCenter + 1;
                        WindowsCentersVector[windowCounter] = rowCenter + 1;
                        WindowsCentersVector[windowCounter+numberOfWindows] = columnCenter + 1;
                    }
                }
            }
        }
    }
    else if (method==2)
    {
        windowCounter = -1;
        for (windowIndexVertical=0; windowIndexVertical<numberOfWindowsVertically; windowIndexVertical++)
        {
            for (windowIndexHorizontal=0; windowIndexHorizontal<numberOfWindowsHorizontally; windowIndexHorizontal++)
            {
                // Update window counter
                windowCounter = windowCounter + 1;
                
                // Find window edges coordinates
                //if (windowHeight==imageHeight && windowWidth==imageWidth)
                //{
                //    windowIndexVertical = windowIndexVertical + 1;
                //    windowIndexHorizontal = windowIndexHorizontal + 1;
                //    windowStepVertical = floor(imageHeight/2);
                //    windowStepHorizontal = floor(imageWidth/2);
                //}
                //rowCenter = windowIndexVertical*windowStepVertical;
                //rowFrom = rowCenter - (int)floor(windowHeight/2);
                //rowTo = rowCenter + (int)ceil(windowHeight/2) - 1;
                
                //columnCenter = windowIndexHorizontal*windowStepHorizontal;
                //columnFrom = columnCenter - (int)floor(windowWidth/2);
                //columnTo = columnCenter + (int)ceil(windowWidth/2) - 1;
                ////rowFrom = windowIndexVertical*windowStepVertical;
                ////rowTo = windowIndexVertical*windowStepVertical + windowHeight - 1;
                ////columnFrom = windowIndexHorizontal*windowStepHorizontal;
                ////columnTo = windowIndexHorizontal*windowStepHorizontal + windowWidth - 1;
                
                if (returnOnlyWindowsWithinImageLimits==1)
                {
                    rowFrom = windowIndexVertical*windowStepVertical;
                    rowTo = rowFrom + windowHeight - 1;
                    rowCenter = rowFrom + (int)round((double)windowHeight/2) - 1;
                    columnFrom = windowIndexHorizontal*windowStepHorizontal;
                    columnTo = columnFrom + windowWidth - 1;
                    columnCenter = columnFrom + (int)round((double)windowWidth/2) - 1;
                }
                else
                {
                    rowCenter = windowIndexVertical*windowStepVertical;
                    rowFrom = rowCenter - (int)round((double)windowHeight/2) + 1;
                    rowTo = rowFrom + windowHeight - 1;
                    columnCenter = windowIndexHorizontal*windowStepHorizontal;
                    columnFrom = columnCenter - (int)ceil((double)windowWidth/2) + 1;
                    columnTo = columnFrom + windowWidth - 1;
                }

                // Create window image
                if (inputImageIsGrayscale==1)
                {
                    for (i=rowFrom; i<=rowTo; i++)
                    {
                        for (j=columnFrom; j<=columnTo; j++)
                        {
                            if (i<0 || i>imageHeight-1 || j<0 || j>imageWidth-1)
                                windowImage[(i-rowFrom)+windowHeight*(j-columnFrom)] = 0;
                            else
                                windowImage[(i-rowFrom)+windowHeight*(j-columnFrom)] = inputImage[i+imageHeight*j];
                        }
                    }
                }
                else
                {
                    for (i=rowFrom; i<=rowTo; i++)
                    {
                        for (j=columnFrom; j<=columnTo; j++)
                        {
                            if (i<0 || i>imageHeight-1 || j<0 || j>imageWidth-1)
                            {
                                for (k=0; k<3; k++)
                                    windowImage[(i-rowFrom)+windowHeight*((j-columnFrom)+windowWidth*k)] = 0;
                            }
                            else
                            {
                                for (k=0; k<3; k++)
                                    windowImage[(i-rowFrom)+windowHeight*((j-columnFrom)+windowWidth*k)] = inputImage[i+imageHeight*(j+imageWidth*k)];
                            }
                        }
                    }
                }
                
                // Compute descriptor of window
                ZhuRamananHOGdescriptor(windowImage,sbin,windowSize,descriptorMatrix);
                
                // Store results
                if (outputWindowsCenters==0)
                {
                    if (outputWindowsFormat==0)
                    {
                        if (outputDescriptorsFormat==0)
                        {   // Matrix-Matrix
                            for (d2=0; d2<numberOfBlocksPerWindowHorizontally; d2++)
                                for (d1=0; d1<numberOfBlocksPerWindowVertically; d1++)
                                    for (d3=0; d3<descriptorLengthPerBlock; d3++)
                                        WindowsMatrixDescriptorsMatrix[windowIndexVertical+numberOfWindowsVertically*(windowIndexHorizontal+numberOfWindowsHorizontally*(d1+numberOfBlocksPerWindowVertically*(d2+numberOfBlocksPerWindowHorizontally*d3)))] = descriptorMatrix[d1+numberOfBlocksPerWindowVertically*(d2+numberOfBlocksPerWindowHorizontally*d3)];
                        }
                        else if (outputDescriptorsFormat==1)
                        {   // Matrix-Vector
                            d = 0;
                            for (d2=0; d2<numberOfBlocksPerWindowHorizontally; d2++) {
                                for (d1=0; d1<numberOfBlocksPerWindowVertically; d1++) {
                                    for (d3=0; d3<descriptorLengthPerBlock; d3++) {
                                        WindowsMatrixDescriptorsVector[windowIndexVertical+numberOfWindowsVertically*(windowIndexHorizontal+numberOfWindowsHorizontally*d)] = descriptorMatrix[d1+numberOfBlocksPerWindowVertically*(d2+numberOfBlocksPerWindowHorizontally*d3)];
                                        d=d+1; }}}
                        }
                        else if (outputDescriptorsFormat==2)
                        {   // Matrix-Matrix and Matrix-Vector
                            d = 0;
                            for (d2=0; d2<numberOfBlocksPerWindowHorizontally; d2++) {
                                for (d1=0; d1<numberOfBlocksPerWindowVertically; d1++) {
                                    for (d3=0; d3<descriptorLengthPerBlock; d3++) {
                                        WindowsMatrixDescriptorsMatrix[windowIndexVertical+numberOfWindowsVertically*(windowIndexHorizontal+numberOfWindowsHorizontally*(d1+numberOfBlocksPerWindowVertically*(d2+numberOfBlocksPerWindowHorizontally*d3)))] = descriptorMatrix[d1+numberOfBlocksPerWindowVertically*(d2+numberOfBlocksPerWindowHorizontally*d3)];
                                        WindowsMatrixDescriptorsVector[windowIndexVertical+numberOfWindowsVertically*(windowIndexHorizontal+numberOfWindowsHorizontally*d)] = descriptorMatrix[d1+numberOfBlocksPerWindowVertically*(d2+numberOfBlocksPerWindowHorizontally*d3)];
                                        d=d+1; }}}
                        }
                    }
                    else if (outputWindowsFormat==1)
                    {
                        if (outputDescriptorsFormat==0)
                        {   // Vector-Matrix
                            for (d2=0; d2<numberOfBlocksPerWindowHorizontally; d2++)
                                for (d1=0; d1<numberOfBlocksPerWindowVertically; d1++)
                                    for (d3=0; d3<descriptorLengthPerBlock; d3++)
                                        WindowsVectorDescriptorsMatrix[windowCounter+numberOfWindows*(d1+numberOfBlocksPerWindowVertically*(d2+numberOfBlocksPerWindowHorizontally*d3))] = descriptorMatrix[d1+numberOfBlocksPerWindowVertically*(d2+numberOfBlocksPerWindowHorizontally*d3)];
                        }
                        else if (outputDescriptorsFormat==1)
                        {   // Vector-Vector
                            d = 0;
                            for (d2=0; d2<numberOfBlocksPerWindowHorizontally; d2++) {
                                for (d1=0; d1<numberOfBlocksPerWindowVertically; d1++) {
                                    for (d3=0; d3<descriptorLengthPerBlock; d3++) {
                                        WindowsVectorDescriptorsVector[windowCounter+numberOfWindows*d] = descriptorMatrix[d1+numberOfBlocksPerWindowVertically*(d2+numberOfBlocksPerWindowHorizontally*d3)];
                                        d=d+1; }}}
                        }
                        else if (outputDescriptorsFormat==2)
                        {   // Vector-Matrix and Vector-Vector
                            d = 0;
                            for (d2=0; d2<numberOfBlocksPerWindowHorizontally; d2++) {
                                for (d1=0; d1<numberOfBlocksPerWindowVertically; d1++) {
                                    for (d3=0; d3<descriptorLengthPerBlock; d3++) {
                                        WindowsVectorDescriptorsMatrix[windowCounter+numberOfWindows*(d1+numberOfBlocksPerWindowVertically*(d2+numberOfBlocksPerWindowHorizontally*d3))] = descriptorMatrix[d1+numberOfBlocksPerWindowVertically*(d2+numberOfBlocksPerWindowHorizontally*d3)];
                                        WindowsVectorDescriptorsVector[windowCounter+numberOfWindows*d] = descriptorMatrix[d1+numberOfBlocksPerWindowVertically*(d2+numberOfBlocksPerWindowHorizontally*d3)];
                                        d=d+1; }}}
                        }
                    }
                    else if (outputWindowsFormat==2)
                    {
                        if (outputDescriptorsFormat==0)
                        {   // Matrix-Matrix and Vector-Matrix
                            for (d2=0; d2<numberOfBlocksPerWindowHorizontally; d2++) {
                                for (d1=0; d1<numberOfBlocksPerWindowVertically; d1++) {
                                    for (d3=0; d3<descriptorLengthPerBlock; d3++) {
                                        WindowsMatrixDescriptorsMatrix[windowIndexVertical+numberOfWindowsVertically*(windowIndexHorizontal+numberOfWindowsHorizontally*(d1+numberOfBlocksPerWindowVertically*(d2+numberOfBlocksPerWindowHorizontally*d3)))] = descriptorMatrix[d1+numberOfBlocksPerWindowVertically*(d2+numberOfBlocksPerWindowHorizontally*d3)];
                                        WindowsVectorDescriptorsMatrix[windowCounter+numberOfWindows*(d1+numberOfBlocksPerWindowVertically*(d2+numberOfBlocksPerWindowHorizontally*d3))] = descriptorMatrix[d1+numberOfBlocksPerWindowVertically*(d2+numberOfBlocksPerWindowHorizontally*d3)]; } } }
                        }
                        else if (outputDescriptorsFormat==1)
                        {   // Matrix-Vector and Vector-Vector
                            d = 0;
                            for (d2=0; d2<numberOfBlocksPerWindowHorizontally; d2++) {
                                for (d1=0; d1<numberOfBlocksPerWindowVertically; d1++) {
                                    for (d3=0; d3<descriptorLengthPerBlock; d3++) {
                                        WindowsMatrixDescriptorsVector[windowIndexVertical+numberOfWindowsVertically*(windowIndexHorizontal+numberOfWindowsHorizontally*d)] = descriptorMatrix[d1+numberOfBlocksPerWindowVertically*(d2+numberOfBlocksPerWindowHorizontally*d3)];
                                        WindowsVectorDescriptorsVector[windowCounter+numberOfWindows*d] = descriptorMatrix[d1+numberOfBlocksPerWindowVertically*(d2+numberOfBlocksPerWindowHorizontally*d3)];
                                        d=d+1; }}}
                        }
                        else if (outputDescriptorsFormat==2)
                        {   // Matrix-Matrix and Vector-Matrix and Matrix-Vector and Vector-Vector
                            d = 0;
                            for (d2=0; d2<numberOfBlocksPerWindowHorizontally; d2++) {
                                for (d1=0; d1<numberOfBlocksPerWindowVertically; d1++) {
                                    for (d3=0; d3<descriptorLengthPerBlock; d3++) {
                                        WindowsMatrixDescriptorsMatrix[windowIndexVertical+numberOfWindowsVertically*(windowIndexHorizontal+numberOfWindowsHorizontally*(d1+numberOfBlocksPerWindowVertically*(d2+numberOfBlocksPerWindowHorizontally*d3)))] = descriptorMatrix[d1+numberOfBlocksPerWindowVertically*(d2+numberOfBlocksPerWindowHorizontally*d3)];
                                        WindowsVectorDescriptorsMatrix[windowCounter+numberOfWindows*(d1+numberOfBlocksPerWindowVertically*(d2+numberOfBlocksPerWindowHorizontally*d3))] = descriptorMatrix[d1+numberOfBlocksPerWindowVertically*(d2+numberOfBlocksPerWindowHorizontally*d3)];
                                        WindowsMatrixDescriptorsVector[windowIndexVertical+numberOfWindowsVertically*(windowIndexHorizontal+numberOfWindowsHorizontally*d)] = descriptorMatrix[d1+numberOfBlocksPerWindowVertically*(d2+numberOfBlocksPerWindowHorizontally*d3)];
                                        WindowsVectorDescriptorsVector[windowCounter+numberOfWindows*d] = descriptorMatrix[d1+numberOfBlocksPerWindowVertically*(d2+numberOfBlocksPerWindowHorizontally*d3)];
                                        d=d+1; }}}
                        }
                    }
                }
                else if (outputWindowsCenters==1)
                {
                    if (outputWindowsFormat==0)
                    {
                        if (outputDescriptorsFormat==0)
                        {   // Matrix-Matrix
                            for (d2=0; d2<numberOfBlocksPerWindowHorizontally; d2++)
                                for (d1=0; d1<numberOfBlocksPerWindowVertically; d1++)
                                    for (d3=0; d3<descriptorLengthPerBlock; d3++)
                                        WindowsMatrixDescriptorsMatrix[windowIndexVertical+numberOfWindowsVertically*(windowIndexHorizontal+numberOfWindowsHorizontally*(d1+numberOfBlocksPerWindowVertically*(d2+numberOfBlocksPerWindowHorizontally*d3)))] = descriptorMatrix[d1+numberOfBlocksPerWindowVertically*(d2+numberOfBlocksPerWindowHorizontally*d3)];
                        }
                        else if (outputDescriptorsFormat==1)
                        {   // Matrix-Vector
                            d = 0;
                            for (d2=0; d2<numberOfBlocksPerWindowHorizontally; d2++) {
                                for (d1=0; d1<numberOfBlocksPerWindowVertically; d1++) {
                                    for (d3=0; d3<descriptorLengthPerBlock; d3++) {
                                        WindowsMatrixDescriptorsVector[windowIndexVertical+numberOfWindowsVertically*(windowIndexHorizontal+numberOfWindowsHorizontally*d)] = descriptorMatrix[d1+numberOfBlocksPerWindowVertically*(d2+numberOfBlocksPerWindowHorizontally*d3)];
                                        d=d+1; }}}
                        }
                        else if (outputDescriptorsFormat==2)
                        {   // Matrix-Matrix and Matrix-Vector
                            d = 0;
                            for (d2=0; d2<numberOfBlocksPerWindowHorizontally; d2++) {
                                for (d1=0; d1<numberOfBlocksPerWindowVertically; d1++) {
                                    for (d3=0; d3<descriptorLengthPerBlock; d3++) {
                                        WindowsMatrixDescriptorsMatrix[windowIndexVertical+numberOfWindowsVertically*(windowIndexHorizontal+numberOfWindowsHorizontally*(d1+numberOfBlocksPerWindowVertically*(d2+numberOfBlocksPerWindowHorizontally*d3)))] = descriptorMatrix[d1+numberOfBlocksPerWindowVertically*(d2+numberOfBlocksPerWindowHorizontally*d3)];
                                        WindowsMatrixDescriptorsVector[windowIndexVertical+numberOfWindowsVertically*(windowIndexHorizontal+numberOfWindowsHorizontally*d)] = descriptorMatrix[d1+numberOfBlocksPerWindowVertically*(d2+numberOfBlocksPerWindowHorizontally*d3)];
                                        d=d+1; }}}
                        }
                        WindowsCentersMatrix[windowIndexVertical+numberOfWindowsVertically*windowIndexHorizontal] = rowCenter + 1;
                        WindowsCentersMatrix[windowIndexVertical+numberOfWindowsVertically*(windowIndexHorizontal+numberOfWindowsHorizontally)] = columnCenter + 1;
                    }
                    else if (outputWindowsFormat==1)
                    {
                        if (outputDescriptorsFormat==0)
                        {   // Vector-Matrix
                            for (d2=0; d2<numberOfBlocksPerWindowHorizontally; d2++)
                                for (d1=0; d1<numberOfBlocksPerWindowVertically; d1++)
                                    for (d3=0; d3<descriptorLengthPerBlock; d3++)
                                        WindowsVectorDescriptorsMatrix[windowCounter+numberOfWindows*(d1+numberOfBlocksPerWindowVertically*(d2+numberOfBlocksPerWindowHorizontally*d3))] = descriptorMatrix[d1+numberOfBlocksPerWindowVertically*(d2+numberOfBlocksPerWindowHorizontally*d3)];
                        }
                        else if (outputDescriptorsFormat==1)
                        {   // Vector-Vector
                            d = 0;
                            for (d2=0; d2<numberOfBlocksPerWindowHorizontally; d2++) {
                                for (d1=0; d1<numberOfBlocksPerWindowVertically; d1++) {
                                    for (d3=0; d3<descriptorLengthPerBlock; d3++) {
                                        WindowsVectorDescriptorsVector[windowCounter+numberOfWindows*d] = descriptorMatrix[d1+numberOfBlocksPerWindowVertically*(d2+numberOfBlocksPerWindowHorizontally*d3)];
                                        d=d+1; }}}
                        }
                        else if (outputDescriptorsFormat==2)
                        {   // Vector-Matrix and Vector-Vector
                            d = 0;
                            for (d2=0; d2<numberOfBlocksPerWindowHorizontally; d2++) {
                                for (d1=0; d1<numberOfBlocksPerWindowVertically; d1++) {
                                    for (d3=0; d3<descriptorLengthPerBlock; d3++) {
                                        WindowsVectorDescriptorsMatrix[windowCounter+numberOfWindows*(d1+numberOfBlocksPerWindowVertically*(d2+numberOfBlocksPerWindowHorizontally*d3))] = descriptorMatrix[d1+numberOfBlocksPerWindowVertically*(d2+numberOfBlocksPerWindowHorizontally*d3)];
                                        WindowsVectorDescriptorsVector[windowCounter+numberOfWindows*d] = descriptorMatrix[d1+numberOfBlocksPerWindowVertically*(d2+numberOfBlocksPerWindowHorizontally*d3)];
                                        d=d+1; }}}
                        }
                        WindowsCentersVector[windowCounter] = rowCenter + 1;
                        WindowsCentersVector[windowCounter+numberOfWindows] = columnCenter + 1;
                    }
                    else if (outputWindowsFormat==2)
                    {
                        if (outputDescriptorsFormat==0)
                        {   // Matrix-Matrix and Vector-Matrix
                            for (d2=0; d2<numberOfBlocksPerWindowHorizontally; d2++) {
                                for (d1=0; d1<numberOfBlocksPerWindowVertically; d1++) {
                                    for (d3=0; d3<descriptorLengthPerBlock; d3++) {
                                        WindowsMatrixDescriptorsMatrix[windowIndexVertical+numberOfWindowsVertically*(windowIndexHorizontal+numberOfWindowsHorizontally*(d1+numberOfBlocksPerWindowVertically*(d2+numberOfBlocksPerWindowHorizontally*d3)))] = descriptorMatrix[d1+numberOfBlocksPerWindowVertically*(d2+numberOfBlocksPerWindowHorizontally*d3)];
                                        WindowsVectorDescriptorsMatrix[windowCounter+numberOfWindows*(d1+numberOfBlocksPerWindowVertically*(d2+numberOfBlocksPerWindowHorizontally*d3))] = descriptorMatrix[d1+numberOfBlocksPerWindowVertically*(d2+numberOfBlocksPerWindowHorizontally*d3)]; } } }
                        }
                        else if (outputDescriptorsFormat==1)
                        {   // Matrix-Vector and Vector-Vector
                            d = 0;
                            for (d2=0; d2<numberOfBlocksPerWindowHorizontally; d2++) {
                                for (d1=0; d1<numberOfBlocksPerWindowVertically; d1++) {
                                    for (d3=0; d3<descriptorLengthPerBlock; d3++) {
                                        WindowsMatrixDescriptorsVector[windowIndexVertical+numberOfWindowsVertically*(windowIndexHorizontal+numberOfWindowsHorizontally*d)] = descriptorMatrix[d1+numberOfBlocksPerWindowVertically*(d2+numberOfBlocksPerWindowHorizontally*d3)];
                                        WindowsVectorDescriptorsVector[windowCounter+numberOfWindows*d] = descriptorMatrix[d1+numberOfBlocksPerWindowVertically*(d2+numberOfBlocksPerWindowHorizontally*d3)];
                                        d=d+1; }}}
                        }
                        else if (outputDescriptorsFormat==2)
                        {   // Matrix-Matrix and Vector-Matrix and Matrix-Vector and Vector-Vector
                            d = 0;
                            for (d2=0; d2<numberOfBlocksPerWindowHorizontally; d2++) {
                                for (d1=0; d1<numberOfBlocksPerWindowVertically; d1++) {
                                    for (d3=0; d3<descriptorLengthPerBlock; d3++) {
                                        WindowsMatrixDescriptorsMatrix[windowIndexVertical+numberOfWindowsVertically*(windowIndexHorizontal+numberOfWindowsHorizontally*(d1+numberOfBlocksPerWindowVertically*(d2+numberOfBlocksPerWindowHorizontally*d3)))] = descriptorMatrix[d1+numberOfBlocksPerWindowVertically*(d2+numberOfBlocksPerWindowHorizontally*d3)];
                                        WindowsVectorDescriptorsMatrix[windowCounter+numberOfWindows*(d1+numberOfBlocksPerWindowVertically*(d2+numberOfBlocksPerWindowHorizontally*d3))] = descriptorMatrix[d1+numberOfBlocksPerWindowVertically*(d2+numberOfBlocksPerWindowHorizontally*d3)];
                                        WindowsMatrixDescriptorsVector[windowIndexVertical+numberOfWindowsVertically*(windowIndexHorizontal+numberOfWindowsHorizontally*d)] = descriptorMatrix[d1+numberOfBlocksPerWindowVertically*(d2+numberOfBlocksPerWindowHorizontally*d3)];
                                        WindowsVectorDescriptorsVector[windowCounter+numberOfWindows*d] = descriptorMatrix[d1+numberOfBlocksPerWindowVertically*(d2+numberOfBlocksPerWindowHorizontally*d3)];
                                        d=d+1; }}}
                        }
                        WindowsCentersMatrix[windowIndexVertical+numberOfWindowsVertically*windowIndexHorizontal] = rowCenter + 1;
                        WindowsCentersMatrix[windowIndexVertical+numberOfWindowsVertically*(windowIndexHorizontal+numberOfWindowsHorizontally)] = columnCenter + 1;
                        WindowsCentersVector[windowCounter] = rowCenter + 1;
                        WindowsCentersVector[windowCounter+numberOfWindows] = columnCenter + 1;
                    }
                }
            }
        }
    }
    
    // Destroy arrays
    mxDestroyArray(windowImageTemp);
    mxDestroyArray(descriptorMatrixTemp);
    if (method==1)
        mxDestroyArray(descriptorVectorTemp);
}


// ZHU & RAMANAN: Face Detection, Pose Estimation and Landmark Localization in the Wild
void ZhuRamananHOGdescriptor(double *inputImage, int sbin, int *imageSize, double *descriptorMatrix)
{
    // unit vectors used to compute gradient orientation
    double uu[9] = {1.0000,0.9397,0.7660,0.500,0.1736,-0.1736,-0.5000,-0.7660,-0.9397};
    double vv[9] = {0.0000,0.3420,0.6428,0.8660,0.9848,0.9848,0.8660,0.6428,0.3420};
    
    int imageWidth  = imageSize[1];
    int imageHeight = imageSize[0];
    int x,y,o;
    
    // memory for caching orientation histograms & their norms
    int blocks[2];
    blocks[0] = (int)round((double)imageSize[0]/(double)sbin);
    blocks[1] = (int)round((double)imageSize[1]/(double)sbin);
    double *hist = (double *)mxCalloc(blocks[0]*blocks[1]*18, sizeof(double));
    double *norm = (double *)mxCalloc(blocks[0]*blocks[1], sizeof(double));
    
    // memory for HOG features
    int out[3];
    out[0] = max(blocks[0]-2, 0);
    out[1] = max(blocks[1]-2, 0);
    out[2] = 27+4;

    int visible[2];
    visible[0] = blocks[0]*sbin;
    visible[1] = blocks[1]*sbin;
    
    for (x=1; x<visible[1]-1; x++)
    {
        for (y=1; y<visible[0]-1; y++)
        {
            // first color channel
            double *s = inputImage + min(x,imageSize[1]-2)*imageSize[0] + min(y,imageSize[0]-2);
            double dy = *(s+1) - *(s-1);
            double dx = *(s+imageSize[0]) - *(s-imageSize[0]);
            double v = dx*dx + dy*dy;
            
            // second color channel
            s += imageSize[0]*imageSize[1];
            double dy2 = *(s+1) - *(s-1);
            double dx2 = *(s+imageSize[0]) - *(s-imageSize[0]);
            double v2 = dx2*dx2 + dy2*dy2;
            
            // third color channel
            s += imageSize[0]*imageSize[1];
            double dy3 = *(s+1) - *(s-1);
            double dx3 = *(s+imageSize[0]) - *(s-imageSize[0]);
            double v3 = dx3*dx3 + dy3*dy3;
            
            // pick channel with strongest gradient
            if (v2>v)
            {
                v = v2;
                dx = dx2;
                dy = dy2;
            }
            if (v3>v)
            {
                v = v3;
                dx = dx3;
                dy = dy3;
            }
            
            // snap to one of 18 orientations
            double best_dot = 0;
            int best_o = 0;
            for (o=0; o<9; o++)
            {
                double dot = uu[o]*dx + vv[o]*dy;
                if (dot>best_dot)
                {
                    best_dot = dot;
                    best_o = o;
                }
                else if (-dot>best_dot)
                {
                    best_dot = -dot;
                    best_o = o + 9;
                }
            }
            
            // add to 4 histograms around pixel using linear interpolation
            double xp = ((double)x+0.5)/(double)sbin - 0.5;
            double yp = ((double)y+0.5)/(double)sbin - 0.5;
            int ixp = (int)floor(xp);
            int iyp = (int)floor(yp);
            double vx0 = xp-ixp;
            double vy0 = yp-iyp;
            double vx1 = 1.0-vx0;
            double vy1 = 1.0-vy0;
            v = sqrt(v);
            
            if (ixp>=0 && iyp>=0)
                *(hist + ixp*blocks[0] + iyp + best_o*blocks[0]*blocks[1]) += vx1*vy1*v;

            
            if (ixp+1 < blocks[1] && iyp >= 0)
                *(hist + (ixp+1)*blocks[0] + iyp + best_o*blocks[0]*blocks[1]) += vx0*vy1*v;
            
            if (ixp >= 0 && iyp+1 < blocks[0])
                *(hist + ixp*blocks[0] + (iyp+1) + best_o*blocks[0]*blocks[1]) += vx1*vy0*v;
            
            if (ixp+1 < blocks[1] && iyp+1 < blocks[0])
                *(hist + (ixp+1)*blocks[0] + (iyp+1) + best_o*blocks[0]*blocks[1]) += vx0*vy0*v;
        }
    }
    
    // compute energy in each block by summing over orientations
    for (int o = 0; o < 9; o++)
    {
        double *src1 = hist + o*blocks[0]*blocks[1];
        double *src2 = hist + (o+9)*blocks[0]*blocks[1];
        double *dst = norm;
        double *end = norm + blocks[1]*blocks[0];
        while (dst < end)
        {
            *(dst++) += (*src1 + *src2) * (*src1 + *src2);
            src1++;
            src2++;
        }
    }
    
    // compute features
    for (x=0; x<out[1]; x++)
    {
        for (y=0; y<out[0]; y++)
        {
            double *dst = descriptorMatrix + x*out[0] + y;
            double *src, *p, n1, n2, n3, n4;
            
            p = norm + (x+1)*blocks[0] + y+1;
            n1 = 1.0 / sqrt(*p + *(p+1) + *(p+blocks[0]) + *(p+blocks[0]+1) + eps);
            p = norm + (x+1)*blocks[0] + y;
            n2 = 1.0 / sqrt(*p + *(p+1) + *(p+blocks[0]) + *(p+blocks[0]+1) + eps);
            p = norm + x*blocks[0] + y+1;
            n3 = 1.0 / sqrt(*p + *(p+1) + *(p+blocks[0]) + *(p+blocks[0]+1) + eps);
            p = norm + x*blocks[0] + y;
            n4 = 1.0 / sqrt(*p + *(p+1) + *(p+blocks[0]) + *(p+blocks[0]+1) + eps);
            
            double t1 = 0;
            double t2 = 0;
            double t3 = 0;
            double t4 = 0;
            
            // contrast-sensitive features
            src = hist + (x+1)*blocks[0] + (y+1);
            for (int o = 0; o < 18; o++)
            {
                double h1 = min(*src * n1, 0.2);
                double h2 = min(*src * n2, 0.2);
                double h3 = min(*src * n3, 0.2);
                double h4 = min(*src * n4, 0.2);
                *dst = 0.5 * (h1 + h2 + h3 + h4);
                t1 += h1;
                t2 += h2;
                t3 += h3;
                t4 += h4;
                dst += out[0]*out[1];
                src += blocks[0]*blocks[1];
            }
            
            // contrast-insensitive features
            src = hist + (x+1)*blocks[0] + (y+1);
            for (int o = 0; o < 9; o++)
            {
                double sum = *src + *(src + 9*blocks[0]*blocks[1]);
                double h1 = min(sum * n1, 0.2);
                double h2 = min(sum * n2, 0.2);
                double h3 = min(sum * n3, 0.2);
                double h4 = min(sum * n4, 0.2);
                *dst = 0.5 * (h1 + h2 + h3 + h4);
                dst += out[0]*out[1];
                src += blocks[0]*blocks[1];
            }
            
            // texture features
            *dst = 0.2357 * t1;
            dst += out[0]*out[1];
            *dst = 0.2357 * t2;
            dst += out[0]*out[1];
            *dst = 0.2357 * t3;
            dst += out[0]*out[1];
            *dst = 0.2357 * t4;
        }
    }
    mxFree(hist);
    mxFree(norm);
}



// DALAL & TRIGGS: Histograms of Oriented Gradients for Human Detection
void DalalTriggsHOGdescriptor(double *inputImage, double *params, int *imageSize, double *descriptorVector, unsigned int grayscale)
{
    
    const float pi = 3.1415926536;
    
    int numberOfOrientationBins       = (int) params[0];
    double cellHeightAndWidthInPixels     =  params[1];
    int blockHeightAndWidthInCells    = (int) params[2];
    int signedOrUnsignedGradients        = (int) params[3];
    double l2normClipping   = params[4];
    
    int imageWidth  = imageSize[1];
    int imageHeight = imageSize[0];
    
    int hist1= 2+ceil(-0.5 + imageHeight/cellHeightAndWidthInPixels);
    int hist2= 2+ceil(-0.5 + imageWidth/cellHeightAndWidthInPixels);
    
    double binsSize = (1+(signedOrUnsignedGradients==1))*pi/numberOfOrientationBins;
    
    float dx[3], dy[3], gradientOrientation, gradientMagnitude, tempMagnitude;
    float Xc, Yc, Oc, blockNorm;
    int x1, x2, y1, y2, bin1, bin2;
    int descriptorIndex = 0;
    
    vector<vector<vector<double> > > h(hist1, vector<vector<double> > (hist2, vector<double> (numberOfOrientationBins, 0.0) ) );    
    vector<vector<vector<double> > > block(blockHeightAndWidthInCells, vector<vector<double> > (blockHeightAndWidthInCells, vector<double> (numberOfOrientationBins, 0.0) ) );
    
    //Calculate gradients (zero padding)
    for(unsigned int y=0; y<imageHeight; y++) {
        for(unsigned int x=0; x<imageWidth; x++) {
            if (grayscale == 1){
                if(x==0) dx[0] = inputImage[y +(x+1)*imageHeight];
                else{
                    if (x==imageWidth-1) dx[0] = -inputImage[y + (x-1)*imageHeight];
                    else dx[0] = inputImage[y+(x+1)*imageHeight] - inputImage[y + (x-1)*imageHeight];
                }
                if(y==0) dy[0] = -inputImage[y+1+x*imageHeight];
                else{
                    if (y==imageHeight-1) dy[0] = inputImage[y-1+x*imageHeight];
                    else dy[0] = -inputImage[y+1+x*imageHeight] + inputImage[y-1+x*imageHeight];
                }
            }
            else{
                if(x==0){
                    dx[0] = inputImage[y +(x+1)*imageHeight];
                    dx[1] = inputImage[y +(x+1)*imageHeight + imageHeight*imageWidth];
                    dx[2] = inputImage[y +(x+1)*imageHeight + 2*imageHeight*imageWidth];                    
                }
                else{
                    if (x==imageWidth-1){
                        dx[0] = -inputImage[y + (x-1)*imageHeight];                        
                        dx[1] = -inputImage[y + (x-1)*imageHeight + imageHeight*imageWidth];
                        dx[2] = -inputImage[y + (x-1)*imageHeight + 2*imageHeight*imageWidth];
                    }
                    else{
                        dx[0] = inputImage[y+(x+1)*imageHeight] - inputImage[y + (x-1)*imageHeight];
                        dx[1] = inputImage[y+(x+1)*imageHeight + imageHeight*imageWidth] - inputImage[y + (x-1)*imageHeight + imageHeight*imageWidth];
                        dx[2] = inputImage[y+(x+1)*imageHeight + 2*imageHeight*imageWidth] - inputImage[y + (x-1)*imageHeight + 2*imageHeight*imageWidth];
                        
                    }
                }
                if(y==0){
                    dy[0] = -inputImage[y+1+x*imageHeight];
                    dy[1] = -inputImage[y+1+x*imageHeight + imageHeight*imageWidth];
                    dy[2] = -inputImage[y+1+x*imageHeight + 2*imageHeight*imageWidth];
                }
                else{
                    if (y==imageHeight-1){
                        dy[0] = inputImage[y-1+x*imageHeight];
                        dy[1] = inputImage[y-1+x*imageHeight + imageHeight*imageWidth];
                        dy[2] = inputImage[y-1+x*imageHeight + 2*imageHeight*imageWidth];
                    }
                    else{
                        dy[0] = -inputImage[y+1+x*imageHeight] + inputImage[y-1+x*imageHeight];
                        dy[1] = -inputImage[y+1+x*imageHeight + imageHeight*imageWidth] + inputImage[y-1+x*imageHeight + imageHeight*imageWidth];
                        dy[2] = -inputImage[y+1+x*imageHeight + 2*imageHeight*imageWidth] + inputImage[y-1+x*imageHeight + 2*imageHeight*imageWidth];
                    }
                }
            }
            
            gradientMagnitude = sqrt(dx[0]*dx[0] + dy[0]*dy[0]);
            gradientOrientation= atan2(dy[0], dx[0]);
            
            if (grayscale == 0){
                tempMagnitude = gradientMagnitude;
                for (unsigned int cli=1;cli<3;++cli){
                    tempMagnitude= sqrt(dx[cli]*dx[cli] + dy[cli]*dy[cli]);
                    if (tempMagnitude>gradientMagnitude){
                        gradientMagnitude=tempMagnitude;
                        gradientOrientation= atan2(dy[cli], dx[cli]);
                    }
                }
            }
            
            if (gradientOrientation<0) gradientOrientation+=pi + (signedOrUnsignedGradients==1) * pi;

            // trilinear interpolation
            
            bin1 = (int)floor(0.5 + gradientOrientation/binsSize) - 1;
            bin2 = bin1 + 1;
            x1   = (int)floor(0.5+ x/cellHeightAndWidthInPixels);
            x2   = x1+1;
            y1   = (int)floor(0.5+ y/cellHeightAndWidthInPixels);
            y2   = y1 + 1;
            
            Xc = (x1+1-1.5)*cellHeightAndWidthInPixels + 0.5;
            Yc = (y1+1-1.5)*cellHeightAndWidthInPixels + 0.5;
            
            Oc = (bin1+1+1-1.5)*binsSize;
            
            if (bin2==numberOfOrientationBins){
                bin2=0;
            }
            if (bin1<0){
                bin1=numberOfOrientationBins-1;
            }            
           
            h[y1][x1][bin1]= h[y1][x1][bin1]+gradientMagnitude*(1-((x+1-Xc)/cellHeightAndWidthInPixels))*(1-((y+1-Yc)/cellHeightAndWidthInPixels))*(1-((gradientOrientation-Oc)/binsSize));
            h[y1][x1][bin2]= h[y1][x1][bin2]+gradientMagnitude*(1-((x+1-Xc)/cellHeightAndWidthInPixels))*(1-((y+1-Yc)/cellHeightAndWidthInPixels))*(((gradientOrientation-Oc)/binsSize));
            h[y2][x1][bin1]= h[y2][x1][bin1]+gradientMagnitude*(1-((x+1-Xc)/cellHeightAndWidthInPixels))*(((y+1-Yc)/cellHeightAndWidthInPixels))*(1-((gradientOrientation-Oc)/binsSize));
            h[y2][x1][bin2]= h[y2][x1][bin2]+gradientMagnitude*(1-((x+1-Xc)/cellHeightAndWidthInPixels))*(((y+1-Yc)/cellHeightAndWidthInPixels))*(((gradientOrientation-Oc)/binsSize));
            h[y1][x2][bin1]= h[y1][x2][bin1]+gradientMagnitude*(((x+1-Xc)/cellHeightAndWidthInPixels))*(1-((y+1-Yc)/cellHeightAndWidthInPixels))*(1-((gradientOrientation-Oc)/binsSize));
            h[y1][x2][bin2]= h[y1][x2][bin2]+gradientMagnitude*(((x+1-Xc)/cellHeightAndWidthInPixels))*(1-((y+1-Yc)/cellHeightAndWidthInPixels))*(((gradientOrientation-Oc)/binsSize));
            h[y2][x2][bin1]= h[y2][x2][bin1]+gradientMagnitude*(((x+1-Xc)/cellHeightAndWidthInPixels))*(((y+1-Yc)/cellHeightAndWidthInPixels))*(1-((gradientOrientation-Oc)/binsSize));
            h[y2][x2][bin2]= h[y2][x2][bin2]+gradientMagnitude*(((x+1-Xc)/cellHeightAndWidthInPixels))*(((y+1-Yc)/cellHeightAndWidthInPixels))*(((gradientOrientation-Oc)/binsSize));
        }
    }
    
    
    
    //Block normalization
    for(unsigned int x=1; x<hist2-blockHeightAndWidthInCells; x++)
    {
        for (unsigned int y=1; y<hist1-blockHeightAndWidthInCells; y++)
        {
            
            blockNorm=0;
            for (unsigned int i=0; i<blockHeightAndWidthInCells; i++)
            {
                for(unsigned int j=0; j<blockHeightAndWidthInCells; j++)
                {
                    for(unsigned int k=0; k<numberOfOrientationBins; k++)
                    {
                        blockNorm+=h[y+i][x+j][k]*h[y+i][x+j][k];
                    }
                }
            }
            
            blockNorm=sqrt(blockNorm);
            for (unsigned int i=0; i<blockHeightAndWidthInCells; i++)
            {
                for(unsigned int j=0; j<blockHeightAndWidthInCells; j++)
                {
                    for(unsigned int k=0; k<numberOfOrientationBins; k++)
                    {
                        if (blockNorm>0)
                        {
                            block[i][j][k]=h[y+i][x+j][k]/blockNorm;
                            if (block[i][j][k]>l2normClipping)
                                block[i][j][k]=l2normClipping;
                        }
                    }
                }
            }
            
            blockNorm=0;
            for (unsigned int i=0; i<blockHeightAndWidthInCells; i++)
            {
                for(unsigned int j=0; j<blockHeightAndWidthInCells; j++)
                {
                    for(unsigned int k=0; k<numberOfOrientationBins; k++)
                    {
                        blockNorm+=block[i][j][k]*block[i][j][k];
                    }
                }
            }
            
            blockNorm=sqrt(blockNorm);
            for (unsigned int i=0; i<blockHeightAndWidthInCells; i++)
            {
                for(unsigned int j=0; j<blockHeightAndWidthInCells; j++)
                {
                    for(unsigned int k=0; k<numberOfOrientationBins; k++)
                    {
                        if (blockNorm>0)
                            descriptorVector[descriptorIndex]=block[i][j][k]/blockNorm;
                        else
                            descriptorVector[descriptorIndex]=0.0;
                        descriptorIndex++;
                    }
                }
            }
        }
    }
}

