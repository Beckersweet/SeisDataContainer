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
%             offset     = 0;
%             precision  = 'double';
%             repeat     = 0;
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
%             for i = 1:2:length(varargin)
%                 assert(ischar(varargin{i}),...
%                     'Parameter at input %d must be a string.', i);
%                 fieldname = lower(varargin{i});
%                 switch fieldname
%                     case {'offset', 'precision', 'repeat',...
%                             'dimensions', 'readonly', 'copy'}
%                         eval([fieldname ' = varargin{i+1};']);
%                     otherwise
%                         error('Parameter "%s" is unrecognized.', ...
%                             varargin{i});
%                 end
%             end
            
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