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
%   COPY       - 1 creates a copy of the file(s) when loading, otherwise 
%                changes will be made on the existing file 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   PROPERTIES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
properties (SetAccess = protected)
    readOnly = 0;
end % properties

methods
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %   Constructor
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    function x = oMatCon(varargin) % Constructor for oMatCon
        
        % Parse param-value pairs using input parser
        p = inputParser;
        p.addParamValue('precision','double',@ischar);
        p.addParamValue('readonly',0,@isscalar);
        p.addParamValue('copy',0,@isscalar);            
        p.KeepUnmatched = true;
        
        % First case: Pathname constructor
        if ischar(varargin{1}) || isa(varargin{1},'ConDir')
            pathname = varargin{1};
            varargin = varargin(2:end);
            p.parse(varargin{:});

            if (isa(pathname,'ConDir') && exist(pathname)) % Loading file
                if(p.Results.copy == 0) % overwrite case
                    headerIn = SDCpckg.io.NativeBin.serial.HeaderRead(path(pathname));
                    td       = pathname;
                else % no overwrite
                    td       = ConDir();
                    SDCpckg.io.NativeBin.serial.FileCopy(path(pathname),path(td));
                    headerIn = SDCpckg.io.NativeBin.serial.HeaderRead(path(td));
                end            
            else
                error('Fail: Path does not exist');
            end
            
        % Second case: Matlab numeric array
        elseif isa(varargin{1},'double')
            data     = varargin{1};
            varargin = varargin(2:end);
            p.parse(varargin{:});
            xsize    = size(data);
            xprecisi = class(data);
            td       = ConDir();
            pathname = td;
            headerIn = SDCpckg.basicHeaderStruct(xsize,xprecisi,0);
            SDCpckg.io.NativeBin.serial.FileWrite(path(td),data,headerIn);
            
        else
            error('Unsupported data type %s', class(varargin{1}));
        end
        
        % Construct and set class attributes
        x          = x@oCon(headerIn,p.Unmatched);
        x.pathname = td;
        x.readOnly = p.Results.readonly;

        % Writing header on disk
        SDCpckg.io.NativeBin.serial.HeaderWrite(path(pathname),x.header);
        
    end % constructor
end % public methods
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
        x = load(pathname,varargin);
        % intoout
        x = intoout(data,varargin);
end % Static methods
end % classdef
