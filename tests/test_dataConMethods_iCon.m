function test_suite = test_dataConMethods_iCon
%MOTHERCLASSROUTINES  Function to tell if mother really loves you
%
%   motherClassRoutines(x) will run data container subclass x through all
%   the functions available in the mother class thoroughly to test them.
initTestSuite;
end

function x = setup
% Setup
n1 = 4;
n2 = 3;
n3 = 2;

x = iCon(randn(n1,n2,n3),'delta',[5,6,7],'unit',{'m','kg','N'});

end % setup

function test_dataConMethods_iCon_abs(x)
    abs(x);
end

function test_dataConMethods_iCon_end(x)
% Currently only per-dimension indexing is supported
    x(1:end,1:end,1:end);
end

function test_dataConMethods_iCon_isempty(x)
    isempty(x);
end

function test_dataConMethods_iCon_isize(x)
    isize(x);
end

function test_dataConMethods_iCon_isnumeric(x)
    isnumeric(x);
end

function test_dataConMethods_iCon_issparse(x)
    issparse(x);
end

function test_dataConMethods_iCon_isreal(x)
    isreal(x);
end

function test_dataConMethods_iCon_isscalar(x)
    isscalar(x);
end

function test_dataConMethods_iCon_length(x)
    length(x);
end

function test_dataConMethods_iCon_ndims(x)
    ndims(x);
end

function test_dataConMethods_iCon_norm(x)
    norm(x(:),1);
    norm(x(:));
    norm(x,'fro');
end

function test_dataConMethods_iCon_invec(x)
    invvec(x);
end

function test_dataConMethods_iCon_setImDims(x)
% setImDims
    setImSize(x,isize(x));
end

function test_dataConMethods_iCon_size(x)
    size(x);
end

function test_dataConMethods_iCon_subsref(x)
% Pending new and relevant test for subsref

%     x = x(:);
%     try
%         x(2:end-1); % UNALLOWABLE CASE: MUST FAIL
%         error('iCon:subsref:HORRIBLE','Indexing catch failed!');
%     catch ME
%         if strcmp(ME.identifier, 'iCon:subsref:HORRIBLE')
%             rethrow(ME);
%         end
%     end
%     
%     x = iCon(double(x)); % Check for implicitly vectored case
%     x(2:end-1);
end

function test_dataConMethods_iCon_unpermute(x)
    invpermute(x);
end

function test_dataConMethods_iCon_vec(x)
    vec(x);
end

function test_dataConMethods_iCon_delta(x)
    assertEqual(delta(x),[5,6,7]);
    
    assertEqual(delta(x,2),6);
    assertEqual(delta(x,3),7);
    assertEqual(delta(x,1),5);
    
    assertEqual(delta(x,2,3),[6,7]);
    assertEqual(delta(x,1,3),[5,7]);
    assertEqual(delta(x,2,1),[6,5]);
    
    assertEqual(delta(x,2,1,3),[6,5,7]);
end

function test_dataConMethods_iCon_unit(x)
    assertEqual(unit(x),{'m','kg','N'});
    
    assertEqual(unit(x,2),{'kg'});
    assertEqual(unit(x,1),{'m'});
    assertEqual(unit(x,3),{'N'});
    
    assertEqual(unit(x,2,3),{'kg','N'});
    assertEqual(unit(x,3,1),{'N','m'});
    assertEqual(unit(x,2,1),{'kg','m'});
    
    assertEqual(unit(x,2,3,1),{'kg','N','m'});
end