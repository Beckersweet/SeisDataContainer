function [FpV,SpT,TpF,VpH,dimensions] = HeaderRead(dirname)
%HEADERREAD Reads header from specified directory
%
% Edited for JavaSeis by Trisha
%
%   HeaderRead(DIRNAME) reads the serial header
%   from file DIRNAME/FILENAME.
%
%   DIRNAME - A string specifying the directory name
%
error(nargchk(1, 1, nargin, 'struct'));
assert(ischar(dirname), 'directory name must be a string')
assert(isdir(dirname),'Fatal error: directory %s does not exist',dirname);

% Set up the Seisio object
import beta.javaseis.io.Seisio.*; 
import beta.javaseis.grid.* ;
seisio = beta.javaseis.io.Seisio(dirname);
seisio.open('r');

% Get number of dimensions and set position accordingly
dimensions = seisio.getGridDefinition.getNumDimensions();

% Define number of Hypercubes, Volumes, Frames & Traces
FpV = seisio.getGridDefinition.getNumFramesPerVolume() ;
SpT = seisio.getGridDefinition.getNumSamplesPerTrace() ;
TpF = seisio.getGridDefinition.getNumTracesPerFrame() ;
VpH = seisio.getGridDefinition.getNumVolumesPerHypercube() ;

seisio.close() ;
    
end
