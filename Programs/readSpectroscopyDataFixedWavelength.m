function [Upraw,Downraw,tester,half] = readSpectroscopyDataFixedWavelength(port,power,flow,pressure,numi,index)
%Taking in Data from files (way up)
numf = findFileNumbers(port,power,flow,pressure,numi);
half=floor((numf - numi)/2);
Upraw=zeros(1,half);
Downraw = zeros(1,half);
tester=half;
for i=numi:(numi + half)
   fileNum=fileNumber(i);
   if ispc
       filebase = ['PORT_' num2str(port) '\' num2str(power,'%.1f') 'kW_' num2str(flow) 'sccm_' num2str(pressure,'%.1f') 'mT_' fileNum];
   else
       filebase = ['PORT_' num2str(port) '/' num2str(power,'%.1f') 'kW_' num2str(flow) 'sccm_' num2str(pressure,'%.1f') 'mT_' fileNum];
   end
   fileID=fopen([filebase '.txt']);
   C=textscan(fileID, '%7f %8f', 'Delimiter', ' ', 'HeaderLines', 17);
   fclose(fileID);
   Hold=cell2mat((C(2))');
   mini=Hold(index);
   Upraw(i-numi+1)=mini;
 end

%Take in Data (way down)
if mod(numf+numi, 2)==1
    half=half+1;
end

for i=(numi + half):numf
   fileNum=fileNumber(i);
   if ispc
       filebase = ['PORT_' num2str(port) '\' num2str(power,'%.1f') 'kW_' num2str(flow) 'sccm_' num2str(pressure,'%.1f') 'mT_' fileNum];
   else
       filebase = ['PORT_' num2str(port) '/' num2str(power,'%.1f') 'kW_' num2str(flow) 'sccm_' num2str(pressure,'%.1f') 'mT_' fileNum];
   end
   fileID=fopen([filebase '.txt']);
   C=textscan(fileID, '%7f %8f', 'Delimiter', ' ', 'HeaderLines', 17);
   fclose(fileID);
   Hold=cell2mat((C(2))');
   mini=Hold(index);
   Downraw(i-numi-half+1)=mini;
end

end

