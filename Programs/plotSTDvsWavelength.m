function plotSTDvsWavelength(port,power,flow,pressure,numi,numf,Ii,If,pickB,numScans,dwav)
% Makes a graph of Standard Deviation for various wavelengths of light at a
% fixed magnetic field.

%clearing figures
close all;

%Creating an array of wavelengths
filename = ['PORT_' num2str(port) '\' num2str(power,'%.1f') 'kW_' num2str(flow) 'sccm_' num2str(pressure,'%.1f') 'mT_'];
fileID=fopen([filename '00000' '.txt']);
C=textscan(fileID, '%7f %8f', 'Delimiter', ' ', 'HeaderLines', 17);
fclose(fileID);
wavtemp=cell2mat((C(1))');

% Making sure length(wavtemp) is divisible by dwav
while(mod(length(wavtemp),dwav) ~= 0 && dwav >= 1)
   dwav = dwav-1;
end

%Cuts down the wavelength array to make the graph more readable
wav = zeros(length(wavtemp)/dwav,1);
for i=1:length(wavtemp)/dwav
    wav(i) = wavtemp(dwav*i);
end
%Filling standard deviation arrays (Up)
B = findB(numi,numf,Ii,If,numScans);
indexUp = Nearest(pickB,B);
intensitiesUp = zeros(length(wav),numScans);
intensitiestempUp = zeros(length(wavtemp),numScans);
for i = 1:numScans
        fileID=fopen([filename fileNumber(numScans*(indexUp-1)+i-1) '.txt']);
        C=textscan(fileID, '%7f %8f', 'Delimiter', ' ', 'HeaderLines', 17);
        fclose(fileID);
        intensitiestempUp(:,i) = cell2mat((C(2))');
        for j = 1:length(wav)
            intensitiesUp(j,i) = intensitiestempUp(j*dwav,i);
        end
end
stdUp = zeros(length(wav),1);
for i = 1:length(wav)
    stdUp(i) = std(intensitiesUp(i,:))/mean(intensitiesUp(i,:));
end


%Filling standard deviation arrays (Down)
indexDown = 2*length(B)+1-indexUp;
intensitiesDown = zeros(length(wav),numScans);
intensitiestempDown = zeros(length(wavtemp),numScans);
for i = 1:numScans
        fileID=fopen([filename fileNumber(100*(indexDown-1)+i-1) '.txt']);
        C=textscan(fileID, '%7f %8f', 'Delimiter', ' ', 'HeaderLines', 17);
        fclose(fileID);
        intensitiestempDown(:,i) = cell2mat((C(2))');
        for j = 1:length(wav)
            intensitiesDown(j,i) = intensitiestempDown(j*dwav,i);
        end
end
stdDown = zeros(length(wav),1);
for i = 1:length(wav)
    stdDown(i) = std(intensitiesDown(i,:))/mean(intensitiesDown(i,:));
end

    
plot(wav,stdUp,'bo');
xlabel('Wavelength');
ylabel('Percent Standard Deviation of Intensity');
title(['Intensity Percent Standard Deviation at B = ' int2str(pickB) ' (Way Up)']);
figure();
plot(wav,stdDown,'rx');
xlabel('Wavelength');
ylabel('Percent Standard Deviation of Intensity');
title(['Intensity Percent Standard Deviation at B = ' int2str(pickB) ' (Way Down)']);
figure();
plot(wav,stdUp,'b');
xlabel('Wavelength');
ylabel('Percent Standard Deviation of Intensity');
title(['Intensity Percent Standard Deviation at B = ' int2str(pickB) ' (Way Up)']);
figure();
plot(wav,stdDown,'r');
xlabel('Wavelength');
ylabel('Percent Standard Deviation of Intensity');
title(['Intensity Percent Standard Deviation at B = ' int2str(pickB) ' (Way Down)']);

end

%Plots individual wavelengths, put inside the function to use
% [stdUp(1),stdDown(1)] = scatterIntensity(filename,numi,numf,Ii,If,wavelength(1),pickB,numScans);
% [stdUp(2),stdDown(2)] = scatterIntensity(filename,numi,numf,Ii,If,wavelength(2),pickB,numScans);
% [stdUp(3),stdDown(3)] = scatterIntensity(filename,numi,numf,Ii,If,wavelength(3),pickB,numScans);
% [stdUp(4),stdDown(4)] = scatterIntensity(filename,numi,numf,Ii,If,wavelength(4),pickB,numScans);
% [stdUp(5),stdDown(5)] = scatterIntensity(filename,numi,numf,Ii,If,wavelength(5),pickB,numScans);
% 
% [stdUp(6),stdDown(6)] = scatterIntensity(filename,numi,numf,Ii,If,wavelength(6),pickB,numScans);
% [stdUp(7),stdDown(7)] = scatterIntensity(filename,numi,numf,Ii,If,wavelength(7),pickB,numScans);
% [stdUp(8),stdDown(8)] = scatterIntensity(filename,numi,numf,Ii,If,wavelength(8),pickB,numScans);
% [stdUp(9),stdDown(9)] = scatterIntensity(filename,numi,numf,Ii,If,wavelength(9),pickB,numScans);
% [stdUp(10),stdDown(10)] = scatterIntensity(filename,numi,numf,Ii,If,wavelength(10),pickB,numScans);
% 
% plot(wavelength,stdUp,'o');
% xlabel('Wavelength');
% ylabel('Standard Deviation of Intensity');
% title(['Intensity Standard Deviation at B = ' int2str(pickB) ' (Way Up)']);
% figure();
% plot(wavelength,stdDown,'x');
% xlabel('Wavelength');
% ylabel('Standard Deviation of Intensity');
% title(['Intensity Standard Deviation at B = ' int2str(pickB) ' (Way Down)']);