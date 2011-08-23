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
        dirname = '';
        dims = 0;
    end % properties
    
    methods (Access = protected)
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %   Constructor
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        function x = oMatCon(data,varargin)
            % Constructor for oMatCon
            % Process input arguments
%             assert(ischar(dirname), 'directory name must be a string')
%             assert(ischar(filename), 'directory name must be a string')
%             assert(exist([fullfile(dirname,filename)])==2,...
%                 'Fatal error: file %s does not exist',filename)
            
            % Setup parameters            
            offset     = 0;
            precision  = 'double';
            repeat     = 0;
            iscomplex  = 0; 
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
            
            td = DataContainer.io.makeDir();
            header = DataContainer.io.basicHeaderStructFromX...
                (data);
            DataContainer.io.memmap.serial.FileWrite(td,data,header);
            dimensions   = header.size;           
            iscomplex    = header.complex;
            
            % Construct and set class attributes
            x = x@oCon('serial memmap',dimensions,iscomplex);
            x.exdims     = 0; % Explicit dimensions of data
            x.imdims     = 0;
            x.iscomplex  = 0;
            x.dirname    = td;
            x.dims       = dimensions;
        end % constructor
        
    end % methods
    
    methods ( Static )
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Static Methods
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            % randn
            x = randn(varargin);

            % zeros
            x = zeros(varargin);
            
            % ones
            x = ones(varargin);

    end % Static methods
    
end % classdef