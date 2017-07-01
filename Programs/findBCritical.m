function [BCriticalUp, deltadUp, BCriticalDown, deltadDown] = findBCritical(port,power,flow,pressure,numi,numf, Ii, If,wavelength,numScans)

%Gathering data
[B] = findB(numi,numf,Ii,If,numScans);
[index] = findIndexOfWavelength(port,power,flow,pressure,numf,wavelength);
[Upraw,Downraw] = readSpectroscopyDataFixedWavelength(port,power,flow,pressure,numi,numf,index);
[Upraw,Downraw] = normalizeIntensity(port,power,flow,pressure,numf,Upraw,Downraw);

Uptemp = zeros(numScans,length(B));
for j = 1:numScans
    for i = 1:length(B)
       Uptemp(j,i) = Upraw((i-1)*100 + j);
    end
end
Downtemp = zeros(numScans,length(B));
for j = 1:numScans
    for i = 1:length(B)
       Downtemp(j,i) = Downraw((i-1)*100 + j);
    end
end
Upmean = mean(Uptemp);
Downmean = mean(Downtemp);


% Calculating dI/dB
B1 = dprep(B);
B2=dprep(fliplr(B));
dup=diff(Upmean)./diff(B);
ddown=diff(Downmean)./diff(fliplr(B));
ddup = diff(dup);
dddown = diff(ddown);


deltadUp = max(diff(dup));
BCriticalUp=B1(Nearest(deltadUp, ddup));
deltadDown = max(diff(ddown));
BCriticalDown=B2(Nearest(deltadDown, dddown));

disp(['Max change in derivative up = ' num2str(deltadUp)])
disp(['BCriticalUp = ' num2str(BCriticalUp)])
disp(['Max change in derivative down = ' num2str(deltadDown)])
disp(['BCriticalDown = ' num2str(BCriticalDown)])


end

