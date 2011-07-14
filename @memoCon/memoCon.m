classdef memoCon < outCon
    %MEMOCON  Memory-mapping out-of-core data container for binaries
    %
    %   memoCon(FILENAME,SIZE,PARAM1,VALUE1,...)
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %   PROPERTIES
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    properties (SetAccess = protected)
        filename = ''; % Filename of data        
        
    end % properties
    
    methods
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %   Constructor
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        function x = memoCon(fname,varargin)
            % Constructor for memoCon
            % Process input arguments
            assert(ischar(fname), 'filename must be a string')
            
            % Reads in data and convert to intermediate format
            
            % Construct and set class attributes
            x = x@outCon(type,dims,iscomplex);
            x.exdims = 0;
            x.imdims = 0;
            x.iscomplex = false;
        end % constructor
        
    end % methods
end % classdef