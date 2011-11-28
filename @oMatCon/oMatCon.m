classdef oMatCon < oCon
    %OMATCON  Memory-mapping out-of-core data container for binaries
    %
    %   oMatCon(PATHNAME,PARAM1,VALUE1,PARAM2,VALUE2...)
    %
    %   pathname   - The directory name for loading a file
    %
    %   Optional argument is either of:
    %   ORIGIN     - The offset for data
    %   DELTA      - The interval for data
    %   PRECISION  - Either 'single' or 'double'
    %   READONLY   - 1 makes the data container readonly
    %   COPY       - 1 creates a copy of the file when loading, otherwise 
    %                changes will be made on the existing file 
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %   PROPERTIES
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    properties (SetAccess = protected)
        readOnly = 0;
    end % properties
    
    methods (Access = protected)
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %   Constructor
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        function x = oMatCon(pathname,varargin) % Constructor for oMatCon
            
            % Parse param-value pairs using input parser
            p = inputParser;            
            p.addParamValue('precision','double',@ischar);
            p.addParamValue('readonly',0,@isscalar);
            p.addParamValue('copy',0,@isscalar);
            p.KeepUnmatched = true;
            p.parse(varargin{:});
            
            if (isa(pathname,'ConDir') && exist(pathname)) % Loading file
                if(p.Results.copy == 0) % overwrite case
                    headerIn = DataContainer.io.memmap.serial.HeaderRead(path(pathname));
                    td = pathname;
                else % no overwrite
                    td = ConDir();
                    DataContainer.io.memmap.serial.FileCopy(path(pathname),path(td));
                    headerIn = DataContainer.io.memmap.serial.HeaderRead(path(td));
                end            
            else
                error('Fail: Path does not exist');
            end
            
            p.addParamValue('varName',headerIn.varName,@ischar);
            p.addParamValue('varUnits',headerIn.varUnits,@ischar);
            p.addParamValue('label',headerIn.label,@iscell);
            p.addParamValue('unit',headerIn.unit,@iscell);
            p.addParamValue('origin',headerIn.origin,@isvector);
            p.addParamValue('delta',headerIn.delta,@isvector);
            p.parse(varargin{:});
            headerIn.varName = p.Results.varName;
            headerIn.varUnits = p.Results.varUnits;
            if(numel(p.Results.label) == headerIn.dims)
                headerIn.label = p.Results.label;
            else
                error('Wrong number of labels');
            end
            if(numel(p.Results.unit) == headerIn.dims)
                headerIn.unit = p.Results.unit;
            else
                error('Wrong number of units');
            end
            if(numel(p.Results.origin) == headerIn.dims)
                headerIn.origin = p.Results.origin;
            else
                error('Wrong size for origin');
            end
            if(numel(p.Results.delta) == headerIn.dims)
                headerIn.delta = p.Results.delta;
            else
                error('Wrong size for delta');
            end
            DataContainer.io.memmap.serial.HeaderWrite...
                (path(pathname),headerIn);
            
            % Construct and set class attributes
            x = x@oCon('serial memmap',headerIn.size,headerIn.complex);
            x.pathname   = td;
            x.header     = headerIn;
            x.readOnly   = p.Results.readonly;
        end % constructor
    end % protected methods
    
    methods        
    end
    
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
            % load
            x = load(pathname,varargin)
    end % Static methods
end % classdef