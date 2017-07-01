function [B, bmin, bmax] = findB(numi,numf,Ii,If,numScans)
% This function converts file numbers to magnetic field values in order to
% ready spectroscopy data for intensity vs magnetic field graphs
mid = floor((numf - numi)/(2*numScans));
I = Ii:10:If;
B = (3.015.*I + 10);
bmin = B(1,1);
bmax = B(1,mid);
end

