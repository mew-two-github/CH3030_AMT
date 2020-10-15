xcoords = [0.60,0.70,0.825];
ycoords = [0.40,0.30,0.175];
ycoords2 = [0.275,0.20,0.12];
xcoords2 = 1-ycoords2-[0.70 0.80 0.875];

E1  = F*(yF-yRN)/(yE1-yRN);
E = ((yE1-ycoords2)*E1-(yF-ycoords2)*F)./(ycoords-ycoords2);
R = ((yE1-ycoords)*E1-(yF-ycoords)*F)./(ycoords-ycoords2);