classdef oCon < dataContainer
    %OUTCON  Out-of-core Data Container class
    %
    %   outCon(FILENAME,SIZE,PARAM1,VALUE1,...)
    %
    %   Parameters:
    %   format - The precision of the data file. default 'double'
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %   PROPERTIES
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    properties (Access = protected)
        iscomplex; % True if data is complex
    end
    
    methods (Access = protected)
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %   Constructor
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        function x = oCon(type,dims,iscomplex)
            % Constructor for the out-of-core data container class
            % Not supposed to be called by user
            
            % Preprocess input arguments
            assert(isnumeric(dims),'Dimensions must be a numeric')
            assert(isvector(dims), 'Dimensions must be a vector')
            
            % Construct
            x           = x@dataContainer(type,dims,dims);
            x.iscomplex = iscomplex;
            x.excoddims = length(dims) - 1;
            x.imcoddims = x.excoddims;
            x.excodpart = DataContainer.utils.defaultDistribution(dims(end-1));
            x.imcodpart = x.excodpart;
                        
        end % constructor
        
        % delete function
        function delete(x)
            % Amazing deletion happens here
            
        end % delete
        
    end % protected methods
       
end % classdef























