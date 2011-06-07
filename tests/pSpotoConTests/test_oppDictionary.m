function test_suite = test_oppDictionary
%test_oppDictionary  Unit tests for the Dictionary meta operator
initTestSuite;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
function test_oppDictionary_mixed
%%
   m = 10; nA = 20; nB = 20;
   A = opGaussian(m,nA);
   B = opBernoulli(m,nB);
   D = oppDictionary(A,B,1);
   
   x  = piCon(drandn(D,2));
   x2 = gather(x);
   y1 = A*x2(1:nA,:) + B*x2(nA+1:end,:);
   y2 = D*x;
   
   assertEqual(y1,y2);   
end

function test_oppDictionary_double
%%
   warning('off','pSpot:NoInput');
   G = opGaussian(3,5);
   E = opEye(3,4);
   R = iCon.randn(3,6);
   Z = opZeros(3,1);
   D = oppDictionary(G,E,[],R,Z);
   
   assertEqual( gather(double(D)), [double(G), double(E), double(R), double(Z)] )
   warning('on','pSpot:NoInput');
end

function test_oppDictionary_repeating
%% Repeating operators
N  = 3;
OP = randn(randi([2 5]),randi([2 5]));
for i = 1:N
    oplist{i} = OP;
end
S1 = oppDictionary(N,OP,1);
S2 =  opDictionary(oplist{:});
x1 = piCon(S1.drandn);
x2 = piCon(S1.rrandn);
y1 = S1*x1;
y2 = S2*gather(x1);
z1 = S1'*x2;
z2 = S2'*x2;
assertElementsAlmostEqual(y1,y2);
assertElementsAlmostEqual(z1,z2);
end % Repeating