classdef oCon < dataContainer
    %OCON  Out-of-core Data Container class
    %
    %   oCon(TYPE,DIMS,ISCOMPLEX)
    %
    %   Parameters:
    %   format - The precision of the data file. default 'double'
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %   PROPERTIES
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    properties (Access = protected)
        pathname = '';
        iscomplex; % True if data is complex
    end
    
    methods (Access = protected)
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %   Constructor
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        function x = oCon(type,headerIn,varargin)
            % Constructor for the out-of-core data container class
            % Not supposed to be called by user
            
            % Construct            
            x           = x@dataContainer(type,headerIn.size,headerIn.size,headerIn,varargin{:});
            x.iscomplex = headerIn.complex;
                        
        end % constructor
    end % protected methods
    
    methods
        % delete function
        function delete(x)
            % Amazing deletion happens here            
        end % delete
    end
       
end % classdef























