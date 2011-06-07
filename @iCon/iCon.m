classdef iCon < dataContainer
%ICON   The In-Core Data Container Class
%
%   x = iCon(DATA) returns a serial in-core data container containing DATA.
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
%
%   Extra methods not found in Matlab:
%   opMatrix                   assertElementsAlmostEqual  invpermute
%   assertEqual                invvec                     isize
%   setImDims                  extract                    vec
%   inject
%
%   Static methods:
%   randn                      zeros

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Public Methods
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    methods
        
        % iCon Constructor
        function x = iCon(data)
            
            % Check for data
            if isdistributed(data)
                assert(strcmp(classUnderlying(data),'double'),...
                    'Input data must be numeric')
            else
                assert(isnumeric(data),'Input data must be numeric')
            end
            
            % Get sizes
            dims = size(data);
            
            % Construct class
            x      = x@dataContainer('InCore',dims,num2cell(dims));
            x.data = data;
            x.perm = num2cell(1:length(size(data)));
        end
        
    end % Public methods
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Static Methods
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    methods ( Static )
        
        % randn
        x = randn(varargin);
        
        % zeros
        x = zeros(varargin);
        
    end % Static methods
        
end % classdef