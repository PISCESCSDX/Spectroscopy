function spectroplot(port,power,flow,pressure,fileNum)
% Converts a data file into a wavelength vs
% intensity plot and saves the file

   [Wav,Int] = readSpectroscopyFile(port,power,flow,pressure,fileNum);
   plot(Wav,Int);
   xlabel('Wavelength (nm)');
   ylabel('Intensity ()');
   title(['PORT_' num2str(port) ' ' num2str(power,'%.1f') 'kW_' num2str(flow) 'sccm_' num2str(pressure,'%.1f') 'mT_']);
   %filename = [filebase '.fig'];
   %saveas(gcf, filename);
end

