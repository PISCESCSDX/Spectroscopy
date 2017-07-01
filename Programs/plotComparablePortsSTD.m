function plotComparablePortsSTD(ports,power,flow,pressure,numi,numf,Ii,If,numScans,pickWav)
% Creates a standard deviation vs B line for each port
close all;
output = cell(length(ports),1);
for port = 1:length(ports)
    plotSTDvsB(port,power,flow,pressure,numi,numf,Ii,If,numScans,pickWav);
    output(port,1) = cellstr(['Port ' num2str(ports(port)) ]);
end
figure(1)

legend(output);

figure(2)
legend(output);
end

