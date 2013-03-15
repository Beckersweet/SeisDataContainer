function test_suite = test_solvers_iCon
initTestSuite;
end

function test_solvers_iCon_spql1
%% Testing iCon with spgl1
A = opGaussian(50,100);
x = sprandn(100,1,.1);
b = A*x;
options.verbosity = 0;
% tic, 
y1 = spgl1(A,b,[],[],[],options); 
% toc;
% tic, 
y2 = spgl1(A,iCon(b),[],[],[],options); 
% toc;

assertEqual(norm(y1-x), norm(y2-x));

end

function test_solvers_iCon_lsqr
%% lsqr
A = opGaussian(500,100);
x = sprandn(100,1,.1);
b = A*x;

% tic, 
[y1, silence] = lsqr(A,b); 
% toc;
% tic, 
[y2, silence] = lsqr(A,iCon(b));
% toc;

assertEqual(norm(y1-x), norm(y2-x));
end

function test_solvers_iCon_spot_lsqr
%% spot lsqr
A = opGaussian(500,100);
x = sprandn(100,1,.1);
b = A*x;

[m,n] = size(A);
opts = spotparams;
maxits = opts.cgitsfact * min(m,min(n,20));
% tic,
[y1,silence] = spot.solvers.lsqr(m,n,A,b, ...
    opts.cgdamp,opts.cgtol,opts.cgtol,opts.conlim,maxits,opts.cgshow); 
% toc;
% tic,
[y2, silence] = spot.solvers.lsqr(m,n,A,iCon(b), ...
    opts.cgdamp,opts.cgtol,opts.cgtol,opts.conlim,maxits,opts.cgshow); 
% toc;

assertEqual(norm(y1-x), norm(y2-x));
end