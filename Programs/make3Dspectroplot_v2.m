function make3Dspectroplot_v2(port,power,flow,pressure,numi,Ii,numScans)
%Creates a cell arrays "X" and "Y" that contains all the wavelength and intensity
%data, respectively, from the given files

%clearing figures
close all;


[numf] = findFileNumbers(port,power,flow,pressure,numi);
[If] = findI(numi,numf,Ii,numScans);
[B] = findB(numi,numf,Ii,If,numScans);
filename = ['PORT_' num2str(port) '\' num2str(power,'%.1f') 'kW_' num2str(flow) 'sccm_' num2str(pressure,'%.1f') 'mT_'];

%Define sizing variables
filenumber=fileNumber(numf);
fileIDt=fopen([filename filenumber '.txt']);
Ct=textscan(fileIDt, '%7f %8f', 'Delimiter', ' ', 'HeaderLines', 17);
fclose(fileIDt);
ref=cell2mat((Ct(1))');
datasize=length(ref);
half=floor(((numf-numi+1)/(2*numScans)))-1;
%m=(bmax-bmin)/(half);
fileIDt=fopen([filename filenumber '.txt']);
temp = cell2mat(textscan(fileIDt, '%10f', 'Delimiter', 'Integration Time (usec): ', 'HeaderLines', 8));
integrationTime = temp(26)/1000000;
fclose(fileIDt);

%Manipulating default graph size (For presentation purposes)
set(0,'defaultfigureposition',[450,350,650,400]);

%Initializing matricies
X = zeros(datasize,half);
Y = zeros(datasize,half);
Z = zeros(datasize,half);
X1 = zeros(datasize,half);
Z1 = zeros(datasize,half);

%Storing data into matricies
waveRaw = zeros((numi+half)*numScans,datasize);
intenseRaw = zeros((numi+half)*numScans,datasize);
wave = zeros(half,datasize);
intense = zeros(half,datasize);
for i = (numi:half)
   for j = 0:numScans-1
    fileNum=fileNumber(i*numScans+j);
    filebase = [filename fileNum];
    fileID=fopen([filebase '.txt']);
    C=textscan(fileID, '%7f %8f', 'Delimiter', ' ', 'HeaderLines', 17);
    fclose(fileID);
    waveRaw(j+(numScans*i)+1,:)= cell2mat((C(1))');
    intenseRaw(j+(numScans*i)+1,:)= cell2mat((C(2))');
   end
end
for i = numi:half
    for k = (1:datasize)
        wave(i+1,k) = mean(waveRaw(((i*numScans)+1:((i+1)*numScans)),k));
        intense(i+1,k) = mean(intenseRaw(((i*numScans)+1:((i+1)*numScans)),k));
    end
end
for i = (numi:half)
   for j = (1:datasize)
        X(j,i-numi+1) = wave(i-numi+1,j);
           if i - numi == 0 
                Y(j,i-numi+1) = B(i-numi+1);
           else
                Y(j,i-numi+1)= B(i-numi);
           end
        Z(j,i-numi+1) = intense(i-numi+1,j)/integrationTime;
    end
end

mesh(X,Y,Z);
[minX,maxX,minY,maxY,minZ,maxZ] = setAxes(X,Y,Z);
xlim([minX maxX]);
ylim([minY maxY]);
zlim([minZ maxZ]);
view(-78,18);
% view(-6,12);
xlabel('Wavelength (nm)');
ylabel('Magnetic Field (Gauss)');
zlabel('Intensity');
title(['3D Plot of Spectroscopy Data (Increasing B) at ' 'Port ' num2str(port) ' ' num2str(power,'%.1f') 'kW ' num2str(flow) 'sccm ' num2str(pressure,'%.1f') 'mT']);
% saveas(gcf,['3D Plot of Spectroscopy Data (Increasing B) at paramaters' paramaters 'view2.jpg']);
% saveas(gcf,['3D Plot of Spectroscopy Data (Increasing B) at paramaters' paramaters 'view1.jpg']);


figure();

% Back Transition
half = half + 1;
waveRaw = zeros((numi+half)*numScans,datasize);
intenseRaw = zeros((numi+half)*numScans,datasize);
wave = zeros(half,datasize);
intense = zeros(half,datasize);
for i = (half:((numf+1)/numScans)-1)
   for j = 0:numScans-1
    fileNum=fileNumber(i*numScans+j);
    filebase = [filename fileNum];
    fileID=fopen([filebase '.txt']);
    C=textscan(fileID, '%7f %8f', 'Delimiter', ' ', 'HeaderLines', 17);
    fclose(fileID);
    waveRaw(j+(numScans*(i-half))+1,:)= cell2mat((C(1))');
    intenseRaw(j+(numScans*(i-half))+1,:)= cell2mat((C(2))');
   end
end
for i = (half:((numf+1)/numScans)-1)
    for k = (1:datasize)
        wave((i-half)+1,k) = mean(waveRaw((((i-half)*numScans)+1:(((i-half)+1)*numScans)),k));
        intense((i-half)+1,k) = mean(intenseRaw((((i-half)*numScans)+1:(((i-half)+1)*numScans)),k));
    end
end
for i = (half:((numf+1)/numScans)-1)
   for j = (1:datasize)
        X1(j,(i-half)-numi+1) = wave((i-half)-numi+1,j);
        Z1(j,(i-half)-numi+1) = intense((i-half)-numi+1,j)/integrationTime;
    end
end
mesh(X1,Y,fliplr(Z1));
[minX,maxX,minY,maxY,minZ,maxZ] = setAxes(X1,Y,Z1);
xlim([minX maxX]);
ylim([minY maxY]);
zlim([minZ maxZ]);
view(-78,18);
% view(-6,12);
xlabel('Wavelength (nm)');
ylabel('Magnetic Field (Gauss)');
zlabel('Intensity');
title(['3D Plot of Spectroscopy Data (Decreasing B) at '  'Port ' num2str(port) ' ' num2str(power,'%.1f') 'kW ' num2str(flow) 'sccm ' num2str(pressure,'%.1f') 'mT']);
%saveas(gcf,['3D Plot of Spectroscopy Data (Decreasing B) at paramaters' paramaters 'view2.jpg']);
%saveas(gcf,['3D Plot of Spectroscopy Data (Increasing B) at paramaters' paramaters 'view1.jpg']);
