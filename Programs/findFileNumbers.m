function [numf] = findFileNumbers(port,power,flow,pressure,numi)
%Finds initial and final file number for a given filebase.

filebase = ['PORT_' num2str(port) '\' num2str(power,'%.1f') 'kW_' num2str(flow) 'sccm_' num2str(pressure,'%.1f') 'mT_'];
i = numi;
fileNum = fileNumber(i);
while exist([filebase num2str(fileNum) '.txt'],'file') >1
    i = i + 1;
    fileNum = fileNumber(i);
end
numf = i-1;
end
