%% Data Container Demo

%% Example: Convolve every trace of a seismic datacube with a fixed signal
% Create datacube x, and fixed signal s
n1 = 128; % time samples
n2 = 20; % trace-per-gather
n3 = 12; % shot gathers

% Create a random 3d-array x that is distributed along 3rd dimension
x  = iCon.randn(n1,n2,n3);
    
% Use FFT for the convolution, create the FFT operators
F  = opDFT(n1);
I1 = opDirac(n2);
I2 = opDirac(n3);

% Create fixed signal s
s  = iCon.randn(n1,1);
S  = opDiag(F*s);

% Create the per-trace convolution operator
C  = opKron(I2,I1,F'*S*F); % Kronecker product of a convolution operator and an identity over all the traces

% Apply the convolution by a simple multiplication
x_convolved = C * vec(x);
size(x_convolved)

% Reform!!!
x_invveced = invvec(x_convolved);
size(x_invveced)

%% 2D Curvelet
% Setup 2D data
n1    = 64;
n2    = 32;
x     = iCon.randn(n1,n2);
x     = vec(x); % Vectorize it
size(x) % size of vectorized x
C     = opCurvelet(n1,n2);
y     = C*x; % Multiply
x_est = C \ y; % Inverse
x_est = invvec(x_est); % Reform into original dimensions
size(x_est)

%% 3D Curvelet
% Setup 3D data
n1    = 128;
n2    = 64;
n3    = 32;
x     = iCon.randn(n1,n2,n3);
x     = vec(x); % Vectorize it
size(x) % size of vectorized x
C     = opCurvelet3d(n1,n2,n3);
y     = C*x;
x_est = C \ y;
x_est = invvec(x_est);
size(x_est)

%% Permutation
n1    = 128;
n2    = 64;
n3    = 32;
x     = iCon.randn(n1,n2,n3);
x = permute(x,[3,2,1]);
size(x)
x = invpermute(x);
size(x)