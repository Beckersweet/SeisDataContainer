classdef dataContainer
%DATACONTAINER  The Data Container Mother Class
%
%   x = dataContainer(TYPE,EXDIMS,IMDIMS) is the abstract parent class for
%   all data container classes.
%
%   TYPE   is a string that specifies the type of the data container that 
%          is being created
%   EXDIMS is the explicit dimensions of the contained data
%   IMDIMS is the implicit dimensions of the contained data
%
%   Data Container Flags:
%   strict If true, all elementary operations must be performed on data
%          container objects that have the exact same implicit dimensions
%          as well as permutation.
%
%   Since this is an abstract class that cannot be instantiated, this
%   documentation is for reference purposes only.
%
%   Data Container subclasses: 
%   iCon, piCon
%
%   Overloaded Matlab methods:
%   abs, eq, isreal, length, ndims, plus, size, ge, isempty, 
%   isscalar, lt, ne, power, subsasgn, double, gt, isize, ldivide, minus,
%   norm, rdivide, subsref, end, isnumeric, le, mtimes, normest%   
%
%   Extra methods not found in Matlab:
%   invvec, invpermute, setImDims, vec
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Properties
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    properties (SetAccess = protected)
        exdims = []; % Explicit dimensions of data
        imdims = {}; % Implicit dimensions of data
        perm   = {}; % Permutation of data (since original construction)
        type   = ''; % Type of data container
        strict = false; % Strict flag for elementary operations
    end
    
    properties ( Access = protected )
        data   = []; % Actual data for the container
    end
        
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Public Methods
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    methods
        
        % DataCon Constructor
        function x = dataContainer(type,exdims,imdims)
            
            % Check number of arguments
            assert(nargin == 3,'There must be exactly 3 input arguments')
            
            % Set attributes
            x.type   = type;
            x.exdims = exdims;
            x.imdims = imdims;
            
        end % Constructor
        
        % Access Methods
        function value = get.type(x)
            value = x.type;
        end
        
        function value = get.exdims(x)
            value = x.exdims;
        end
        
        function value = get.imdims(x)
            value = x.imdims;
        end
        
        function value = get.data(x)
            value = x.data;
        end
        
        % Set Methods
        function x = set.type(x,value)
            x.type   = value;
        end
        
        function x = set.exdims(x,value)
            x.exdims = value;
        end
        
        function x = set.imdims(x,value)
            x.imdims = value;
        end
        
        function x = set.data(x,value)
            x.data   = value;
        end
                
    end % Public methods
        
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Abstract Public Methods
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    methods ( Abstract )
        
        % double
        y = double(x)
        
        % subsref
        varargout = subsref(x,s)
        
        % subsasgn
        x = subsasgn(x,s,b)
        
        % plus
        y = plus(A,B,swp)
        
        % minus
        y = minus(A,B,swp)
        
        % mtimes
        y = mtimes(A,B,swp)
        
        % ldivide
        y = ldivide(A,B)
        
        % rdivide
        y = rdivide(A,B)
        
        % power
        y = power(A,B)
        
        % metacopy
        y = metacopy(x,y)
                
    end % Public Abstract methods
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Abstract Static Methods
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    methods ( Abstract, Static )
        
        % randn
        x = randn(varargin);
        
        % zeros
        x = zeros(varargin);
                
    end % Abstract static methods
    
    
end