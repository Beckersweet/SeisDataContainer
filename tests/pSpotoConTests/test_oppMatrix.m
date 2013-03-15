function test_suite = test_oppMatrix
% test_oppMatrix  Unit tests for the oppMatrix operator
initTestSuite;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function test_oppMatrix_builtin
%% Built-in tests for oppMatrix
m = randi(10); n = randi(10);
a = piCon.randn(m,n);
A = oppMatrix(a);
utest(A,3);

end % builtin

function test_oppMatrix_multiply
%% Multiplication test for oppMatrix
% There is a minor error between undistributed and distributed matrix
% multiplications because of the distributed nature of the distributed
% matrices. Error is in the order of e-15 so it is ok. We will just use
% assertElementsAlmostEqual
m  = 4; n = 3;
A1 = iCon.randn(m,n);
A2 = oppMatrix(distributed(A1));
x1 = iCon([A2.drandn A2.drandn]);
y1 = A1*x1;
y2 = A2*x1;
assertElementsAlmostEqual(y1,gather(y2));

x2 = iCon([A2.rrandn A2.rrandn]);
z1 = A1'*x2;
z2 = A2'*x2;
assertElementsAlmostEqual(z1,gather(z2));

end % multiply

function test_oppMatrix_basis_rn
%% Test for oppMatrix so that it generates the correct result
m  = 4; n = 3;
A1 = iCon.randn(m,n);
A2 = oppMatrix(distributed(A1));
x  = eye(n);

assertEqual(gather(A2*x),A1);
end % basis

function test_oppMatrix_divide
%% test for divide of oppMatrix
% distributed matrix only supports left divide of square matrices
n  = 3;
A1 = piCon.randn(n);
A2 = oppMatrix(A1);
x  = piCon(A2.drandn);
y  = A1*x;

assertElementsAlmostEqual(gather(A2\y),gather(x));
end % divide

function test_oppMatrix_plus
%% test for plus of oppMatrix
m  = 4; n = 3;
A1 = piCon.randn(m,n);
A2 = oppMatrix(A1);
B  = randn(m,n);
y1 = A1 + B;
y2 = A2 + B;
assertEqual(double(y1),double(y2));
end % plus

function test_oppMatrix_minus
%% test for minus of oppMatrix
m  = 4; n = 3;
A1 = piCon.randn(m,n);
A2 = oppMatrix(A1);
B  = randn(m,n);
y1 = A1 - B;
y2 = A2 - B;
z  = zeros(m,n);
q  = y1 - double(y2);
if isdistributed(q), q = gather(q); end
assertEqual(z,q);
end % minus