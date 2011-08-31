classdef oMatCon < oCon
    %OMATCON  Memory-mapping out-of-core data container for binaries
    %
    %   oMatCon(DATA,PARAM1,VALUE1,...)
    %
    %
    %   DATA  - Can either be the size for generating zeros/ones/randn or
    %   the directory name for loading a file
    %
    %   Optional argument is either of:
    %   OFFSET     - The offset for file
    %   PRECISION  - Either 'single' or 'double'
    %   REPEAT     - 1 for repeat and 0 otherwise
    %   DIMENSIONS - dimensions of the data container
    %   READONLY   - 1 makes the data container readonly
    %   COPY       - 1 creates a copy of the file when loading, otherwise 
    %                changes will be made on the existing file 

    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %   PROPERTIES
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    properties (SetAccess = protected)
        dirname = '';
        dimensions;
        header;
        readOnly = 0;
    end % properties
    
    methods (Access = protected)
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %   Constructor
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        function x = oMatCon(data,varargin) % Constructor for oMatCon
            
            % Setup parameters
            copy       = 0;
            readonly   = 0;
            % Parse param-value pairs using input parser            
            p = inputParser;
            p.addParamValue('offset',0,@isscalar);
            p.addParamValue('precision','double',@ischar);
            p.addParamValue('repeat',0,@isscalar);
            p.addParamValue('dimensions',0,@isnumeric);
            p.addParamValue('readonly',0,@isscalar);
            p.addParamValue('copy',0,@isscalar);
            p.parse(varargin{:});
            
            if (ischar(data)) % Loading file
                if(copy == 0) % overwrite case
                    header = DataContainer.io.memmap.serial.HeaderRead(data);
                    td = data;
                else % no overwrite
                    td = DataContainer.io.makeDir();
                    DataContainer.io.memmap.serial.FileCopy(data,td);
                    header = DataContainer.io.memmap.serial.HeaderRead(td);
                end
            else % Generating file with ones/zeros/randn
                td = DataContainer.io.makeDir();
                header = DataContainer.io.basicHeaderStructFromX(data);
                DataContainer.io.memmap.serial.FileWrite(td,data,header);
            end
            dimensions   = header.size;
            iscomplex    = header.complex;
            % Construct and set class attributes
            x = x@oCon('serial memmap',dimensions,iscomplex);
            x.exdims     = 0; % Explicit dimensions of data
            x.imdims     = 0;
            x.iscomplex  = 0;
            x.dirname    = td;
            x.dimensions = dimensions;
            x.header     = header;
            x.readOnly   = readonly;
        end % constructor
        
        % delete function
        function delete(x)
            % Amazing deletion happens here            
        end % delete
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
            % load
            x = load(dirname,varargin)
    end % Static methods
end % classdef