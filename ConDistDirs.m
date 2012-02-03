classdef (Sealed=true) ConDistDirs < handle
%   ConDistDirs(varargin) handle object holding unique temporary directory
% 
%   obj = ConDistDirs()
%       obj.Paths holds new directory created inside of the directory defined by
%       SDCglobalTmpDir (see SeisDataContainer_init.m)
%   obj = ConDistDirs(PARENT)
%       obj.Paths holds new directory created inside of PARENT directory.
%
%   Note! obj.Paths is deleted when obj is dereferenced or deleted.
%

    properties (Access = private)
        Paths = nan;
        Home = nan;
        Keep = false;
        %verbose = false;
    end

    methods ( Access = public )
        function td = ConDistDirs(varargin)
            error(nargchk(0, 3, nargin, 'struct'));
            if nargin > 1
                error(nargchk(3, 3, nargin, 'struct'));
                assert(strcmp(varargin{2},'keep'));
                assert(islogical(varargin{3}));
                assert(iscell(varargin{1}));
                td.Keep = varargin{3};
                td.Paths = varargin{1};
                td.Home = fileparts(varargin{1}{1});
                % could be exist(td)
                tdHome = td.Home;
                tdPaths = SeisDataContainer.utils.Cell2Composite(td.Paths);
                spmd
                    assert(isdir(tdHome));
                    assert(isdir(tdPaths));
                end
            else
                [td.Paths td.Home] = SeisDataContainer.io.makeDistDir(varargin{:});
            end
            %if td.verbose; disp(['ConDistDirs in constructor for ' td.Paths]); end;
        end
        function e = exist(td)
            tdPaths = SeisDataContainer.utils.Cell2Composite(td.Paths);
            spmd
                e = isdir(tdPaths);
            end
        end
        function p = path(td)
            p = td.Paths;
        end
        function h = home(td)
            h = td.Home;
        end
        function disp(td)
            fprintf('Temporary home directory is %s\n', td.Home);
            for i=1:length(td.Paths)
                fprintf('Lab %4d: Temporary directory is %s\n', i, td.Paths{i});
            end
        end
        function dir(td)
            tdPaths = SeisDataContainer.utils.Cell2Composite(td.Paths);
            spmd
                fprintf('Content of directory %s:\n', tdPaths);
                ls('-lR',tdPaths);
            end
        end
    end

    methods ( Access = private )
        function delete(td)
        if ~td.Keep
            assert(isdir(td.Home),'Fatal error: home directory %s is missing',td.Home);
            tdPaths = SeisDataContainer.utils.Cell2Composite(td.Paths);
            spmd
                assert(isdir(tdPaths),'Fatal error: directory %s is missing',tdPaths);
            end
            SeisDataContainer.io.deleteDistDir(td.Paths)
            %if td.verbose; disp(['ConDistDirs: in destructor for ' td.Paths]); end;
        end
        end
    end

end
