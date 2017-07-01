function [minX,maxX,minY,maxY,minZ,maxZ] = setAxes(X,Y,Z)
%Finds Axes for the 3D spectroplot function
largemaxX = max(X);
maxX = max(largemaxX);
largeminX = min(X);
minX = min(largeminX);
largemaxY = max(Y);
maxY = max(largemaxY);
largeminY = min(Y);
minY = min(largeminY);
largemaxZ = max(Z);
maxZ = max(largemaxZ);
largeminZ = min(Z);
minZ = min(largeminZ);

end

