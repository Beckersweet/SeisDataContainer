function y = reshape(x,varargin)
%RESHAPE    Reshape data container object to desired shape
%
%   reshape(X,N1,N2,...,N,VARARGIN) reshapes data container X into the
%   dimensions defined as [N1,N2,...,N]. Note that the number of elements
%   must be conserved.
%
%   Additional parameters:
%   'readonly' - 1 for readonly and 0 otherwise (default value is 1)
%   'copy'     - 0 for copy and 0 otherwise (default value is 0) 
%

    % finding the index of first string input (if it exists)
    stringIndex = DataContainer.utils.getFirstStringIndex(varargin{:});
    p = inputParser;
    p.addParamValue('readonly',1,@isscalar);
    p.addParamValue('copy',0,@isscalar);
    if(stringIndex)
        p.parse(varargin{stringIndex:end});
        shape = [varargin{1:stringIndex-1}];
    else % default case
        p.parse();
        shape = [varargin{:}];
    end
    
    % making sure that we have the good input shape
    if(prod(shape) ~= numel(x))
        error('bad input shape: the number of elements should be preserved')
    end
    
    if(length(shape) > 2)
        % getting rid of ones at the end of our shape (if there is any)
        actualEnd = length(shape);
        if(shape(end) == 1)        
            for i = length(shape)-1:-1:1
                if(shape(i) == 1)
                    actualEnd = actualEnd - 1;
                else
                    break;
                end
            end
        end
        if(size(shape(1:actualEnd)) == 1)
            shape    = shape(1:actualEnd+1);
        else
            shape    = shape(1:actualEnd);
        end
    end
    % loading the dataContainer
    y        = oMatCon.load...
        (x.pathname,'readonly',p.Results.readonly,'copy',p.Results.copy);
    % changing the explicit size of the new dataContainer
    y.exsize = shape;
end

