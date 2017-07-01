function [Upraw,Downraw] = normalizeIntensity(port,power,flow,pressure,numf,Upraw,Downraw)
% Normalize intensity of light

filenumber=fileNumber(numf);
fileIDt=fopen(['PORT_' num2str(port) '\' num2str(power,'%.1f') 'kW_' num2str(flow) 'sccm_' num2str(pressure,'%.1f') 'mT_' filenumber '.txt']);
temp = cell2mat(textscan(fileIDt, '%10f', 'Delimiter', 'Integration Time (usec): ', 'HeaderLines', 8));
integrationTime = temp(26)/1000000;
Upraw = Upraw./integrationTime;
Downraw = Downraw./integrationTime;
end

