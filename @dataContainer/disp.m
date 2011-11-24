function disp(x)
%DISP Display function for all dataContainers.
%   DISP(X) displays the header of our dataContainer and not the data
%   itself. Displaying a dataContainer with default header values looks
%   like:
%
%
%   iCon dataContainer
%
%   Variable:    unknown
%   Dims:        2
%   Size:        [ 1 2 3 4 5 ...]
%   Origin:      [ 0 0 0 0 0 ...]
%   Delta:       [ 1 1 1 1 1 ...]
%   Label:       [ l1 l2 l3 l4 l5 ...]
%   Unit:        [ u1 u2 u3 u4 u5 ...]
%   Precision:   double
%   Complex:     No
%   Distributed: No

if(dims(x)<20)
    fprintf(class(x));
    fprintf(' dataContainer\n\n');
    fprintf('Variable:    ');
    fprintf('%c',variable(x));
    fprintf('\n');
    fprintf('Dims:       ');
    fprintf(' %d\n',dims(x));
    fprintf('Size:        [');
    fprintf(' %d',size(x));
    fprintf(' ]\n');
    fprintf('Origin:      [');
    fprintf(' %d',origin(x));
    fprintf(' ]\n');
    fprintf('Delta:       [');
    fprintf(' %d',delta(x));
    fprintf(' ]\n');
    fprintf('Label:       [ ');
    labels = label(x);
    for i=1:dims(x)
        fprintf('%c',labels{i});
        fprintf(' ');
    end
    fprintf(']\n');
    fprintf('Unit:        [ ');
    units = unit(x);
    for i=1:dims(x)
        fprintf('%c',units{i});
        fprintf(' ');
    end
    fprintf(']\n');
    fprintf('Precision:   ');
    fprintf('%c',precision(x));
    fprintf('\n');
    fprintf('Complex:     ');
    if(~isreal(x))
        fprintf('Yes\n');
    else
        fprintf('No\n');
    end
    fprintf('Distributed: ');
    if(isdistributed(x))
        fprintf('Yes\n');
    else
        fprintf('No\n');
    end

else
    disp('Wrning: The current dimension limit for displaying is 20');
    disp('    Use semicolon (;)  to avoid seeing this message');
end
end

