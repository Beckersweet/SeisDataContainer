classdef poMatCon < poCon
    %POMATCON  Memory-mapping distributed out-of-core data container for binaries
    %
    %   poMatCon(PATHNAME,PARAM1,VALUE1,...)
    %
    %   PATHNAME   - The directory name for loading a file
    %
    %   Optional argument is either of:
    %   ORIGIN     - The offset for file
    %   PRECISION  - Either 'single' or 'double'
    %   REPEAT     - 1 for repeat and 0 otherwise
    %   READONLY   - 1 makes the data container readonly
    %   COPY       - 1 creates a copy of the file when loading, otherwise 
    %                changes will be made on the existing file
    %   DISTRIBUTE - 1 for distributed files and 0 otherwise
    
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
        function x = poMatCon(pathname,varargin) % Constructor for poMatCon
            
            % Parse param-value pairs using input parser
            p = inputParser;            
            p.addParamValue('precision','double',@ischar);
            p.addParamValue('repeat',0,@isscalar);
            p.addParamValue('readonly',0,@isscalar);
            p.addParamValue('distribute',0,@ isscalar);
            p.addParamValue('copy',0,@isscalar);
            p.KeepUnmatched = true;
            p.parse(varargin{:});
            
            if (isdir(pathname)) % Loading file
                if(p.Results.copy == 0) % overwrite case
                    headerIn = SeisDataContainer.io.NativeBin.serial.HeaderRead(pathname);
                    td = pathname;
                else % no overwrite
                    td = SeisDataContainer.io.makeDir();
                    SeisDataContainer.io.NativeBin.serial.FileCopy(pathname,td);
                    headerIn = SeisDataContainer.io.NativeBin.serial.HeaderRead(td);
                end            
            else
                error('Fail: Path does not exist');
            end
            % Construct and set class attributes
            x = x@poCon('parallel NativeBin',headerIn,p.Unmatched);
            x.pathname   = td;
            x.header     = headerIn;
            x.readOnly   = p.Results.readonly;
        end % constructor
    end % protected methods
    
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
