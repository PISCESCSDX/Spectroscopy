function plotComparablePowersSTD(port,powers,flow,pressure,numi,Ii,numScans,pickWav)
% Creates a standard deviation vs B line for each power
close all;
output = cell(length(powers),1);
for i = 1:length(powers)
    power = powers(i);
    [numf] = findFileNumbers(port,power,flow,pressure,numi);
    [If] = findI(numi,numf,Ii,numScans);
    plotSTDvsB(port,power,flow,pressure,numi,numf,Ii,If,numScans,pickWav);
    output(i,1) = cellstr([num2str(powers(i)) 'kW']);
end
figure(1)

legend(output);

figure(2)
legend(output);
end