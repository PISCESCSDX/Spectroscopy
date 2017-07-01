function plotComparablePressuresSTD(port,power,flow,pressures,numi,Ii,numScans,pickWav)
% Creates a standard deviation vs B line for each pressure
close all;
output = cell(length(pressures),1);
for i = 1:length(pressures)
    pressure = pressures(i);
    [numf] = findFileNumbers(port,power,flow,pressure,numi);
    [If] = findI(numi,numf,Ii,numScans);
    plotSTDvsB(port,power,flow,pressure,numi,numf,Ii,If,numScans,pickWav);
    output(i,1) = cellstr([num2str(pressures(i)) 'mT']);
end 
figure(1)

legend(output);

figure(2)
legend(output);
end

