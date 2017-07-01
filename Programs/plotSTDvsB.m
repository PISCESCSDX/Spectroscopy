function plotSTDvsB(port,power,flow,pressure,numi,numf,Ii,If,numScans,pickWav)
% Creates a graph comparing standard deviations at different magnetic
% fields
% 
% %clearing figures
% close all;

%Find index of chosen Wavelength
[index] = findIndexOfWavelength(port,power,flow,pressure,numf,pickWav);

%Create B array
B = findB(numi,numf,Ii,If,numScans);

%Create STD array
intensitiesUp = zeros(length(B),numScans);
for i = 1:length(B);
    for j = 1:numScans
        fileID=fopen(['PORT_' num2str(port) '\' num2str(power,'%.1f') 'kW_' num2str(flow) 'sccm_' num2str(pressure,'%.1f') 'mT_' fileNumber(numScans*(i-1)+j-1) '.txt']);
        C=textscan(fileID, '%7f %8f', 'Delimiter', ' ', 'HeaderLines', 17);
        fclose(fileID);
        Itemp = cell2mat((C(2))');
        intensitiesUp(i,j) = Itemp(index);
    end
end
stdUp = zeros(length(B),1);

for i = 1:length(B)
    stdUp(i) = std(intensitiesUp(i,:))/mean(intensitiesUp(i,:));
end

intensitiesDown = zeros(length(B),numScans);
for i = 1:length(B);
    for j = 1:numScans
        fileID=fopen(['PORT_' num2str(port) '\' num2str(power,'%.1f') 'kW_' num2str(flow) 'sccm_' num2str(pressure,'%.1f') 'mT_' fileNumber(numScans*(i-1)+j-1) '.txt']);
        C=textscan(fileID, '%7f %8f', 'Delimiter', ' ', 'HeaderLines', 17);
        fclose(fileID);
        Itemp = cell2mat((C(2))');
        intensitiesDown(i,j) = Itemp(index);
    end
end
stdDown = zeros(length(B),1);

for i = 1:length(B)
    stdDown(i) = std(intensitiesDown(i,:))/mean(intensitiesDown(i,:));
end

%[BCriticalUp, ~, BCriticalDown] = findBCritical(port,power,flow,pressure,numi,numf, Ii, If,pickWav,numScans);

figure(1);
plot(B,stdUp);
hold on;
%plot([BCriticalUp BCriticalUp],[min(stdUp) max(stdUp)]);
xlabel('B');
ylabel('Standard Deviation of Intensity');
title(['Intensity Standard Deviation at Wavelength = ' int2str(pickWav) ' (Way Up)']);
%annotation('textbox',[0.2 0.5 0.4 0.4], 'String','Green: B critical','FitBoxToText','on')

figure(2);
plot(B,stdDown);
hold on;
%plot([BCriticalDown BCriticalDown],[min(stdDown) max(stdDown)]);
xlabel('B');
ylabel('Standard Deviation of Intensity');
title(['Intensity Standard Deviation at Wavelength = ' int2str(pickWav) ' (Way Down)']);
%annotation('textbox',[0.2 0.5 0.4 0.4], 'String','Green: B critical','FitBoxToText','on')
end

