classdef oCon < SeisDataContainer
    %OCON  Out-of-core Data Container class
    %
    %   oCon(HEADER,PARAMETERS...)
    %
    %   Parameters:
    %   format - The precision of the data file. default 'double'
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %   PROPERTIES
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    properties (Access = protected)
        pathname = '';
    end
    
    methods (Access = protected)
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %   Constructor
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        function x = oCon(headerIn,varargin)
            % Constructor for the out-of-core data container class
            % Not supposed to be called by user
            
            % Construct            
            x = x@SeisDataContainer(headerIn,varargin{:});
        end % constructor
    end % protected methods
end % classdef























