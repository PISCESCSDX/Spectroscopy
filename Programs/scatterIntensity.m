function [stdUp,stdDown] = scatterIntensity(port,power,flow,pressure,numi,numf,Ii,If,wavelength,pickB,numScans)
%Plots the standard deviation of intensity data for different scan numbers
%at a fixed wavelength and B

%clearing figures
close all;

%Gathering Data
[B] = findB(numi,numf,Ii,If,numScans);
[index,titlehold] = findIndexOfWavelength(port,power,flow,pressure,numf,wavelength);
[Upraw,Downraw] = readSpectroscopyDataFixedWavelength(port,power,flow,pressure,numi,numf,index);
[Upraw,Downraw] = normalizeIntensity(port,power,flow,pressure,numf,Upraw,Downraw);

%Way Up
Uptemp = zeros(1);
scanNumber = zeros(1,numScans);
for i = 1:numScans
    for j = 1:length(B)
       Uptemp(j,i) = Upraw((j-1)*numScans + i);
       scanNumber(i) = i;
    end
end
index = Nearest(pickB,B);
plot(scanNumber,Uptemp(index,:),'*')
hold on;
Upmean = zeros(1);
for i = 1:numScans
   Upmean(i) = mean(Uptemp(index,:)); 
end
stdUp = std(Uptemp(index,:))/Upmean(1);
plot(scanNumber,Upmean)
xlabel('Scan Number');
ylabel('Intensity (10^5)');
title(['Intensity Scatter at Wavelength=' titlehold ' and B = ' int2str(pickB) ' (Way Up)']);
annotation('textbox',[0.2 0.5 0.4 0.4], 'String',['Percent Standard Deviation = ' num2str(stdUp)],'FitBoxToText','on')

%Way Down
figure()
Downtemp = zeros(1);
for i = 1:numScans
    for j = 1:length(B)
       Downtemp(j,i) = Downraw((j-1)*numScans + i);
    end
end
index = Nearest(pickB,B);
plot(scanNumber,Downtemp(index,:),'*')
hold on;
Downmean = zeros(1);
for i = 1:numScans
   Downmean(i) = mean(Downtemp(index,:)); 
end
stdDown = std(Downtemp(index,:))/Downmean(1);
plot(scanNumber,Downmean)
xlabel('Scan Number');
ylabel('Intensity (10^5)');
title(['Intensity Scatter at Wavelength=' titlehold ' and B = ' int2str(pickB) ' (Way Down)']);
annotation('textbox',[0.2 0.5 0.4 0.4], 'String',['Percent Standard Deviation = ' num2str(stdDown)],'FitBoxToText','on')


end

