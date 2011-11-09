classdef oMatCon < oCon
    %OMATCON  Memory-mapping out-of-core data container for binaries
    %
    %   oMatCon(DATA,PARAM1,VALUE1,...)
    %
    %   pathname   - The directory name for loading a file
    %
    %   Optional argument is either of:
    %   ORIGIN     - The offset for file
    %   PRECISION  - Either 'single' or 'double'
    %   REPEAT     - 1 for repeat and 0 otherwise
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
            p.addParamValue('repeat',0,@isscalar);
            p.addParamValue('readonly',0,@isscalar);
            p.addParamValue('copy',0,@isscalar);
            p.KeepUnmatched = true;
            p.parse(varargin{:});
            
            if (isdir(pathname)) % Loading file
                if(p.Results.copy == 0) % overwrite case
                    headerIn = DataContainer.io.memmap.serial.HeaderRead(pathname);
                    td = pathname;
                else % no overwrite
                    td = DataContainer.io.makeDir();
                    DataContainer.io.memmap.serial.FileCopy(pathname,td);
                    headerIn = DataContainer.io.memmap.serial.HeaderRead(td);
                end            
            else
                error('Fail: Path does not exist');
            end
            
            p.addParamValue('variable',headerIn.variable,@ischar);
            p.addParamValue('label',headerIn.label,@iscell);
            p.addParamValue('unit',headerIn.unit,@iscell);
            p.addParamValue('origin',headerIn.origin,@isvector);
            p.addParamValue('delta',headerIn.delta,@isvector);
            p.parse(varargin{:});
            headerIn.variable = p.Results.variable;
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
                (pathname,headerIn);
            
            % Construct and set class attributes
            x = x@oCon('serial memmap',headerIn.size,headerIn.complex);
            x.pathname   = td;
            x.header     = headerIn;
            x.readOnly   = p.Results.readonly;
        end % constructor
    end % protected methods
    
    methods
        % delete function
        function delete(x)
            DataContainer.io.memmap.serial.FileDelete(x.pathname);
        end % delete
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