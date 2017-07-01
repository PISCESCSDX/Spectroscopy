function [If] = findI(numi,numf,Ii,numScans)
%Finds the maximum current for a given B-field scan

dI = 10*(((numf+1-numi)/(2*numScans))-1);
If = Ii + dI;
end