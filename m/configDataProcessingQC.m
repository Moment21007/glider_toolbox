function processing_qc_options = configDataProcessingQC(data_processed)
%CONFIGDATAPROCESSINGQC  Sets the defines the applied QC methods for processed data.
%
%  Syntax:
%    PROCESSING_QC_OPTIONS = CONFIGDATAPROCESSINGQC(DATA_PROCESSED)
%
%  Description:
%    Returns the configuration struct for the QC applied to the processed
%    data struct.
%
%    Behaves similar to configDataPreprocessingQC.
%
%    Each check must be defined as processing_qc_options.PROCESSNAME and
%    has to contain the struct entries functionHandle, processOn and
%    passingParameters. Only exception is the NaN-Check, which only
%    requires the functionHandle and a switch, if it should be applied
%    (true) or not (false).
%
%    The functionHandle defines the function that is applied to the
%    specified data (string).
%    
%    The struct entry passingParameters contains the parameters given to the
%    functions. It must be a cell for each processOn entry. If there are
%    more than one variable, the test should be applied to (e.g. bad 
%    longitude means also a bad latitude and vice versa), the processOn
%    cell must contain another cell entry with the variable names.
%    
%    Example for defining a validRangeCheck:
%    processing_qc_options.validRangeCheck.functionHandle =
%    str2func('validRangeCheck');
%    processing_qc_options.validRangeCheck.processOn = { 'temperature';
%    {'latitude'; 'longitude'};};
%    processing_qc_options.validRangeCheck.passingParameters = { [{data_processed.temperature}; -2; 42; 4];
%    [{data_processed.latitude}; 30; 46; 4];};
%    This means, if the passing temperature measurements exceed the
%    threshold (between -2 and 42 degrees Celsius), the variable
%    temperature (defined in processOn) will be flagged with the outcome of
%    the validRangeCheck. Also, if the latitude exceed the thresholds 30
%    and 46 degrees, the latitude and longitude (defined in processOn) will
%    be flagged.
%
%  Notes:
%       Requires processed data struct as input.
%
%  Examples:
%    processing_qc_options = configDataProcessingQC(data_processed)
%
%  See also:
%    CONFIGDATAPREPROCESSINGQC
%
%  Authors:
%    Andreas Krietemeyer  <akrietemeyer@socib.es>

%  Copyright (C) 2016
%  ICTS SOCIB - Servei d'observacio i prediccio costaner de les Illes Balears.
%  <http://www.socib.es>
%
%  This program is free software: you can redistribute it and/or modify
%  it under the terms of the GNU General Public License as published by
%  the Free Software Foundation, either version 3 of the License, or
%  (at your option) any later version.
%
%  This program is distributed in the hope that it will be useful,
%  but WITHOUT ANY WARRANTY; without even the implied warranty of
%  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%  GNU General Public License for more details.
%
%  You should have received a copy of the GNU General Public License
%  along with this program.  If not, see <http://www.gnu.org/licenses/>.

processing_qc_options.checkAllForNan.switch = true;
processing_qc_options.checkAllForNan.functionHandle = str2func('nanCheck');

processing_qc_options.impossibleDateCheck.functionHandle = str2func('impossibleDateCheck');
processing_qc_options.impossibleDateCheck.processOn = {
    'time';
    {'time_ctd'; 'temperature'; 'conductivity'; 'salinity'; 'oxygen_concentration'; 'oxygen_saturation'; 'pressure'; 'chlorophyll'; 'turbidity'}
    };
processing_qc_options.impossibleDateCheck.passingParameters = {
        [{data_processed.time}; 4];
        [{data_processed.time_ctd}; 4]
    };

processing_qc_options.impossibleLocationCheck.functionHandle = str2func('impossibleLocationCheck');
processing_qc_options.impossibleLocationCheck.processOn = {{'longitude'; 'latitude'}};
processing_qc_options.impossibleLocationCheck.passingParameters = {
        [{data_processed.latitude}; {data_processed.longitude}; 4]
    };

processing_qc_options.validRangeCheck.functionHandle = str2func('validRangeCheck');
processing_qc_options.validRangeCheck.processOn = {
    'temperature';
    'chlorophyll';
    'turbidity';
    {'oxygen_concentration'; 'oxygen_saturation'};
    {'oxygen_saturation'; 'oxygen_concentration'};
    {'longitude'; 'latitude'};
    {'latitude'; 'longitude'};
    {'waypoint_longitude'; 'waypoint_latitude'};
    {'waypoint_latitude'; 'waypoint_longitude'};
    'temperature';
    'salinity'
    };
processing_qc_options.validRangeCheck.passingParameters = {
        [{data_processed.temperature}; -2; 42; 4];
        [{data_processed.chlorophyll}; 0; 50; 4];
        [{data_processed.turbidity}; 0; 50; 4];
        [{data_processed.oxygen_concentration}; 0; 500; 4];
        [{data_processed.oxygen_saturation}; 0; 200; 4];
        [{data_processed.longitude}; -6; 37; 4];
        [{data_processed.latitude}; 30; 46; 4];
        [{data_processed.waypoint_longitude}; -6; 37; 3];
        [{data_processed.waypoint_latitude}; 30; 46; 3];
        [{data_processed.temperature}; {[0; 3; 3; 3; 3; 3]}; {[34; 30; 28; 26; 22; 20]}; 4; {data_processed.depth}; {[0, 20; 20, 50; 50, 75; 75, 150; 150, 300; 300, 1100]}];
        [{data_processed.salinity}; {[0; 12; 31; 33]}; {[40; 40; 40; 40]}; 4; {data_processed.depth}; {[0, 30; 30, 75; 75, 600; 600, 1100]}]
    };

processing_qc_options.spikeCheck.functionHandle = str2func('spikeCheck');
processing_qc_options.spikeCheck.processOn = {'temperature';
    'turbidity'
    };
processing_qc_options.spikeCheck.passingParameters = {
        [{data_processed.temperature}; 6; {data_processed.pressure}; 500; 6; 2];
        [{data_processed.turbidity}; 6; 5]
    };

processing_qc_options.performSpecialGradientCheck.functionHandle = str2func('performSpecialGradientCheck');
processing_qc_options.performSpecialGradientCheck.processOn = {{'conductivity'; 'density'; 'salinity'}
    };
processing_qc_options.performSpecialGradientCheck.passingParameters = {
        [{data_processed.conductivity}; {data_processed.depth}; {data_processed.profile_index}; 0.05; 0.05; 200; 4]
    };
end
