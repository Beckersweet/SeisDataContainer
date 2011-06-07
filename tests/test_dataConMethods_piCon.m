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

x = piCon.randn(n1,n2,n3);

end % setup

function test_dataConMethods_piCon_abs(x)
    abs(x);
end

function test_dataConMethods_piCon_end(x)
    x(1:end);
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
    norm(x(:),2);
    norm(x,'fro');
end

function test_dataConMethods_piCon_invvec(x)
    invvec(x);
end

function test_dataConMethods_piCon_setImDims(x)
    setImDims(x,isize(x));
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