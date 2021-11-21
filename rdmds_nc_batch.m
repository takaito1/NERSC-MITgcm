function dummy = rdmds_nc_batch(input)

% mitgcm binary output --> netCDF
N=length(input.fout);

% Taka 1-8-2021 ---
odir = input.odir; % define output directory
iter = input.iter; % input timestep numbers
% -----------------

for n=1:N
disp(['working on the variable : ',input.fin]);
% read in file name
fin  = input.fin;
fout = [odir,'/',input.fout{n}];
vname= input.vname{n};
longname = input.longname{n};
unit     = input.unit{n};
modelsrc = input.modelsrc;

% model time step
dT   = input.dT;
YR0  = input.YR0;

% coordinate
xin  = input.x;
yin  = input.y;
zin  = input.zc;
zf   = input.zf;

% model year
yr2sec = 86400*360;
day2sec = 86400;
yr2day=365.25;

% read in data
lon=rdmds(xin); X = squeeze(lon(:,1));
lat=rdmds(yin); Y = squeeze(lat(1,:));
Z=-squeeze(rdmds(zin));
ZF=-squeeze(rdmds(zf));
% 1-9-2021 
 [V,iter]=rdmds(fin,NaN,'rec',n);
%[V,iter]=rdmds(fin,iter,'rec',n);
% 
Nsize= size(V);
Ndim = length(Nsize);
if Ndim == 3 & Nsize(end) == length(iter)
   % this is a 2D (x-y) map
   Z = 0.;
end

% define (days since YR0-01-01)
T0 =iter*dT/yr2sec;
T = (T0 - (T0(2)-T0(1))*.5 )*yr2day;
T = floor(T);

%% 3. Generate NetCDF file
scope = netcdf.create([fout,'.nc'],'netcdf4');
NC_GLOBAL = netcdf.getConstant('NC_GLOBAL');
fillValue = -99999;

% 3-3. Define dimensions
dimidX = netcdf.defDim(scope,'lon',length(X));
dimidY = netcdf.defDim(scope,'lat',length(Y));
if Z ~= 0.
   dimidZ = netcdf.defDim(scope,'depth',length(Z)); % turn on if you have depth directions
   dimidZF = netcdf.defDim(scope,'bnds',2); % turn on if you have depth directions
end
dimidT = netcdf.defDim(scope,'time',length(T));

% 3-4. Define coordinates and time axis
varid = netcdf.defVar(scope,'lon','double',[dimidX]);
netcdf.putAtt(scope,varid,'standard_name','lon');
netcdf.putAtt(scope,varid,'long_name','longitude');
netcdf.putAtt(scope,varid,'units','degrees_east');
netcdf.defVarFill(scope,varid,false,fillValue);
netcdf.putVar(scope,varid,X);

varid = netcdf.defVar(scope,'lat','double',[dimidY]);
netcdf.putAtt(scope,varid,'standard_name','lat');
netcdf.putAtt(scope,varid,'long_name','latitude');
netcdf.putAtt(scope,varid,'units','degrees_north');
netcdf.defVarFill(scope,varid,false,fillValue);
netcdf.putVar(scope,varid,Y);

if Z ~= 0.
   varid = netcdf.defVar(scope,'depth','double',[dimidZ]);
   netcdf.putAtt(scope,varid,'standard_name','depth');
   netcdf.putAtt(scope,varid,'long_name','depth from the surface ocean');
   netcdf.putAtt(scope,varid,'units','m');
   netcdf.putAtt(scope,varid,'bounds','depth_bnds');
   netcdf.defVarFill(scope,varid,false,fillValue);
   netcdf.putVar(scope,varid,Z);

   Zbnds(:,1)=ZF(1:end-1);
   Zbnds(:,2)=ZF(2:end);
   varid = netcdf.defVar(scope,'depth_bnds','double',[dimidZF dimidZ]);
   netcdf.putAtt(scope,varid,'standard_name','depth');
   netcdf.putAtt(scope,varid,'units','m');
   netcdf.defVarFill(scope,varid,false,fillValue);
   netcdf.putVar(scope,varid,Zbnds');
   
end

varid = netcdf.defVar(scope,'time','double',[dimidT]);
netcdf.putAtt(scope,varid,'standard_name','time');
netcdf.putAtt(scope,varid,'units',['days since ',num2str(YR0),'-01-01 00:00:00']);
netcdf.putAtt(scope,varid,'long_name','days');
netcdf.defVarFill(scope,varid,false,fillValue);
netcdf.putVar(scope,varid,T);

% 3-5. Define variable attributes
netcdf.putAtt(scope,NC_GLOBAL,'title',[vname,' from MITgcm'])
netcdf.putAtt(scope,NC_GLOBAL,'long_title',[vname,' from MITgcm in NetCDF file'])

netcdf.putAtt(scope,NC_GLOBAL,'comments','Raw Data')
netcdf.putAtt(scope,NC_GLOBAL,'institution','Georgia Institute of Technology MITgcm')
netcdf.putAtt(scope,NC_GLOBAL,'source',modelsrc)

netcdf.putAtt(scope,NC_GLOBAL,'Conventions','CF-1.6')

netcdf.putAtt(scope,NC_GLOBAL,'CreationDate',datestr(now,'yyyy/mm/dd HH:MM:SS'))
netcdf.putAtt(scope,NC_GLOBAL,'CreatedBy',getenv('LOGNAME'))

netcdf.close(scope)
% 1-9-2021 Taka
scope = netcdf.open([fout,'.nc'],'WRITE'); % here we use 'WRITE' because the file already exists

% 3-6. Define and store variables
varname = vname;
long_name = longname;

if Z == 0.
   varid = netcdf.defVar(scope,varname,'double',[dimidX,dimidY,dimidT]);
else
   varid = netcdf.defVar(scope,varname,'double',[dimidX,dimidY,dimidZ,dimidT]);
end
netcdf.putAtt(scope,varid,'long_name',long_name);
netcdf.putAtt(scope,varid,'units',unit);
netcdf.defVarFill(scope,varid,false,fillValue);

% enter fill value
V(isnan(V)) = fillValue;
V(V==0) = fillValue;

netcdf.putVar(scope,varid,V);
netcdf.close(scope) % now insert three-dimensional data to NetCDF file

end

