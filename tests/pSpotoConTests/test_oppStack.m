function test_suite = test_oppStack
%test_oppStack  Unit tests for the Stack meta operator
initTestSuite;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
function test_oppStack_prod
%%
    A  = opGaussian(10,10);
    B  = opGaussian(20,10);
    D  = oppStack(A,B,1);
    E  = opStack(A,B);    
    x  = iCon(drandn(D,2));    
    assertElementsAlmostEqual(D*x, E*x);    
    x  = piCon(rrandn(D,2));
    x2 = gather(x);    
    assertElementsAlmostEqual(D'*x, E'*x2);
end

function test_oppStack_weights
%%
    m1 = 5; m2 = 4; n = 3;
    A1 = randn(m1,n);
    A2 = randn(m2,n);
    D  = oppStack([m2 m1],A1,A2,1);
    A1 = opMatrix(m2*A1);
    A2 = opMatrix(m1*A2);
    E  = opStack(A1,A2);
    x  = iCon(drandn(D,2));    
    assertElementsAlmostEqual(D*x, E*x);
    x  = piCon(rrandn(D,2));
    x2 = gather(x);
    assertElementsAlmostEqual(D'*x, E'*x2);
end
    
function test_oppStack_repeating
%% Repeating operators
N  = 3;
OP = randn(randi([2 5]),randi([2 5]));
for i = 1:N
    oplist{i} = OP;
end
S1 = oppStack(N,OP,1);
S2 =  opStack(oplist{:});
x1 = iCon(S1.drandn);
x2 = piCon(S1.rrandn);
y1 = S1*x1;
y2 = S2*x1;
z1 = S1'*x2;
z2 = S2'*gather(x2);
assertElementsAlmostEqual(y1,y2);
assertElementsAlmostEqual(z1,z2);
end % Repeating