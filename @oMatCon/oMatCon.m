classdef oMatCon < oCon
    %OMATCON  Memory-mapping out-of-core data container for binaries
    %
    %   oMatCon(DATA,PARAM1,VALUE1,...)
    %
    %   DATA  - Can either be the size for generating zeros/ones/randn or
    %   the directory name for loading a file
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
        dirname = '';
        header;
        readOnly = 0;
    end % properties
    
    methods (Access = protected)
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %   Constructor
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        function x = oMatCon(data,varargin) % Constructor for oMatCon
            
            % Parse param-value pairs using input parser
            p = inputParser;
            p.addParamValue('offset',0,@isscalar);
            p.addParamValue('precision','double',@ischar);
            p.addParamValue('repeat',0,@isscalar);
            p.addParamValue('readonly',0,@isscalar);
            p.addParamValue('copy',0,@isscalar);
            p.parse(varargin{:});
            inputs = p.Results;
            
            if (ischar(data)) % Loading file
                if(inputs.copy == 0) % overwrite case
                    headerIn = DataContainer.io.memmap.serial.HeaderRead(data);
                    td = data;
                else % no overwrite
                    td = DataContainer.io.makeDir();
                    DataContainer.io.memmap.serial.FileCopy(data,td);
                    headerIn = DataContainer.io.memmap.serial.HeaderRead(td);
                end
            else % Generating file with ones/zeros/randn
                td = DataContainer.io.makeDir();
                headerIn = DataContainer.io.basicHeaderStructFromX(data);
                DataContainer.io.memmap.serial.FileWrite(td,data,headerIn);
            end
            iscomplex    = headerIn.complex;
            % Construct and set class attributes
            x = x@oCon('serial memmap',headerIn.size,iscomplex);
            x.exdims     = 0; % Explicit dimensions of data
            x.imdims     = 0;
            x.iscomplex  = iscomplex;
            x.dirname    = td;
            x.header     = headerIn;
            x.readOnly   = inputs.readonly;
        end % constructor
    end % protected methods
    
    methods
        % delete function
        function delete(x)
            DataContainer.io.memmap.serial.FileDelete(x.dirname);
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
            x = load(dirname,varargin)
    end % Static methods
end % classdef