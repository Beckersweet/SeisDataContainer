classdef SeisDataContainer
%SEISDATACONTAINER  The Data Container Mother Class
%
%   x = SeisDataContainer(TYPE,EXSIZE,IMSIZE) is the abstract parent class for
%   all data container classes.
%
%   TYPE   is a string that specifies the type of the data container that 
%          is being created
%   EXSIZE is the explicit dimensions of the contained data
%   IMSIZE is the implicit dimensions of the contained data
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
%   invvec, invpermute, setImSize, vec
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Properties
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    properties (SetAccess = protected)
        header = struct(); % header struct for dataContainer
        exsize = []; % Explicit dimensions of data
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
        function x = SeisDataContainer(headerIn,varargin)
                                               
            % Set attributes
            x.header = headerIn;
            x.exsize = x.header.size;

            % parse extra arguments
            ldims = length(x.header.size);
            p = inputParser;
            p.addParamValue('varName',x.header.varName,@ischar);
            p.addParamValue('varUnits',x.header.varUnits,@ischar);
            p.addParamValue('origin',x.header.origin,@(x)isrow(x)&&length(x)==ldims);
            p.addParamValue('delta',x.header.delta,@(x)isrow(x)&&length(x)==ldims);
            p.addParamValue('unit',x.header.unit,@(x)iscell(x)&&length(x)==ldims);
            p.addParamValue('label',x.header.label,@(x)iscell(x)&&length(x)==ldims);
            p.parse(varargin{:});
            x.header.varName  = p.Results.varName;
            x.header.varUnits = p.Results.varUnits;
            x.header.origin   = p.Results.origin;
            x.header.delta    = p.Results.delta;
            x.header.unit     = p.Results.unit;
            x.header.label    = p.Results.label;
            
        end % Constructor
                
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
