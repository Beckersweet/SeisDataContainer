function disp(x)
%DISP Display function for all dataContainers.
%   DISP(X) displays the header of our dataContainer and not the data
%   itself. Displaying a dataContainer with default header values for double
%   real serial array looks like:
%
%   iCon dataContainer
%
%   Variable Name:     unknown
%   Variable Units:    unknown
%   Dims:              n
%   Size:              [ S1 S2 ... Sn]
%   Origin:            [ O1 O2 ... On]
%   Delta:             [ D1 D2 ... Dn]
%   Label:             [ L1 L2 ... Ln]
%   Unit:              [ U1 U2 ... Un]
%   Precision:         double
%   Complex:           No
%   Distributed:       No

if(dims(x)<20)
    fprintf(class(x));
    fprintf(' dataContainer\n\n');
    fprintf('Variable Name:     ');
    fprintf('%c',varName(x));
    fprintf('\n');
    fprintf('Variable Units:    ');
    fprintf('%c',varUnits(x));
    fprintf('\n');
    fprintf('Dims:             ');
    fprintf(' %d\n',dims(x));
    fprintf('Size:              [');
    fprintf(' %d',size(x));
    fprintf(' ]\n');
    fprintf('Origin:            [');
    fprintf(' %d',origin(x));
    fprintf(' ]\n');
    fprintf('Delta:             [');
    fprintf(' %d',delta(x));
    fprintf(' ]\n');
    fprintf('Label:             [ ');
    labels = label(x);
    for i=1:length(labels)
        fprintf('%c',labels{i});
        fprintf(' ');
    end
    fprintf(']\n');
    fprintf('Unit:              [ ');
    units = unit(x);
    for i=1:length(units)
        fprintf('%c',units{i});
        fprintf(' ');
    end
    fprintf(']\n');
    fprintf('Precision:         ');
    fprintf('%c',precision(x));
    fprintf('\n');
    fprintf('Complex:           ');
    if(~isreal(x))
        fprintf('Yes\n');
    else
        fprintf('No\n');
    end
    fprintf('Distributed:       ');
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

