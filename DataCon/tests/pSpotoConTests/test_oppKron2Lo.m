function test_suite = test_oppKron2Lo
    initTestSuite;
end

function test_oppKron2Lo_emptylabs
%% Test for empty labs
% Setup x
x = piCon.randn(100,1);
x = redistribute(x,3);
A = opDFT(100);
K = oppKron2Lo(opDirac(1),A);
y = K*vec(x);
end % empty labs

function test_oppKron2Lo_dirac
%% Test for Dirac-skipping functionality
m  = randi(100);
n  = randi(100);
A  = opDirac(m);
B  = opDFT(n);
x  = vec(redistribute(piCon.randn(n,m),2));
A2 = A;
A2.isDirac = false;

% Dirac-Skipping
K1 = oppKron2Lo(A,B,1);

% Non-Skipping
K2 = oppKron2Lo(A2,B,1);

y1 = K1*x; 
y2 = K2*x; 

assertEqual(y1,y2);
end % dirac

function test_oppKron2Lo_dirac_special
%% Dirac special
% Strange case encountered by Tristan
A  = randn(10,51);
K1 = opKron(opDirac(4),opKron(A,opDirac(101)));
K2 = oppKron2Lo(opDirac(4),opKron(A,opDirac(101)),1);
x1 = iCon.randn(5151,4);
x2 = distributed(x1);
y1 = K1*vec(x1);
y2 = K2*vec(x2);
assertEqual(y1,y2);
end % dirac special

function test_oppKron2Lo_FoG
%% FoG
m  = randi([2 10]);
A  = opDFT(m);
B  = opDFT(m*m);
K1 = B*opKron(A,A)*B;
K2 = B*oppKron2Lo(A,A,1)*B;
x  = iCon(K1.drandn);
assertElementsAlmostEqual(K1*x, K2*x);
end % FoG