
names_Ir=char('Ir_191.txt','Ir_193.txt');
abundancy_Ir=[37.3;62.7]; % (in same order as the file names)
density_Ir=22.56;
atomic_molarmass_Ir=192.217;
thickness_Ir=0.04;
[x,y,yy]=readdata(names_Ir,abundancy_Ir,density_Ir,atomic_molarmass_Ir,thickness_Ir);
