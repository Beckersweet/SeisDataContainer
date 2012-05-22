classdef iCon < SeisDataContainer
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
%   setImSize                  extract                    vec
%   inject
%
%   Static methods:
%   randn                      zeros

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Public Methods
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    methods
        
        % iCon Constructor
        function x = iCon(doh,varargin)
            if ~isstruct(doh)
                assert(isnumeric(doh));
                header = SeisDataContainer.basicHeaderStructFromX(doh);
            else
                header = doh;
            end
            
            % Construct class
            x = x@SeisDataContainer(header,varargin{:});
            
            if ~isstruct(doh) 
                x.perm   = 1:length(size(doh));
                x.data   = doh;
            end
        end
        
    end % Public methods
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Static Methods
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    methods ( Static )
        
        % ones
        x = ones(varargin);
        
        % randn
        x = randn(varargin);
        
        % zeros
        x = zeros(varargin);
        
        % load
        x = load(pathname,varargin)
        
    end % Static methods
        
end % classdef
