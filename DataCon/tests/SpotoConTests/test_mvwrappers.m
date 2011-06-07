function test_suite = test_mvwrappers
initTestSuite;

function test_mvwrappers_opConj
%% Test for opConj
m  = randi(100);
n  = randi(100);
a  = iCon.randn(m,n) + 1i*iCon.randn(m,n);
A1 = opConj(opMatrix(a));
A2 = conj(a);
x  = iCon.randn(n,m) + 1i*iCon.randn(n,m);

assertEqual(A1*x, A2*x);

function test_mvwrappers_opCTranspose
%% Test for opCTranspose
m  = randi(100);
n  = randi(100);
a  = iCon.randn(m,n) + 1i*iCon.randn(m,n);
A1 = opMatrix(a)';
A2 = a';
x  = iCon.randn(m,n) + 1i*iCon.randn(m,n);

assertElementsAlmostEqual(A1*x, A2*x);

function test_mvwrappers_opTranspose
%% Test for opTranspose
m  = randi(100);
n  = randi(100);
a  = iCon.randn(m,n) + 1i*iCon.randn(m,n);
A1 = opMatrix(a).';
A2 = a.';
x  = iCon.randn(m,n) + 1i*iCon.randn(m,n);

assertElementsAlmostEqual(A1*x, A2*x);

function test_mvwrappers_opSum
%% Test for opSum
m  = randi(100);
n  = randi(100);
a1 = iCon.randn(m,n) + 1i*iCon.randn(m,n);
a2 = iCon.randn(m,n) + 1i*iCon.randn(m,n);
A1 = opMatrix(a1) + opMatrix(a2);
A2 = a1 + a2;
x  = iCon.randn(n,m) + 1i*iCon.randn(n,m);

assertElementsAlmostEqual(A1*x, A2*x);

function test_mvwrappers_opMinus
%% Test for opMinus
m  = randi(100);
n  = randi(100);
a1 = iCon.randn(m,n) + 1i*iCon.randn(m,n);
a2 = iCon.randn(m,n) + 1i*iCon.randn(m,n);
A1 = opMatrix(a1) - opMatrix(a2);
A2 = a1 - a2;
x  = iCon.randn(n,m) + 1i*iCon.randn(n,m);

assertElementsAlmostEqual(A1*x, A2*x);