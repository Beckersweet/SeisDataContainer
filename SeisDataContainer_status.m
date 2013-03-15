function status = SeisDataContainer_status()
%SEISDATACONTAINER_STATUS Returns true if SeisDataContainer_init has been
%run

global SDCglobalTmpDir
status = isdir(SDCglobalTmpDir);