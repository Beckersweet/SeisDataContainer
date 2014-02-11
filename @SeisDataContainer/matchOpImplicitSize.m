function outVec = matchOpImplicitSize(vec,op)
%MATCHIMSIZE creates an iCon vector that matches the dimensionality with
%the operator.
%
% NOTE: TODO: need to work on origin, delta, label, and unit. Right now
% only explicit size and implicit size are working

outVec = vec;

opNs = spot.utils.uncell(op.ns);

if ~(size(vec,1) == prod(opNs))
    error('dimension of vector do not match the operator')
end

outVec.header.size = opNs;
outVec.exsize = [1; length(opNs)];
outVec.header.dims = length(opNs);

end

