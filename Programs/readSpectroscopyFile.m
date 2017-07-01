function [Wav,Int] = readSpectroscopyFile(port,power,flow,pressure,fileNum)
% Reads a single spectroscopy file
if ispc   
    fileID=fopen(['PORT_' num2str(port) '\' num2str(power,'%.1f') 'kW_' num2str(flow) 'sccm_' num2str(pressure,'%.1f') 'mT_' fileNumber(fileNum) '.txt']);
else
    fileID=fopen(['PORT_' num2str(port) '/' num2str(power,'%.1f') 'kW_' num2str(flow) 'sccm_' num2str(pressure,'%.1f') 'mT_' fileNumber(fileNum) '.txt']);
end
C=textscan(fileID, '%7f %8f', 'Delimiter', ' ', 'HeaderLines', 17);
fclose(fileID);
Wav=cell2mat((C(1))');
Int=cell2mat((C(2))');
end

