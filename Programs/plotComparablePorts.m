function plotComparablePorts(ports,power,flow,pressure,numi,Ii,wavelength,numScans)
% Makes graphs of intensity vs B for different ports, all on one axis

%clearing figures
close all;

%Plotting
output = cell(length(ports),1);
for port = 1:length(ports)
    [numf] = findFileNumbers(ports(port),power,flow,pressure,numi);
    [If] = findI(numi,numf,Ii,numScans);
    [B] = findB(numi,numf,Ii,If,numScans);
    [index,titlehold] = findIndexOfWavelength(ports(port),power,flow,pressure,numf,wavelength);
    [Upraw,Downraw] = readSpectroscopyDataFixedWavelength(ports(port),power,flow,pressure,numi,numf,index);
    [Upraw,Downraw] = normalizeIntensity(ports(port),power,flow,pressure,numf,Upraw,Downraw);
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
    output(port,1) = cellstr(['Port ' num2str(ports(port)) ]);
end
figure(1)

legend(output);

figure(2)
legend(output);

end

