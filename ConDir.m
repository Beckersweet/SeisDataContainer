classdef (Sealed=true) ConDir < handle
%   ConDir(varargin) handle object holding unique temporary directory
% 
%   obj = ConDir()
%       obj.Path holds new directory created inside of the directory defined by
%       SDCglobalTmpDir (see SeisDataContainer_init.m)
%   obj = ConDir(PARENT)
%       obj.Path holds new directory created inside of PARENT directory.
%
%   Note! obj.Path is deleted when obj is dereferenced or deleted.
%

    properties (Access = private)
        Path = nan;
        Home = nan;
        Keep = false;
        %verbose = false;
    end

    methods ( Access = public )
        function td = ConDir(varargin)
            error(nargchk(0, 3, nargin, 'struct'));
            if nargin > 1
                error(nargchk(3, 3, nargin, 'struct'));
                assert(strcmp(varargin{2},'keep'));
                assert(islogical(varargin{3}));
                assert(ischar(varargin{1}));
                td.Keep = varargin{3};
                td.Path = varargin{1};
                % could be exist(td)
                assert(isdir(td.Path));
                td.Home = fileparts(varargin{1});
            else
                [td.Path td.Home] = DataContainer.io.makeDir(varargin{:});
            end
            %if td.verbose; disp(['ConDir in constructor for ' td.Path]); end;
        end
        function e = exist(td);
            e = isdir(td.Path);
        end
        function p = path(td)
            p = td.Path;
        end
        function h = home(td)
            h = td.Home;
        end
        function disp(td)
            fprintf('Temporary home directory is %s\n', td.Home);
            fprintf('Temporary directory is %s\n', td.Path);
        end
        function dir(td)
            fprintf('Content of directory %s:\n', td.Path);
            ls('-lR',td.Path);
        end
    end

    methods ( Access = private )
        function delete(td)
            if ~td.Keep
                assert(isdir(td.Home),'Fatal error: home directory %s is missing',td.Home);
                assert(isdir(td.Path),'Fatal error: directory %s is missing',td.Path);
                rmdir(td.Path,'s');
                %if td.verbose; disp(['ConDir: in destructor for ' td.Path]); end;
            end
        end
    end

end
