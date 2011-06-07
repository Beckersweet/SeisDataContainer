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
m  = randi(100); n = randi(100);
A1 = iCon.randn(m,n);
A2 = oppMatrix(distributed(A1));
x1 = iCon([A2.drandn A2.drandn]);
y1 = A1*x1;
y2 = A2*x1;
assertElementsAlmostEqual(y1,y2);

x2 = iCon([A2.rrandn A2.rrandn]);
z1 = A1'*x2;
z2 = A2'*x2;
assertElementsAlmostEqual(z1,z2);

end % multiply

function test_oppMatrix_basis_rn
%% Test for oppMatrix so that it generates the correct result
m  = randi(100); n = randi(100);
A1 = iCon.randn(m,n);
A2 = oppMatrix(distributed(A1));
x  = eye(n);

assertEqual(A2*x,A1);
end % basis

function test_oppMatrix_divide
%% test for divide of oppMatrix
% distributed matrix only supports left divide of square matrices
n  = randi(100);
A1 = randn(n);
A2 = oppMatrix(distributed(A1));
x  = iCon(A2.drandn);
y  = A1*x;

assertElementsAlmostEqual(A2\y,x);
end % divide

function test_oppMatrix_plus
%% test for plus of oppMatrix
m  = randi(100); n = randi(100);
A1 = iCon.randn(m,n);
A2 = oppMatrix(distributed(A1));
B  = iCon.randn(m,n);
y1 = A1 + B;
y2 = A2 + B;
z  = zeros(m,n);
assertEqual(y1,gather(y2));
end % plus

function test_oppMatrix_minus
%% test for minus of oppMatrix
m  = randi(100); n = randi(100);
A1 = iCon.randn(m,n);
A2 = oppMatrix(distributed(A1));
B  = iCon.randn(m,n);
y1 = A1 - B;
y2 = A2 - B;
z  = zeros(m,n);
q  = y1 - double(y2);
if isdistributed(q), q = gather(q); end
assertEqual(z,q);
end % minus