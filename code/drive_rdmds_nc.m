% mitgcm binary output --> netCDF
close all
clear all

iter0=720;
iter1=720;
del=720;
batchsize=1;
Nbatch=(iter1-iter0+del)/del/batchsize;

for n = 1:Nbatch

disp(['batch number = ',num2str(n)]);

% calculate timesteps to be written out
iter_start = iter0+batchsize*(n-1)*del;
iter_end = iter_start+(batchsize-1)*del;
input.iter=iter_start:del:iter_end;

% define output folder
input.odir=['/global/cscratch1/sd/takaito/mitgcm0/netcdf_',num2str(iter_start)];

% create output folder
com=['! mkdir -p ',input.odir];
eval(com);

%% below, netCDF creation 
% set source dir
sdir = '/global/cscratch1/sd/takaito/mitgcm0/'
input.modelsrc = 'MITgcm+Bling';

% model time step
input.dT = 43200;
input.YR0  = 1950;

% model coordinate
input.x = [sdir,'XC'];
input.y = [sdir,'YC'];
input.zc = [sdir,'RC'];
input.zf = [sdir,'RF'];

% output tracer fields
input.fin=[sdir,'blingTracDiag'];
input.fout={'DIC' 'ALK' 'O2' 'NO3' 'PO4' 'FeT' 'DON' 'DOP'};
input.vname=input.fout;
input.longname=input.fout;
input.unit={'mmol/L' 'mmol/L' 'mmol/L' 'mmol/L' 'mmol/L' 'mmol/L' 'mmol/L' 'mmol/L'};
rdmds_nc_batch(input);

% read in file name
%%input.fin  = [sdir,'Fe01'];
%%input.fout = {'AdvFex' 'AdvFey' 'AdvFez' 'DifFex' 'DifFey' 'DifFezE'};
%%input.vname = %input.fout;
%%input.longname = %input.fout;
%%input.unit     = {'mmol/s' 'mmol/s' 'mmol/s' 'mmol/s' 'mmol/s' 'mmol/s'};
%%rdmds_nc_batch(%input);

% read in file name
%%input.fin  = [sdir,'Fe02'];
%%input.fout = {'DifFezI' 'FeL1' 'FeL2' 'FeL3' 'Ligand1' 'Ligand2' 'Ligand3'};
%%input.vname = %input.fout;
%%input.longname = %input.fout;
%%input.unit     = {'mmol/s' 'mmol/m3' 'mmol/m3' 'mmol/m3' 'mmol/m3' 'mmol/m3' 'mmol/m3' };
%%rdmds_nc_batch(%input);

% read in file name
%%input.fin  = [sdir,'Fe03'];
%%input.fout = {'Ironpcp' 'Ironsco' 'Ironsci' 'Ironreo' 'Ironrei' 'Ironsed' 'IronHydr' 'IronBio' 'Irondust'};
%%input.vname = %input.fout;
%%input.longname = %input.fout;
%%input.unit     = {'mmol/m3/s' 'mmol/m3/s' 'mmol/m3/s' 'mmol/m3/s' 'mmol/m3/s' 'mmol/m3/s' 'mmol/m3/s' 'mmol/m3/s' 'mmol/m3/s'};
%%rdmds_nc_batch(%input);

% read in file name
%%input.fin  = [sdir,'DIC01'];
%%input.fout = {'AdvCx' 'AdvCy' 'AdvCz' 'DifCx' 'DifCy' 'DifCzE'};
%%input.vname = %input.fout;
%%input.longname = %input.fout;
%%input.unit     = {'mmol/s' 'mmol/s' 'mmol/s' 'mmol/s' 'mmol/s' 'mmol/s'};
%%rdmds_nc_batch(%input);

% read in file name
%%input.fin  = [sdir,'DIC02'];
%%input.fout = {'DifCzI' 'BioCuptake' 'BioCremin'};
%%input.vname = %input.fout;
%%input.longname = %input.fout;
%%input.unit     = {'mmol/s' 'mmol/m3/s' 'mmol/m3/s'};
%%rdmds_nc_batch(%input);

% read in file name
%%input.fin  = [sdir,'VertFlux'];
%%input.fout = {'wdic' 'wpo4' 'wno3' 'wdfe' 'wsio2'};
%%input.vname = %input.fout;
%%input.longname = %input.fout;
%%input.unit     = {'mmol/m2/s' 'mmol/m2/s' 'mmol/m2/s' 'mmol/m2/s' 'mmol/m2/s'};
%%rdmds_nc_batch(%input);

