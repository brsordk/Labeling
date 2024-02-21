function AMvsTM(Input,CN)
% <Input>
% Input: The image directory - images files to be clustered
% CN: Cluster Number - Expected cluster number

% <Output>
% d: Resulting dendrogram with different clusters
% T: Table that specifies the clusters for each input data - saved as
% 'HICA_Clusters.xlsx' MS Excel file

% <Dependencies>
% This function requires the following MATLAB Toolboxes to be installed:
%  - Statistics and Machine Learning Toolbox
%  - Computer Vision Toolbox
%  - Image Processing Toolbox

% <Copyright>
% Author:   Baris Ördek
% Contact:  boerdek@unibz.it - barisordek@gmail.com
% Update:   30/01/2024
% Version:  4.0.0
% License: GNU General Public License v3.0

% This program is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.

% This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.

arguments
    Input = 'Insert The image directory here';
    CN = 2; %Specify the Cluster Number Here
end
%% Insert the image dataset
imds = imageDatastore(Input,'IncludeSubfolders',true,'LabelSource','foldernames');
numberofimages = length(imds.Files);
Labels_A = cellstr(filenames2labels(Input));
%% Labeled dataset
BB = readtable("Labeled Images.xlsx"); % Insert 5 AM-labeled parts
BBB = single(table2array(BB));
labels_BB={'AM1';'AM2';'AM3';'AM4';'AM5'};
Labels = [labels_BB ;Labels_A];
%% Preporcessing & Resizing & Feature Extraction
% Convert the images into 2D(Grayscale)
CS =4; %Cell Size for HOG
for i = 1:numberofimages

    inputFileName = imread(imds.Files{i}); %read each image
    [rows, columns, numberOfColorChannels] = size(inputFileName);
   
if numberOfColorChannels == 3
    grayImage = rgb2gray(inputFileName);
end

[r, c, ~] = size(grayImage);
if r>c
grayImageSize = imresize(grayImage, 512 / r);
elseif c>r
grayImageSize = imresize(grayImage, 512 / c);
else
grayImageSize = imresize(grayImage, [512, 512] );
end

[featureVector{i},hogVisualization] = extractHOGFeatures(grayImageSize,'CellSize',[CS CS]);

A{i} = featureVector{i}';
end
%% Clustering
B=cell2mat(A);
CC = [BBB B];
C = pdist(CC',"cosine"); % Cosine distance between the data points
Y = squareform(C);
Z=linkage(Y,'complete');
Clusters = cluster(Z,'maxclust',CN);    %Hierarchical Clustering
%% Plot dendrogram
figure(1)
cutoff =median([Z(end-(CN-1),3) Z(end-(CN-2),3)]); % set cut-off line location just change the number of clusters (a in line 36)
dendrogram(Z,0,'Labels',Labels,'ColorThreshold',cutoff);
yline(cutoff,'--','Cut-off Line','FontSize',14,'FontName','times','LineWidth',2); %show cutoff line in dendrogram
xlabel('Data Points');
ylabel('Similarity');
%% Export an MS Excel file that shows cluster number for each image
Clusters_BB=Clusters(6:end,1);
Labels_BBB = Labels(6:end,1);
T=table(Labels,Clusters);
T2 =table(Labels_BBB,Clusters_BB);
writetable(T2,'HICA_Clusters.xlsx'); % The MS Excel file will be saved at the same location as Matlab function "HICA"
%% Show resulted clusters up to 5 clusters (depends on what is specified as "CN" as an argument)
f = 0;
for k = 1:5
    if T.Clusters(k) == 1
        f=f+1;
    else
        f=f;
    end
end

if f>2

for j= 1:numberofimages
    if T2.Clusters_BB(j) == 1
        clust1{j} = j;
    clust1a =cell2mat(clust1);
    numberofimages2show = length(clust1a)+5;
    figure(2)
    imshow(imtile(imds.Files(clust1a),'GridSize',[15 15],'ThumbnailSize',[100 100]))
    title('Cluster 1 - Additive Manufacturing');
    end

    if T2.Clusters_BB(j) == 2
        clust2{j} = j;
    clust2a =cell2mat(clust2);
    numberofimages2show = length(clust2a)+5;
    figure(3)
    imshow(imtile(imds.Files(clust2a),'GridSize',[15 15],'ThumbnailSize',[100 100]))
    title('Cluster 2 - Traditional Manufacturing');
    end
end
else
 for j= 1:numberofimages
    if T2.Clusters_BB(j) == 1
        clust1{j} = j;
    clust1a =cell2mat(clust1);
    numberofimages2show = length(clust1a)+5;
    figure(2)
    imshow(imtile(imds.Files(clust1a),'GridSize',[15 15],'ThumbnailSize',[100 100]))
    title('Cluster 1 - Traditional Manufacturing');
    end

    if T2.Clusters_BB(j) == 2
        clust2{j} = j;
    clust2a =cell2mat(clust2);
    numberofimages2show = length(clust2a)+5;
    figure(3)
    imshow(imtile(imds.Files(clust2a),'GridSize',[15 15],'ThumbnailSize',[100 100]))
    title('Cluster 2 - Additive Manufacturing');
    end
end 
end
end
