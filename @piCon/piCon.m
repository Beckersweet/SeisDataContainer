classdef (InferiorClasses = {?distributed,?codistributed}) piCon < iCon
%PICON   The Parallel In-Core Data Container Class
%
%   x = piCon(DATA) returns a serial in-core data container containing
%   distributed data DATA.
%
%   Overloaded Matlab methods:
%   abs                        inv                        permute
%   invvec                     plus                       isempty
%   power                      bsxfun                     conj              
%   isnumeric                  real                       ctranspose      
%   isreal                     reshape                    diag             
%   isscalar                   disp                       ldivide          
%   sign                       distributed                le               
%   size                       double                     length           
%   subsasgn                   end                        lt               
%   subsref                    eq                         minus            
%   times                      mldivide                   transpose        
%   full                       mpower                     uminus                     
%   ge                         mrdivide                   uplus                      
%   gt                         mtimes                     horzcat          
%   ndims                      vertcat                    ne                         
%   imag                       norm                       normest 
%   redistribute               gather                     isdistributed
%
%   Extra methods not found in Matlab:
%   opMatrix                   assertElementsAlmostEqual  invpermute
%   assertEqual                invvec                     isize
%   setImDims                  extract                    vec
%   inject                     codistInfo
%
%   Static methods:
%   randn                      zeros                      distributed              
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Properties
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    properties (SetAccess = protected)
        excoddims; % Explicit codistributed dimension of data
        excodpart; % Explicit codistributed partition of data
        imcoddims; % Implicit codistributed dimension of data
        imcodpart; % Implicit codistributed partition of data
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Methods
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    methods
        
        function x = piCon(data)
            
            % Distribute data if not distributed
            if ~isdistributed(data), data = distributed(data); end
            
            % Check for input data type
            assert( isdistributed(data) && ...
                strcmp(classUnderlying(data),'double'),...
                ['Parallel In-Core Data Container '...
                'can only be created with distributed numeric data'] )
            
            % Extract distribution dimension
            spmd
                cod  = getCodistributor(data);
            end
            
            % Construct iCon
            x           = x@iCon(data);
            cod         = cod{1};
            x.excoddims = cod.Dimension;
            x.excodpart = cod.Partition;
            x.imcoddims = cod.Dimension;
            x.imcodpart = cod.Partition;
            
        end % Constructor
        
    end % Public methods
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Static Methods
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    methods ( Static )
        
        % randn
        x = randn(varargin)
        
        % zeros
        x = zeros(varargin)
        
        % Serial to distributed converter
        x = distributed(data)
        
    end % Static methods
    
end % Classdef