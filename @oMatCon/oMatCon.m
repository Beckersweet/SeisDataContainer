classdef oMatCon < oCon
    %MEMOCON  Memory-mapping out-of-core data container for binaries
    %
    %   memoCon(DIRNAME,FILENAME,SIZE,PARAM1,VALUE1,...)
    %
    %   Parameters:
    %   offset, precision, repeat.
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %   PROPERTIES
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    properties (SetAccess = protected)
        dirname    = ''; % Directory name of data
        filename   = ''; % Filename of data
        prec;
        
    end % properties
    
    methods
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %   Constructor
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        function x = oMatCon(dname,fname,varargin)
            % Constructor for memoCon
            % Process input arguments
            assert(ischar(dname), 'directory name must be a string')
            assert(ischar(fname), 'filename must be a string')
            
            % Setup parameters            
            offset     = 0;
            precision  = 'double';
            repeat;
            dimensions = [];
            
            % Parse param-value pairs
            for i = 1:2:length(varargin)

                assert(ischar(varargin{i}),...
                    'Parameter at input %d must be a string.', i);

                fieldname = lower(varargin{i});
                switch fieldname
                    case {'offset', 'precision', 'repeat', 'dimensions'}
                        eval([fieldname ' = varargin{i+1};']);
                    otherwise
                        error('Parameter "%s" is unrecognized.', ...
                            varargin{i});
                end
            end
            
            % Reads in data and convert to intermediate format? or maybe
            % just read in data header
            
            % Construct and set class attributes
            x = x@oCon('serial memmap',dimensions,iscomplex);
            x.dirname   = dname;
            x.filename  = fname;
            x.exdims    = 0; % Explicit dimensions of data
            x.imdims    = 0;
            x.iscomplex = false;
        end % constructor
        
    end % methods
end % classdef