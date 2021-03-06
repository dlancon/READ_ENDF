READ_ENDF
=========

Matlab routines
To be used to calculate the transmission of a neutron absorption filter : 
loads neutron cross section files from the ENDF database  (how to download data shown in the example), 
averages them according to abundancy and converts to tranmsission data and plots both cross section and transmission. 


Input : - names -> name of downloaded files in format : names=char('file1','file2',..);
        - abundancy -> vector of abundancy of each isotope : abundancy=[isotope1;isotope2;...];
        - density in g/cm^3, atomic molar mass in g/mol-> caracteristics of the element,
        - thickness -> thickness of the filter in cm

Output : - En_av : Energy vector in meV
         - sigma_av : neutron cross section for the filter, in barns
         - Transmission_av : Transmission data for the filter

Example with Iridium (2 isotopes Ir_191 and Ir_193, from EDNF website) :

step 1 : retrieve data file from http://www.nndc.bnl.gov/exfor/endf00.jsp
         unselect all databases except :  ENDF/B-VII.1  (USA, 2011)
         use in the search fields : element_name* (ex: Ir*)
                                     n,tot
                                     sig
          select the first isotope and click plot
          save the file "plotted data" on the right of the screen
          repeat the last 2 steps for the other isotope

 step 2 : use the read data function in matalb (readColData must also be accessible by matlab): 
          names_Ir=char('Ir_191.txt','Ir_193.txt');
          abundancy_Ir=[37.3;62.7]; (in same order as the file names)
          density_Ir=22.56;
          atomic_molarmass_Ir=192.217;
          thickness_Ir=0.04;
          [x,y,yy]=readdata(names_Ir,abundancy_Ir,density_Ir,atomic_molarmass_Ir,thickness_Ir);

 Diane Lancon
 octobre 2012
