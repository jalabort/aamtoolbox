function CompileHOGdescriptors
% Function to compile the mex files needed for the computation of HOGs.
%

cd ('ComputeHOGs');

mex -g mexComputeHOGdescriptorCell.cpp;
mex -g mexComputeHOGdescriptorStruct.cpp;
mex -g mexComputeHOGdescriptorMatrices.cpp;

cd ../;

end