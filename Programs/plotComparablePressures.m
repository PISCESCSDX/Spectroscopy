function plotComparablePressures(port,power,flow,pressures,numi,Ii,wavelength,numScans)
% Makes graphs of intensity vs B for different pressures, all on one axis

%clearing figures
close all;

%Plotting
output = cell(length(pressures),1);
for pressure = 1:length(pressures)
    [numf] = findFileNumbers(port,power,flow,pressures(pressure),numi);
    [If] = findI(numi,numf,Ii,numScans);
    [B] = findB(numi,numf,Ii,If,numScans);
    [index,titlehold] = findIndexOfWavelength(port,power,flow,pressures(pressure),numf,wavelength);
    [Upraw,Downraw] = readSpectroscopyDataFixedWavelength(port,power,flow,pressures(pressure),numi,numf,index);
    [Upraw,Downraw] = normalizeIntensity(port,power,flow,pressures(pressure),numf,Upraw,Downraw);
    Uptemp = zeros(numScans,length(B));
    for j = 1:numScans
        for i = 1:length(B)
            Uptemp(j,i) = Upraw((i-1)*numScans + j);
        end
    end
    B1=fliplr(B);
    Downtemp = zeros(numScans,length(B));
    for j = 1:numScans
        for i = 1:length(B)
            Downtemp(j,i) = Downraw((i-1)*numScans + j);
        end
    end
    Upraw = mean(Uptemp);
    Downraw = mean(Downtemp);
    figure(1);
    plot(B,Upraw);
    hold on;
    xlabel('Magnetic Field (Gauss)');
    ylabel('Intensity');
    title(['Intensity at Wavelength=' titlehold ' (Way Up)' ]);
    figure(2);
    plot(B1,Downraw);
    hold on;
    xlabel('Magnetic Field (Gauss)');
    ylabel('Intensity');
    title(['Intensity at Wavelength=' titlehold ' (Way Down)' ]);
    output(pressure,1) = cellstr([num2str(pressures(pressure)) ' mT' ]);
end
figure(1)

legend(output);

figure(2)
legend(output);

end

