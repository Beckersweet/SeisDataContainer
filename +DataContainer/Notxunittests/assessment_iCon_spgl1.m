function test_suite = assessment_iCon_spgl1
%% Testing iCon with spgl1
A = opGaussian(50,100);
x = sprandn(100,1,.1);
b = A*x;

tic, y1 = spgl1(A,b); toc
tic, y2 = spgl1(A,iCon(b)); toc

assertEqual(norm(y1-x), norm(y2-x));


end

function test_iCon_lsqr
%% lsqr
A = opGaussian(500,100);
x = sprandn(100,1,.1);
b = A*x;

tic, y1 = lsqr(A,b); toc
tic, y2 = lsqr(A,iCon(b)); toc

assertEqual(norm(y1-x), norm(y2-x));
end

function test_iCon_spot_lsqr
%% spot lsqr
A = opGaussian(500,100);
x = sprandn(100,1,.1);
b = A*x;

[m,n] = size(A);
opts = spotparams;
maxits = opts.cgitsfact * min(m,min(n,20));
tic,
y1 = spot.solvers.lsqr(m,n,A,b, ...
    opts.cgdamp,opts.cgtol,opts.cgtol,opts.conlim,maxits,opts.cgshow); toc
tic,
y2 = spot.solvers.lsqr(m,n,A,iCon(b), ...
    opts.cgdamp,opts.cgtol,opts.cgtol,opts.conlim,maxits,opts.cgshow); toc

assertEqual(norm(y1-x), norm(y2-x));
end