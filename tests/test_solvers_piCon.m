function test_suite = test_solvers_piCon
initTestSuite;
end

function test_solvers_piCon_spql1
%% Testing piCon with spgl1
% A = opGaussian(50,100);
% x = sprandn(100,1,.1);
% b = A*x;
% options.verbosity = 0;
% tic, y1 = spgl1(A,b,[],[],[],options); toc
% tic, y2 = spgl1(A,piCon(b),[],[],[],options); toc
% 
% assertEqual(norm(y1-x), norm(y2-x));

% this spgl1 solver does not support distributed data

end

function test_solvers_piCon_lsqr
%% lsqr
% A = opGaussian(500,100);
% x = sprandn(100,1,.1);
% b = A*x;
% 
% tic, y1 = lsqr(A,b); toc
% tic, y2 = lsqr(A,piCon(b)); toc
% 
% assertEqual(norm(y1-x), norm(y2-x));

% This lsqr solver does not support distributed data
end

function test_solvers_piCon_spot_lsqr
%% spot lsqr
% A = opGaussian(500,100);
% x = sprandn(100,1,.1);
% b = A*x;
% 
% [m,n] = size(A);
% opts = spotparams;
% maxits = opts.cgitsfact * min(m,min(n,20));
% tic,
% y1 = spot.solvers.lsqr(m,n,A,b, ...
%     opts.cgdamp,opts.cgtol,opts.cgtol,opts.conlim,maxits,opts.cgshow); toc
% tic,
% y2 = spot.solvers.lsqr(m,n,A,piCon(b), ...
%     opts.cgdamp,opts.cgtol,opts.cgtol,opts.conlim,maxits,opts.cgshow); toc
% 
% assertEqual(norm(y1-x), norm(y2-x));

% This lsqr solver does not support distributed data
end