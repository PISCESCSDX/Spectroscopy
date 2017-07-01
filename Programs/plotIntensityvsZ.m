function plotIntensityvsZ(ports,power,flow,pressure,numi,Ii,wavelength,pickB,numScans)
% Creates a plot comparing intensity with z at a fixed wavlength and
% magnetic field
Up = zeros(length(ports),1);
Down = zeros(length(ports),1);
for port = 1:length(ports)
    [numf] = findFileNumbers(ports(1),power,flow,pressure,numi);
    [If] = findI(numi,numf,Ii,numScans);
    [B] = findB(numi,numf,Ii,If,numScans);
    i = Nearest(pickB,B);
    [index,titlehold] = findIndexOfWavelength(ports(1),power,flow,pressure,numf,wavelength);
    [Upraw,Downraw] = readSpectroscopyDataFixedWavelength(ports(port),power,flow,pressure,numi,numf,index);
    [Upraw,Downraw] = normalizeIntensity(ports(port),power,flow,pressure,numf,Upraw,Downraw);
Uptemp = zeros(numScans,length(B));    
    for j = 1:numScans
        for i = 1:length(B)
        Uptemp(j,i) = Upraw((i-1)*numScans + j);
        end
    end
    Downtemp = zeros(numScans,length(B));
    for j = 1:numScans
        for i = 1:length(B)
           Downtemp(j,i) = Downraw((i-1)*numScans + j);
        end
    end
    
    Up(port) = mean(Uptemp(:,i));
    Down(port) = mean(Downtemp(:,i));
end

figure();
plot(ports,Up);
hold on;
plot(ports,Down);
xlim([0,3]);
xlabel('Distance Z-Wise (Port #)');
ylabel('Intensity');
title(['Intensity at Wavelength=' titlehold ' and B = ' num2str(pickB)]);
legend('Way Up','Way Down')
end

