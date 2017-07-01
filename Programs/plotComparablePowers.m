function plotComparablePowers(port,powers,flow,pressure,numi,Ii,wavelength,numScans)
% Makes graphs of intensity vs B for different powers, all on one axis

%clearing figures
close all;

%Plotting
output = cell(length(powers),1);
for power = 1:length(powers)
    [numf] = findFileNumbers(port,powers(power),flow,pressure,numi);
    [If] = findI(numi,numf,Ii,numScans);
    [B] = findB(numi,numf,Ii,If,numScans);
    [index,titlehold] = findIndexOfWavelength(port,powers(power),flow,pressure,numf,wavelength);
    [Upraw,Downraw] = readSpectroscopyDataFixedWavelength(port,powers(power),flow,pressure,numi,numf,index);
    [Upraw,Downraw] = normalizeIntensity(port,powers(power),flow,pressure,numf,Upraw,Downraw);
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
    output(power,1) = cellstr([num2str(powers(power)) ' kW' ]);
end
figure(1)

legend(output);

figure(2)
legend(output);

end

