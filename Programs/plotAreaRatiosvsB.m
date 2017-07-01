function plotAreaRatiosvsB(port,power,flow,pressure,numi,Ii,numScans)
% Plots the ratio of ion and neutral area to B (Ions/Neutrals)
close all;
[numf] = findFileNumbers(port,power,flow,pressure,numi);
[If] = findI(numi,numf,Ii,numScans);
[B] = findB(numi,numf,Ii,If,numScans);
[~,Int] = readSpectroscopyFile(port,power,flow,pressure,0);
Upraw = zeros(length(B),length(Int));
Downraw = zeros(length(B),length(Int));
for j = 1:2*length(B)
    for i = 0:numScans-1
        [~,Int] = readSpectroscopyFile(port,power,flow,pressure,(j-1)*numScans+i);
        if ((j-1)*numScans+i < (numf+1)/2)
            Upraw(j,:) = Int;
        else
            Downraw(j-length(B),:) = Int;
        end
    end
end
[Upraw,Downraw] = normalizeIntensity(port,power,flow,pressure,numf,Upraw,Downraw);
UpAreaI = zeros(length(B),1);
DownAreaI = zeros(length(B),1);
UpAreaN = zeros(length(B),1);
DownAreaN = zeros(length(B),1);
for i = 1:length(B)
    UpAreaI(i) = trapArea(Upraw(i,:),1,1339,.215);
    DownAreaI(i) = trapArea(Downraw(i,:),1,1339,.215);
    % The max wavelength for ions is 620, which corresponds to index 1339
    % in the intensity array
    UpAreaN(i) = trapArea(Upraw(i,:),1340,length(Int),.215);
    DownAreaN(i) = trapArea(Downraw(i,:),1340,length(Int),.215);
end
%Ions
figure();
plot(B,UpAreaI);
hold on;
plot(fliplr(B),DownAreaI);
xlabel('B');
ylabel('Integral of Intensity with Respect to Wavelength');
title(['Ratio of the Integral of Intensity with Respect to Wavelength vs B (Ions)']);
legend('Way Up','Way Down')

%Neutrals
figure();
plot(B,UpAreaN);
hold on;
plot(fliplr(B),DownAreaN);
xlabel('B');
ylabel('Integral of Intensity with Respect to Wavelength');
title(['Ratio of the Integral of Intensity with Respect to Wavelength vs B (Neutrals)']);
legend('Way Up','Way Down')


%Ions/Neutrals Ratio:
UpAreaRatio = UpAreaI./UpAreaN;
DownAreaRatio = DownAreaI./UpAreaN;
figure();
plot(B,UpAreaRatio);
hold on;
plot(fliplr(B),DownAreaRatio);
xlabel('B');
ylabel('Integral of Intensity with Respect to Wavelength');
title(['Ratio of the Integral of Intensity with Respect to Wavelength vs B (Ions/Neutrals)']);
legend('Way Up','Way Down')
end

