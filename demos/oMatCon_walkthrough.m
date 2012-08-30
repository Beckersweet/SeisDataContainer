%% oMatCon Walkthrough
% A concise guide to the functionality and guts of the oMatCon Out-of-Core
% Native Binary Data Container.

%% Basic Usage
% The oMatCon data container is designed to open external files stored in
% hard drives and load them in as a Matlab object, and exposing as little
% as possible the low level complexities and tinkering needed for such a
% maneuver to work. For example:

% Here we have a preconfigured data file stored in native binary format
% stored in the specified directory:
directory = [SDCpckg.path 'demos' filesep 'data' filesep 'data1']

%%
% Loading the file as an oMatCon datacontainer
x = oMatCon.load(directory)

%%
% Accessing the data contained
double(x)