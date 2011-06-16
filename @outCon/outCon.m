classdef outCon < dataContainer
    %MDCON  Memmapfile Data Container class
    %
    %   mdCon(FILENAME,SIZE,PARAM1,VALUE1,...)
    %
    %   Parameters:
    %   format - The precision of the data file. default 'double'
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %   PROPERTIES
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    properties (Access = protected)
        intrdata = Composite();
        iscomplex; % True if data is complex
        excoddims; % Explicit codistributed dimension of data
        excodpart; % Explicit codistributed partition of data
        imcoddims; % Implicit codistributed dimension of data
        imcodpart; % Implicit codistributed partition of data
    end
    
    methods (Access = protected)
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %   Constructor
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        function x = outCon(type,dims,iscomplex)
            %% Constructor for the out-of-core data container class
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
        
        %% delete function
        function delete(x)
            % Amazing deletion happens here
            
        end % delete
        
    end % protected methods
    
    methods(Static)
    %% Static constructors, to be used as the frontend for users
    % constructing any kind of data container out of a file path
        
        % JaveSeiz reader, to be written properly in the near future
        x = javaSeisOpen(varargin)
        
        % Binary reader, which is used to prototype
        x = binaryOpen(filepath,dims,iscomplex)
        
        % Copy constructor, used to instantiate new items after every
        % iteration
        x = copy(outconobj);
        
    end % Static methods
    
end % classdef























