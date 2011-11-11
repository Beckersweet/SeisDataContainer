function disp(x)
%DISP Display array.
%   DISP(X) displays the array, without printing the array name.  In
%   all other ways it's the same as leaving the semicolon off an
%   expression except that empty arrays don't display.
    if(dims(x)<20)
        fprintf('oMatCon dataContainer\n\n');
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
        fprintf('Interval:    [');
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

