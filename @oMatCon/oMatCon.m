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
                    
            % Construct and set class attributes
            x                    = x@oCon('serial memmap',headerIn.size,headerIn.complex,p.Unmatched);
            x.pathname           = td;
            x.readOnly           = p.Results.readonly;
            
            if isempty(fieldnames(p.Unmatched))
                x.header             = headerIn;
            else 
                x.header.size        = headerIn.size;
                x.header.dims        = headerIn.dims;
                x.header.complex     = headerIn.complex;
                x.header.distributed = headerIn.distributed;
            end
            
            % Writing header on disk
            DataContainer.io.memmap.serial.HeaderWrite...
                (path(pathname),x.header);
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