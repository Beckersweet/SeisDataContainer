function x = load(dirname,varargin)
%OMATCON.LOAD Loads the file as an oMatCon
%
%   LOAD(DIRNAME,PARAM1,VALUE1,PARAM2,VALUE2,...)
%
%   DIRNAME  - Input directory name
%
%   Addtional parameters include:
%   READONLY - 1 makes the data container readonly and 0 otherwise
%   COPY     - 1 creates a copy of the file when loading, otherwise 
%                changes will be made on the existing file 
    if(~isa(dirname,'ConDir'))
        pathname = ConDir(dirname,'keep',true);
    else
        pathname = dirname;
    end
    x = oMatCon(pathname,varargin{:});
end
