function  [En_av,sigma_av,Transmission_av] = readdata(names,abundancy,density,atomicmolarmass,thickness)

%Function  : loads neutron cross section files from the ENDF database 
%            (how to download data shown in the example),
%            averages them according to abundancy
%            converts to tranmsission data and plots both cross section
%            and transmission. To be used to calculate the transmission of
%            a neutron absorption filter

%Input : - names -> name of downloaded files in format : names=char('file1','file2',..);
%        - abundancy -> vector of abundancy of each isotope : abundancy=[isotope1;isotope2;...];
%        - density in g/cm^3, atomic molar mass in g/mol-> caracteristics of the element,
%        - thickness -> thickness of the filter in cm

%Output : - En_av : Energy vector in meV
%         - sigma_av : neutron cross section for the filter, in barns
%         - Transmission_av : Transmission data for the filter

%Example with Iridium (2 isotopes Ir_191 and Ir_193, from EDNF website) :

% step 1 : retrieve data file from http://www.nndc.bnl.gov/exfor/endf00.jsp
%          unselect all databases except :  ENDF/B-VII.1  (USA, 2011)
%          use in the search fields : element_name* (ex: Ir*)
%                                     n,tot
%                                     sig
%          select the first isotope and click plot
%          save the file "plotted data" on the right of the screen
%          repeat the last 2 steps for the other isotope

% step 2 : use the read data function in matalb (readColData must also be accessible by matlab): 
%         names_Ir=char('Ir_191.txt','Ir_193.txt');
%         abundancy_Ir=[37.3;62.7]; (in same order as the file names)
%         density_Ir=22.56;
%         atomic_molarmass_Ir=192.217;
%         thickness_Ir=0.04;
%         [x,y,yy]=readdata(names_Ir,abundancy_Ir,density_Ir,atomic_molarmass_Ir,thickness_Ir);
%
% Diane Lançon
% octobre 2012

for i=1:size(abundancy)
 
    
[labels,En,sigma]=readColData(names(i,:),2,11,0);

evalc([ 'En' num2str(i) ' = En;' ]);
evalc([ 'sigma' num2str(i) ' = sigma;' ]);
[taille(i),dummy]=size(En);
end



[value,ind]=max(abundancy);


sigma_av=zeros(taille(ind),1);
En_av=zeros(taille(ind),1);

for i=1:size(abundancy)
  evalc([ ' sigmaa =' 'sigma' num2str(i)]);
  evalc([ ' Enn =' 'En' num2str(i) ]);
  evalc([ ' En_ref =' 'En' num2str(ind) ]);
  sigma_interp=interp1q(Enn,sigmaa,En_ref);
  sigma_av=sigma_av+(abundancy(i)/100)*sigma_interp;
    En_av=En_ref;
    
end

% passer de MeV à meV
En_av=En_av*10^9;

figure
subplot(1,2,1)
loglog(En_av,sigma_av);
axis([1e-2 1e9 0 inf]);
xLimits = [1e-2 1e9];
set(gca,'XTick',[1e-2 1e-1 1e0 1e1 1e2 1e3 1e4 1e5 1e6 1e7 1e8 1e9]);
xlabel(' Energy (meV)');
ylabel(' Cross section (barns)');

Na=6.022141*10^23;

mu=(density*Na/atomicmolarmass)*10^-24.*sigma_av;

Transmission_av=exp(-mu*thickness);

subplot(1,2,2)
semilogx(En_av,Transmission_av)
axis([1e-2 1e9 0 1]); 
xLimits = [1e-2 1e9];
yLimits = [0 1];
set(gca,'XTick',[1e-2 1e-1 1e0 1e1 1e2 1e3 1e4 1e5 1e6 1e7 1e8 1e9]);
xlabel('Energy (meV)');
ylabel('Transmission');


end



