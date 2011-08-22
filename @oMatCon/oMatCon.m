classdef oMatCon < oCon
    %OMATCON  Memory-mapping out-of-core data container for binaries
    %
    %   oMatCon(DIRNAME,FILENAME,SIZE,PARAM1,VALUE1,...)
    %
    %   Parameters:
    %   offset, precision, repeat.
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %   PROPERTIES
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    properties (SetAccess = protected)
        dirname    = ''; % Directory name of data
        filename   = ''; % Filename of data
        dims = [];
        prec;
        
    end % properties
    
    methods
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %   Constructor
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        function x = oMatCon(dirname,filename,varargin)
            % Constructor for oMatCon
            % Process input arguments
            assert(ischar(dirname), 'directory name must be a string')
            assert(ischar(filename), 'directory name must be a string')
            assert(exist([fullfile(dirname,filename)])==2,...
                'Fatal error: file %s does not exist',filename)
            
            % Setup parameters            
            offset     = 0;
            precision  = 'double';
            repeat     = 0;
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
            
            % Read in data header
            header       = DataContainer.io.memmap.serial.HeaderRead(dirname);
            dimensions   = header.size;            
            iscomplex    = header.complex;
            
            % Construct and set class attributes
            x = x@oCon('serial memmap',dimensions,iscomplex);
            x.dirname    = dirname;
            x.filename   = filename;
            x.exdims     = 0; % Explicit dimensions of data
            x.imdims     = 0;
            x.iscomplex  = false;
            x.dims       = dimensions;
            x.prec       = precision;
        end % constructor
        
    end % methods
end % classdef