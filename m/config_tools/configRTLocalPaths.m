function local_paths = configRTLocalPaths()
%CONFIGRTLOCALPATHS  Config local paths for glider deployment real time data and figures.
%
%  LOCAL_PATHS = CONFIGRTLOCALPATHS() should return a struct with the path 
%  patterns for the deployment files generated during the glider processing
%  chain. It should have the following fields:
%    BINARY_PATH: path pattern of the directory for downloaded .xbd.
%    CACHE_PATH: path pattern of the directory for .cac files.
%    LOG_PATH: path pattern of the directory for downloaded surface log files.
%    ASCII_PATH: path pattern of the directory for converted .dba files.
%    FIGURE_PATH: path pattern of the directory for deployment figures.
%    NETCDF_L0: path pattern of the NetCDF file for raw data
%      (data provided by the glider without any meaningful modification).
%    NETCDF_L1: path pattern of the NetCDF file for processed trajectory data
%      (properly referenced data with conversions, corrections and derivations).
%    NETCDF_L2: path pattern of the NetCDF file for processed grid data
%      (already processed data interpolated on vertical instantaneous profiles).
%  These path patterns are converted to true paths through the function
%  STRFGLIDER.
%
%  Notes:
%    Edit this file filling in the paths to reflect your desired file layout.
%
%  Examples:
%    local_paths = configRTLocalPaths()
%
%  See also:
%    STRFGLIDER
%
%  Author: Joan Pau Beltran
%  Email: joanpau.beltran@socib.cat

  error(nargchk(0, 0, nargin, 'struct'));

  local_paths.binary_path = '/path/to/glider_data/${GLIDER_NAME}/${DEPLOYMENT_START_DATE}/binary';
  local_paths.binary_path = '/path/to/glider_data/${GLIDER_NAME}/${DEPLOYMENT_START_DATE}/binary';
  local_paths.log_path    = '/path/to/glider_data/${GLIDER_NAME}/${DEPLOYMENT_START_DATE}/log';
  local_paths.ascii_path  = '/path/to/glider_data/${GLIDER_NAME}/${DEPLOYMENT_START_DATE}/ascii';
  local_paths.figure_path = '/path/to/glider_data/${GLIDER_NAME}/${DEPLOYMENT_START_DATE}/figures';
  local_paths.netcdf_l0   = '/path/to/glider_data/${GLIDER_NAME}/${DEPLOYMENT_START_DATE}/netcdf/${GLIDER_NAME}_${DEPLOYMENT_START_DATE}_l0.nc';
  local_paths.netcdf_l1   = '/path/to/glider_data/${GLIDER_NAME}/${DEPLOYMENT_START_DATE}/netcdf/${GLIDER_NAME}_${DEPLOYMENT_START_DATE}_l1.nc';
  local_paths.netcdf_l2   = '/path/to/glider_data/${GLIDER_NAME}/${DEPLOYMENT_START_DATE}/netcdf/${GLIDER_NAME}_${DEPLOYMENT_START_DATE}_l2.nc';

end
