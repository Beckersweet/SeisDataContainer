function y = getFile(obj,subs)
%GETDATA is called whenever we try to access data via subreferencing
%
%   getFile(x,s)
%
%   x - An oMatCon object
%   s - Subreferences cell
%

if (length(subs) == 1 && isnumeric(cell2mat(subs(1))))
    error('Error: Single element indexing is not allowed in oMatCon')
elseif (length(subs) == 1 && cell2mat(subs(1)) == ':')
    y = vec(obj);
else
    i = 0;
    while(cell2mat(subs(i+1)) == ':')
        i = i+1; % i is first index of non-":" index
    end

    chunk = cell2mat(subs(i+1));   % chunk refers to cases of x(:,i:j)
    chunk = [chunk(1) chunk(end)]; % basically getting i and j here

    if(length(subs)>=i+2) % slice is for cases of x(:,k)
        slice = cell2mat(subs(i+2:end)); % But sometimes they mix, see
    else
        slice = [];
    end

    % this gives us Matlab array
    y = SDCpckg.io.NativeBin.serial.FileReadLeftChunk...
        (path(obj.pathname),[chunk(1) chunk(end)],slice);

    % returning the result as iCon
    y = iCon(y);
end
