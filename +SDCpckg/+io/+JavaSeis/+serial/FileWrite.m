function FileWrite(dirname,x,varargin)
%FILEWRITE Writes serial data to binary file
% TODO: be able to create directory, >3 dims 
%
%   FileWrite(DIRNAME,DATA,FILE_PRECISION|HEADER_STRUCT) writes
%   the real serial array X into DIRNAME/FILENAME.
%
%   DIRNAME - A string specifying the directory name
%   DATA    - Non-distributed float data
%
%   Optional argument is either of:
%   FILE_PRECISION - An optional string specifying the precision of one unit of data,
%                    defaults to type of x
%                    Supported precisions: 'double', 'single'
%   HEADER_STRUCT  - An optional header struct as created
%                    by DataContainer.basicHeaderStructFromX
%                    or DataContainer.basicHeaderStruct
%
%   Warning: If the specified dirname exists, it will be removed.
error(nargchk(2, 3, nargin, 'struct'));
assert(ischar(dirname), 'directory name must be a string')
assert(isfloat(x), 'data must be float')
%assert(~isdistributed(x), 'data must not be distributed')

%{
% Setup variables
header = DataContainer.basicHeaderStructFromX(x);
f_precision = header.precision;

% Preprocess input arguments
if nargin>2
    assert(ischar(varargin{1})|isstruct(varargin{1}),...
        'argument mast be either file_precision string or header struct')
    if ischar(varargin{1})
        f_precision = varargin{1};
        header.precision = f_precision;
    elseif isstruct(varargin{1})
        header = varargin{1};
        f_precision = header.precision;
    end
end;
DataContainer.io.verifyHeaderStructWithX(header,x);
%}

% Make Directory
% if isdir(dirname); rmdir(dirname,'s'); end;
% status = mkdir(dirname);
% assert(status,'Fatal error while creating directory %s',dirname);
% At this time, the directory must already exist. 
%}

% Import Javaseis Functions
import beta.javaseis.io.Seisio.*;    
import beta.javaseis.grid.GridDefinition.* ;
import beta.javaseis.array.MultiArray.* ;
import beta.javaseis.array.ElementType.* ;
import beta.javaseis.array.Position.*;
import beta.javaseis.array.BigArrayJava1D.*;
import edu.mines.jtk.util.*;
import java.io.RandomAccessFile.* ;


% Open Seisio File Structure
seisio = beta.javaseis.io.Seisio(dirname);
seisio.open('rw');

% Get number of dimensions and set position accordingly
dimensions = seisio.getGridDefinition.getNumDimensions();

% Define number of Hypercubes, Volumes, Frames & Traces
FpV = seisio.getGridDefinition.getNumFramesPerVolume()
SpT = seisio.getGridDefinition.getNumSamplesPerTrace()
TpF = seisio.getGridDefinition.getNumTracesPerFrame()
VpH = seisio.getGridDefinition.getNumVolumesPerHypercube()
    
position = zeros(dimensions,1);

% Test: Check Position
checkpos = beta.javaseis.array.Position.checkPosition(seisio,position) ;

if checkpos

    fprintf('%s\n','checkpos is TRUE');
    
end    

% Test: Check Axis Values
for di=0:dimensions-1
AxisLength = seisio.getGridDefinition.getAxisLength(di)
end

% Write file
% Trisha's code
% Con: This works only if the dimension is 2d 
%      If  2D: write frames and traces
%      Transpose/Permute the data in memory: Too long & Pb with out-of-core
% Pro: write chunk of data (we want to limit data movement)
% for i = 1:size(x,3)
%    position(dimensions)=i-1;
%    data = x(:,:,i);
%    data=data';
%    seisio.setTraceDataArray(data);
%    seisio.setPosition(position);
%    seisio.writeFrame(size(data,1));% writes one 2D "Frame"
% end

% Define Grid Size
% Shoule be defined from header ?
gridsize = x ;

% Define an array that will contain more than 2D
grid_multiarray = beta.javaseis.array.MultiArray.factory(dimensions,beta.javaseis.array.ElementType.FLOAT,1,gridsize);

% Loop implementation
if gridsize(4) ~= 0
 %ndata = VpH*FpV*TpF*SpT   
 %loop over volumes
 for vol=1:VpH
 
      position(4) = vol-1;   
      %fprintf('%s\n','Volume');
 
      for frm=1:FpV 

          position(3) = frm-1;
          %fprintf('%s\n','Frame');
          
          for trc=1:TpF
             
              position(2) = trc-1 ;
              %fprintf('%s\n','Trace');
             
              %mytest1
              for smp=1:SpT
                  
                   position(1) = smp-1 ;
                  
                   %Matrix of traces has to be built from x
                    matrixoftraces(trc,smp) = trc*smp ;
              end
             
              sizeofmatrix = size(matrixoftraces);
              nbofSpT = matrixoftraces(trc,:) ; 
              
              checkpos = beta.javaseis.array.Position.checkPosition(sio,position) ;
              if checkpos

                 %fprintf('%s\n','checkpos is TRUE');
    
              end       
              
              %setPosition Now works because xml files has been created 
              % means : _position[] object created
              seisio.setPosition(position);
               
               
          end          
                  
           %Write matrixofframes
           matrixofframes(frm,:,:) = matrixoftraces ;
           
      end
 
      %Write matrixofvolumes
      matrixofvolumes(vol,:,:,:) = matrixofframes ;
      
 end
 
 checkpos = beta.javaseis.array.Position.checkPosition(seisio,position) ;
              
 if checkpos

    fprintf('%s\n','checkpos is TRUE');
    pos = position
    
 end 
 
 %Write in 1 Hypercube
 seisio.setPosition(position);
 matrixofhypercubes(1,:,:,:,:) = matrixofvolumes ; 
 grid_multiarray.putHypercube(matrixofhypercubes,position) ;
           % Null pointer Exeption line 485 in beta.javaseis.array.BigArrayJava1D.putArray:System.arraycopy(..source_array...dest_array..)
           % The destination array "dest_array" has not been allocated
           % Need to use Abstract function:setLength to allocate "dest_array"
           % setLength in IBigArray is overriden in BigArrayJava1D
           % Issue not fixed

end

   position(1) = 0;
   position(2) = 0;
   position(3) = 0;
   position(4) = 0; 
   seisio.writeMultiArray(grid_multiarray,position) ;
    
   seisio.close();
   java.io.close('TraceFile'); 
    
end
