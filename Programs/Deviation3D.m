function Deviation3D(port,power,flow,pressure,numi,numf,Ii,If,wavelength,numScans)

%clearing figures
close all;
%Gathering data
[B] = findB(numi,numf,Ii,If,numScans);
[index] = findIndexOfWavelength(port,power,flow,pressure,numf,wavelength);
[Upraw,Downraw] = readSpectroscopyDataFixedWavelength(port,power,flow,pressure,numi,numf,index);
[Upraw,Downraw] = normalizeIntensity(port,power,flow,pressure,numf,Upraw,Downraw);

%Plottig the way up
Uptemp = zeros(1);
for i = 1:numScans
    for j = 1:length(B)
       Uptemp(j,i) = Upraw((j-1)*100 + i);
    end
end
Upscans = zeros(length(B),numScans);
for k = 1:length(B)
    for i = 1:numScans
        for j = 1:i
            Upscans(k,i) = Upscans(k,i) + Uptemp(k,j);
        end
        Upscans(k,i) = Upscans(k,i)/i;
    end
end
Updeviation = zeros(length(B),numScans);
for j = 1:length(B)
   for i = 1:numScans
      Updeviation(j,i) = abs(Upscans(j,i) - Upscans(j,numScans)); 
   end
end

X = zeros(numScans,length(B));
Y = zeros(numScans,length(B));
Z = zeros(numScans,length(B));
for i = 1:numScans
   for j = 1:length(B)
       X(i,j) = i;
       Y(i,j) = B(j);
       Z(i,j) = Updeviation(j,i);
   end   
end
mesh(X,Y,Z);
[minX,maxX,minY,maxY,minZ,maxZ] = setAxes(X,Y,Z);
xlim([minX maxX]);
ylim([minY maxY]);
zlim([minZ maxZ]);
xlabel('Number of scans between shifts in B');
ylabel('Magnetic Field (Gauss)');
zlabel('Deviation of Intensity (UP)');

%Way Down
Downtemp = zeros(1);
for i = 1:numScans
    for j = 1:length(B)
       Downtemp(j,i) = Downraw((j-1)*numScans + i);
    end
end
Downscans = zeros(length(B),numScans);
for k = 1:length(B)
    for i = 1:numScans
        for j = 1:i
            Downscans(k,i) = Downscans(k,i) + Downtemp(k,j);
        end
        Downscans(k,i) = Downscans(k,i)/i;
    end
end
Downdeviation = zeros(length(B),numScans);
for j = 1:length(B)
   for i = 1:numScans
      Downdeviation(j,i) = abs(Downscans(j,i) - Downscans(j,numScans)); 
   end
end

X1 = zeros(numScans,length(B));
Y1 = zeros(numScans,length(B));
Z1 = zeros(numScans,length(B));
for i = 1:numScans
   for j = 1:length(B)
       X1(i,j) = i;
       Y1(i,j) = B(j);
       Z1(i,j) = Downdeviation(j,i);
   end   
end
figure()
mesh(X1,Y1,Z1);
[minX1,maxX1,minY1,maxY1,minZ1,maxZ1] = setAxes(X1,Y1,Z1);
xlim([minX1 maxX1]);
ylim([minY1 maxY1]);
zlim([minZ1 maxZ1]);
xlabel('Number of scans between shifts in B');
ylabel('Magnetic Field (Gauss)');
zlabel('Deviation of Intensity (Down)');