% read in file name
%%input.fin  = [sdir,'2DdynDiag'];
%%input.fout = {'ssh' 'ssh2' 'mld'};
%%input.vname= {'ssh' 'ssh2' 'mld'};
%%input.longname = {'ssh' 'ssh2' 'mld'};
%%input.unit     = {'m' 'm2' 'm'};
%%rdmds_nc_batch(%input);

% read in file name
%%input.fin  = [sdir,'Phyto'];
%%input.fout = {'phy1' 'phy2' 'phy3' 'phy4' 'phy5' 'phy6'};
%%input.vname= {'phy1' 'phy2' 'phy3' 'phy4' 'phy5' 'phy6'};
%%input.longname = {'phy1' 'phy2' 'phy3' 'phy4' 'phy5' 'phy6'};
%%input.unit     = {'mmolP/m3' 'mmolP/m3' 'mmolP/m3' 'mmolP/m3' 'mmolP/m3' 'mmolP/m3'};
%%rdmds_nc_batch(%input);

% read in file name
%%input.fin  = [sdir,'NutGas'];
%%input.fout = {'po4' 'no3' 'dfe' 'sio2' 'dic' 'alk' 'o2'};
%%input.vname = %input.fout;
%%input.longname = %input.fout;
%%input.unit     = {'mmol/m3' 'mmol/m3' 'mmol/m3' 'mmol/m3' 'mmol/m3' 'mmol/m3' 'mmol/m3'};
%%rdmds_nc_batch(%input);

% read in file name
%input.fin  = [sdir,'CChem'];
%input.fout = {'co2flux' 'netco2flux' 'pco2' 'ph' 'TAUX' 'TAUY' 'Qnet' 'Sflux'};
%input.vname = %input.fout;
%input.longname = %input.fout;
%input.unit     = {'mmolC/m2/s' 'mmolC/m2/s' 'atm' 'ND' 'Pa' 'Pa' 'W/m2' 'm/s'};
%rdmds_nc_batch(%input);

% read in file name
%input.fin  = [sdir,'BioProd'];
%input.fout = {'pp' 'par'};
%input.vname = %input.fout;
%input.longname = {'Primary Production' 'PAR'};
%input.unit     = {'mmolP/m3/sec' 'uEin/m^2/s'};
%rdmds_nc_batch(%input);

% read in file name
%%input.fin  = [sdir,'FeDiags1'];
%%input.fout = {'FeL1' 'FeL2' 'FeL3' 'L1' 'L2' 'L3'};
%%input.vname = %input.fout;
%%input.longname = %input.fout;
%%input.unit     = {'mmol/m3' 'mmol/m3' 'mmol/m3' 'mmol/m3' 'mmol/m3' 'mmol/m3'};
%%rdmds_nc_batch(%input);

% read in file name
%input.fin  = [sdir,'3DdynDiag'];
%input.fout = {'U' 'V' 'W' 'T' 'S' 'VORT'};
%input.vname= %input.fout;
%input.longname = %input.fout;
%input.unit     = {'m/s' 'm/s' 'm/s' 'deg C' 'psu' '1/s'};
%rdmds_nc_batch(%input);

% read in data
%input.fin  = [sdir,'PTR01'];
%input.fout = {'tr05' 'tr06' 'tr07' 'tr08' 'tr09' 'tr10' 'tr11' 'tr12' 'tr13' 'tr14'};
%input.vname = %input.fout;
%input.longname = %input.fout;
%input.unit     = {'mmol/m3' 'mmol/m3' 'mmol/m3' 'mmol/m3' 'mmol/m3' 'mmol/m3' 'mmol/m3' 'mmol/m3' 'mmol/m3' 'mmol/m3'};
%rdmds_nc_batch(%input);

% read in data
%input.fin  = [sdir,'PTR02'];
%input.fout = {'tr15' 'tr16' 'tr17' 'tr18' 'tr19' 'tr20' 'tr21' 'tr28' 'tr29' 'tr30'};
%input.vname = %input.fout;
%input.longname = %input.fout;
%input.unit     = {'mmol/m3' 'mmol/m3' 'mmol/m3' 'mmol/m3' 'mmol/m3' 'mmol/m3' 'mmol/m3' 'mmol/m3' 'mmol/m3' 'mmol/m3'};
%rdmds_nc_batch(%input);

% read in data
%input.fin  = [sdir,'PTR03'];
%input.fout = {'tr31' 'tr32' 'tr33' 'tr35' 'tr36' 'tr37' 'tr40' 'tr41'};
%input.vname = %input.fout;
%input.longname = %input.fout;
%input.unit     = {'mmol/m3' 'mmol/m3' 'mmol/m3' 'mmol/m3' 'mmol/m3' 'mmol/m3' 'mmol/m3' 'mmol/m3'};
%rdmds_nc_batch(%input);


end

