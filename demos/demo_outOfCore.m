%% Kronecker product testing
% Setup vector
x = oMatCon.randn(3,2);
x = x(:)
A = opoKron(opDFT(2),opDFT(3)) % Out of core kron operator
B = opoKronLow(opDFT(2),opDFT(3)) % Low level out of core kron operator
C = opKron(opDFT(2),opDFT(3)) % Spot kron for reference

double(A*x(:))
double(B*x(:))
C*double(x(:))

%%