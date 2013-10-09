%% FIRST CASE
returnOnlyWindowsWithinImageLimits = 1;

im = rand(11,11);

imageWidth = size(im,2);
imageHeight = size(im,1);

windowHeight = 11;
windowWidth = 11;

windowStepHorizontal = 100;
windowStepVertical = 100;

if returnOnlyWindowsWithinImageLimits==1
	numberOfWindowsHorizontally = 1+floor((imageWidth-windowWidth)/windowStepHorizontal);
	numberOfWindowsVertically = 1+floor((imageHeight-windowHeight)/windowStepVertical);
else
    numberOfWindowsHorizontally = ceil(imageWidth/windowStepHorizontal);
    numberOfWindowsVertically = ceil(imageHeight/windowStepVertical);
end;

numberOfWindows = numberOfWindowsHorizontally*numberOfWindowsVertically;

fprintf('Image Size = %d x %d\n',imageHeight,imageWidth);
fprintf('Window Size = %d x %d\n',windowHeight,windowWidth);
fprintf('Window Step = %d x %d\n',windowStepVertical,windowStepHorizontal);
fprintf('Number of Windows Vertical = %d\n',numberOfWindowsVertically);
fprintf('Number of Windows Horizontal = %d\n',numberOfWindowsHorizontally);

% FOR returnOnlyWindowsWithinImageLimits = 1;
for i=0:numberOfWindowsVertically-1
    from = i*windowStepVertical;
    to = from + windowWidth - 1;
    ctr = from + round(windowWidth/2) - 1;
    fprintf('Window %d --> %d-%d-%d\n',i,from,ctr,to);
end;
    

%% SECOND CASE
returnOnlyWindowsWithinImageLimits = 0;

im = rand(10,10);

imageWidth = size(im,2);
imageHeight = size(im,1);

windowHeight = 3;
windowWidth = 3;

windowStepHorizontal = 1;
windowStepVertical = 1;

if returnOnlyWindowsWithinImageLimits==1
	numberOfWindowsHorizontally = 1+floor((imageWidth-windowWidth)/windowStepHorizontal);
	numberOfWindowsVertically = 1+floor((imageHeight-windowHeight)/windowStepVertical);
else
    numberOfWindowsHorizontally = ceil(imageWidth/windowStepHorizontal);
    numberOfWindowsVertically = ceil(imageHeight/windowStepVertical);
end;

numberOfWindows = numberOfWindowsHorizontally*numberOfWindowsVertically;

padXleft = round(windowWidth/2) - 1;
padXright = (numberOfWindowsHorizontally-1)*windowStepHorizontal - round(windowWidth/2) + windowWidth - imageWidth;
padYup = round(windowHeight/2) - 1;
padYdown = (numberOfWindowsVertically-1)*windowStepVertical - round(windowHeight/2) + windowHeight - imageHeight;

fprintf('Image Size = %d x %d\n',imageHeight,imageWidth);
fprintf('Window Size = %d x %d\n',windowHeight,windowWidth);
fprintf('Window Step = %d x %d\n',windowStepVertical,windowStepHorizontal);
fprintf('Number of Windows Vertical = %d\n',numberOfWindowsVertically);
fprintf('Number of Windows Horizontal = %d\n',numberOfWindowsHorizontally);
fprintf('PadX (Horizontal) = %d | %d\n',padXleft,padXright);
fprintf('PadY (Vertical) = %d | %d\n',padYup,padYdown);

% FOR returnOnlyWindowsWithinImageLimits = 1;
for i=0:numberOfWindowsVertically-1
    %from = i*windowStepVertical;
    %to = from + windowWidth - 1;
    %ctr = from + round(windowWidth/2) - 1;
    ctr = i*windowStepVertical;
    from = ctr - ceil(windowWidth/2) + 1;%round(windowWidth/2) + 1;
    to = from + windowWidth - 1;
    fprintf('Window %d --> %d | %d | %d\n',i,from,ctr,to);
end;
