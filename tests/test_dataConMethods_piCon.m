function test_suite = test_dataConMethods_piCon
%MOTHERCLASSROUTINES  Function to tell if mother really loves you
%
%   motherClassRoutines(x) will run data container subclass x through all
%   the functions available in the mother class thoroughly to test them.
initTestSuite;
end

function x = setup
n1 = randi([2 5]);
n2 = randi([2 5]);
n3 = randi([2 5]);

x = piCon(randn(n1,n2,n3),'delta',[5,6,7],'unit',{'m','kg','N'});

end % setup

function test_dataConMethods_piCon_abs(x)
    abs(x);
end

function test_dataConMethods_piCon_end(x)
    x(1:end,1:end,1:end);
end

function test_dataConMethods_piCon_isempty(x)
    isempty(x);
end

function test_dataConMethods_piCon_isize(x)
    isize(x);
end

function test_dataConMethods_piCon_isnumeric(x)
    isnumeric(x);
end

function test_dataConMethods_piCon_issparse(x)
    issparse(x);
end

function test_dataConMethods_piCon_isreal(x)
    isreal(x);
end

function test_dataConMethods_piCon_isscalar(x)
    isscalar(x);
end

function test_dataConMethods_piCon_length(x)
    length(x);
end

function test_dataConMethods_piCon_ndims(x)
    ndims(x);
end

function test_dataConMethods_piCon_norm(x)
    norm(x(:),1);
    norm(x(:));
    norm(x,'fro');
end

function test_dataConMethods_piCon_invvec(x)
    invvec(x);
end

function test_dataConMethods_piCon_setImDims(x)
    setImSize(x,isize(x));
end

function test_dataConMethods_piCon_size(x)
    size(x);
end

function test_dataConMethods_piCon_unpermute(x)
    invpermute(x);
end

function test_dataConMethods_piCon_vec(x)
    vec(x);
end

function test_dataConMethods_piCon_delta(x)
    assertEqual(delta(x),[5,6,7]);
    
    assertEqual(delta(x,2),6);
    assertEqual(delta(x,3),7);
    assertEqual(delta(x,1),5);
    
    assertEqual(delta(x,2,3),[6,7]);
    assertEqual(delta(x,1,3),[5,7]);
    assertEqual(delta(x,2,1),[6,5]);
    
    assertEqual(delta(x,2,1,3),[6,5,7]);
end

function test_dataConMethods_piCon_unit(x)
    assertEqual(unit(x),{'m','kg','N'});
    
    assertEqual(unit(x,2),{'kg'});
    assertEqual(unit(x,1),{'m'});
    assertEqual(unit(x,3),{'N'});
    
    assertEqual(unit(x,2,3),{'kg','N'});
    assertEqual(unit(x,3,1),{'N','m'});
    assertEqual(unit(x,2,1),{'kg','m'});
    
    assertEqual(unit(x,2,3,1),{'kg','N','m'});
end
