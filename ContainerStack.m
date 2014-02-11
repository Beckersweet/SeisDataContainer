classdef ContainerStack
    %CONTAINERSTACK simulate stack datatype plus additional features
    %   Current implementation uses cell array
    %
    % Regular Stack Features:
    %   pop(cs)             : remove the first entry and return the value
    %   push(cs,<stuff>)    : push new entry to the stack
    %   peek(cs)            : get the first entry data
    %   isempty(cs)         : true if the stack is empty
    %   search <---- NOT SUPPORTED AT THE MOMENT
    %
    % Special Features in ContainerStack
    %   get(cs,<Index>)     : get the entry data
    %   clear(cs,<Index>)   : making the entry empty
    %   remove(cs,<Index>)  : removing the entry
    % Note: Index of 1 means the entry at the top of the stack and so on.
    %           Therefore, peek(cs) is equivalent to get(cs,1)
    %
    % Other Features
    %   numel(cs)           : return the number of elements
    
    properties (SetAccess = protected)
        data = {};
    end
    
    methods
        function cs = ContainerStack()
            % Nothing really
        end
        
        function res = pop(cs)
            if numel(cs) > 0
                res = cs.data{numel(cs)};
                cs.data(numel(cs)) = [];
            else
                warning('ContainerStack:pop','ContainerStack: Nothing more to pop');
                res = [];
            end
        end
        
        function cs = push(cs,theStuff)
            %cs.data{numel(cs) + 1} = theStuff;
            newElement = struct(...
                'ID',NaN,...
                'mode',NaN,...
                'origin',NaN,...
                'opM',NaN,...
                'opN',NaN,...
                'children',{0},...
                'ClassName',0);
            
            for ind = 1:length(theStuff)
                fiName = theStuff{ind}{1};
                fiVal  = theStuff{ind}{2};
                
                newElement.(fiName) = fiVal;
            end
            cs.data{numel(cs) + 1} = newElement;
        end
        
        function res = peek(cs)
            res = get(cs,1);
        end
        
        function res = isempty(cs)
            res = false;
            if numel(cs) == 0
                res = true;
            end
        end
        
        function res = get(cs,theInd)
            res = cs.data{numel(cs) - theInd + 1};
        end
        
        function cs = clear(cs,theInd)
            cs.data{numel(cs) - theInd + 1} = [];
        end
        
        function cs = remove(cs,theInd)
            cs.data(numel(cs) - theInd + 1) = [];
        end
        
        function res = numel(cs)
            res =  length(cs.data);
        end
        
    end
    
    methods( Static )
        function res = toCells(cs)
            res = {};
            
            fiNames = fields(cs);
            
            for ind = 1:length(fiNames)
                fiName = fiNames{ind};
                fiVal  = cs.(fiName);
                
                res{length(res) + 1} = {fiName fiVal};
            end
        end
    end
    
end

