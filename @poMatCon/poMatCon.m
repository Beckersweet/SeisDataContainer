classdef poMatCon < oCon
    %POMATCON  Memory-mapping out-of-core data container for binaries
    %
    %   poMatCon(PATHNAME,PARAM1,VALUE1,...)
    %
    %   PATHNAME   - The directory name for loading a file
    %
    %   Optional argument is either of:
    %   OFFSET     - The offset for file
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
        function x = poMatCon(pathname,varargin) % Constructor for oMatCon
            
            % Parse param-value pairs using input parser
            p = inputParser;
            p.addParamValue('offset',0,@isscalar);
            p.addParamValue('precision','double',@ischar);
            p.addParamValue('repeat',0,@isscalar);
            p.addParamValue('readonly',0,@isscalar);
            p.addParamValue('copy',0,@isscalar);
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
                error('Fail: Bad input for poMatCon');
            end
            % Construct and set class attributes
            x = x@oCon('parallel memmap',headerIn.size,headerIn.complex);
            x.exsize     = 0; % Explicit dimensions of data
            x.imdims     = 0;
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