function [index,titlehold] = findIndexOfWavelength(port,power,flow,pressure,numf,wavelength)

%Finding the index of the wavelength
filenumber=fileNumber(numf);
fileIDt=fopen(['PORT_' num2str(port) '\' num2str(power,'%.1f') 'kW_' num2str(flow) 'sccm_' num2str(pressure,'%.1f') 'mT_' filenumber '.txt']);
Ct=textscan(fileIDt, '%7f %8f', 'Delimiter', ' ', 'HeaderLines', 17);
fclose(fileIDt);
ref=cell2mat((Ct(1))');
index=Nearest(wavelength, ref);
titlehold=num2str(wavelength);

end

