%% Cool stuffs you can do with parallel in-core data container (piCon)

%% Example 1: Setting up a randn array with your desired distribution config
% Before:
spmd
    x       = codistributed.randn(100,1,1); % Create codistributed data
    xpart   = [1 zeros(1,numlabs-1)]; % Setting up codistributor partition
    xgsize  = [100 1 1]; % Setting up global size
    xcodist = codistributor1d(3,xpart,xgsize); % Create codistributor
    x       = redistribute(x,xcodist); % Redistribute
end

% Now:
x = piCon.randn(100,1,1); % Create piCon
x = redistribute(x,3); % Redistribute. That's it
x.codistInfo % Displays information about codistribution