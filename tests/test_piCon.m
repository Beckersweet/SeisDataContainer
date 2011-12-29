function test_suite = test_piCon
initTestSuite;
end

function test_piCon_conj
%% conj
n1 = randi(10);
n2 = randi(10);
A  = randn(n1,n2) + 1i*randn(n1,n2);
A  = distributed(A);
assertEqual(conj(A),double(conj(piCon(A))));
end % conj

function test_piCon_ctranspose
%% ctranspose
n1 = randi(10);
n2 = randi(10);
A  = randn(n1,n2) + 1i*randn(n1,n2);
A  = distributed(A);
B  = piCon(A);
assertEqual(A',double(B'));
end % ctranspose

function test_piCon_horzcat
%% horzcat
n1 = randi(10);
n2 = randi(10);
A  = randn(n1,n2) + 1i*randn(n1,n2);
A  = distributed(A);
B  = piCon(A);
assertEqual( [A A], double([B B]) );
end % horzcat

function test_piCon_imag
%% horzcat
n1 = randi(10);
n2 = randi(10);
A  = randn(n1,n2) + 1i*randn(n1,n2);
A  = distributed(A);
B  = piCon(A);
assertEqual( imag(A), double( imag(B) ) );
end % horzcat

function test_piCon_inputParser
%% inputParser
y = piCon.randn(3,3,3,'varName','Velocity','varUnits','m/s','label',...
    {'source1' 'source1' 'source1'},'unit',{'m/s' 'm/s^2' 'm/s'});

assertEqual(varName(y),'Velocity');
assertEqual(varUnits(y),'m/s');
assertEqual(label(y),{'source1' 'source1' 'source1'});
assertEqual(unit(y),{'m/s' 'm/s^2' 'm/s'});

% saving the dataContainer
td = ConDir();
y.save(path(td),1);

% testing the header attributes after loading
w = piCon.load(path(td));
DataContainer.isequalHeaderStruct(y.header,w.header)
end % inputParser

% function test_piCon_inv
% %% inv
% n1 = randi(10);
% n2 = n1;
% A  = distributed( randn(n1,n2) + 1i*randn(n1,n2) );
% assertEqual( inv(piCon(A)), inv(A) );
% end % inv not supported in distributed

function dtest_piCon_ldivide
%% ldivide
n1 = randi(10);
n2 = randi(10);
A  = randn(n1,n2) + 1i*randn(n1,n2);
B  = randn(n1,n2) + 1i*randn(n1,n2);
A  = distributed(A);
B  = distributed(B);
C  = A .\ B;
assertEqual( double( piCon(A) .\ B ), C);
assertEqual( double( A .\ piCon(B) ), C); % EXTREME DANGER cuz
% distributed class does not know how to handle piCon. NOT ANYMORE CUZ I
% SPECIFIED DISTRIBUTED AS INFERIOR CLASS NYAHAHAHAHAHAHAHAHAHA~~~~~~
assertEqual( double( piCon(A) .\ piCon(B) ), C);
end % ldivide

function test_piCon_minus
%% minus
n1 = randi(10);
n2 = randi(10);
A  = distributed( randn(n1,n2) + 1i*randn(n1,n2) );
B  = distributed( randn(n1,n2) + 1i*randn(n1,n2) );
C  = A - B;
assertEqual( double( piCon(A) - B ), C);
assertEqual( double( A - piCon(B) ), C);
assertEqual( double( piCon(A) - piCon(B) ), C);
end % minus

function test_piCon_mldivide
%% mldivide
n1 = randi(10);
n2 = n1;
A  = distributed( randn(n1,n2) + 1i*randn(n1,n2) );
x  = distributed( randn(n2,2)  + 1i*randn(n2,2)  );
y  = A*x;
x  = gather(x);
assertElementsAlmostEqual( gather( double( piCon(A) \ y ) ), x);
assertElementsAlmostEqual( gather( double( A \ piCon(y) ) ), x);
assertElementsAlmostEqual( gather( double( piCon(A) \ piCon(y) ) ), x);
end % mldivide

function test_piCon_mrdivide
%% mrdivide
n1 = randi(10);
n2 = n1;
A  = distributed( randn(n1,n2) + 1i*randn(n1,n2) );
x  = distributed( randn(n2,2)  + 1i*randn(n2,2)  );
y  = A*x;
x  = gather(x);
assertElementsAlmostEqual( gather(double( piCon(y') / A' )'), x);
assertElementsAlmostEqual( gather(double( y' / piCon(A') )'), x);
assertElementsAlmostEqual( gather(double( piCon(y') / piCon(A') )'), x);
end % mrdivide

% function test_piCon_mpower
% %% mpower
% n1 = randi(10);
% n2 = n1;
% A  = distributed( randn(n1,n2) + 1i*randn(n1,n2) );
% n  = randi(10);
% y  = A^n;
% assertEqual( piCon(A) ^ n, y );
% assertEqual( A ^ piCon(n), y );
% assertEqual( piCon(A) ^ piCon(n), y );
% end % mpower not supported by distributed

function test_piCon_mtimes
%% mtimes
n1 = randi(10);
n2 = randi(10);
A  = distributed( randn(n1,n2) + 1i*randn(n1,n2) );
B  = distributed( randn(n2,2)  + 1i*randn(n2,2)  );
C  = A*B;
C  = gather(C);
assertEqual( gather(double( piCon(A) * B )), C);
assertEqual( gather(double( A * piCon(B) )), C);
assertEqual( gather(double( piCon(A) * piCon(B) )), C);
end % mtimes

function test_piCon_modifyHeader
%% modifyHeader
y = piCon.randn(3,3,3,'varName','Velocity','varUnits','m/s','label',...
    {'source1' 'source1' 'source1'},'unit',{'m/s' 'm/s^2' 'm/s'});

% modifying one header field
y = y.modifyHeader('unit',{'m/s' 'm/s' 'm/s'});
assertEqual(varName(y),'Velocity');
assertEqual(varUnits(y),'m/s');
assertEqual(label(y),{'source1' 'source1' 'source1'});
assertEqual(unit(y),{'m/s' 'm/s' 'm/s'});

% modifying all of header fields
y = y.modifyHeader('varName','Force','varUnits','N','label',...
    {'source#1' 'source#2' 'source#3'},'unit',{'N' 'N' 'N'});
assertEqual(varName(y),'Force');
assertEqual(varUnits(y),'N');
assertEqual(label(y),{'source#1' 'source#2' 'source#3'});
assertEqual(unit(y),{'N' 'N' 'N'});

% saving the dataContainer
td = ConDir();
y.save(path(td),1);

% testing the header attributes after loading
w = piCon.load(path(td));
DataContainer.isequalHeaderStruct(y.header,w.header);
end % modifyHeader

function test_piCon_ones
%% ones
n1 = randi(10);
n2 = randi(10);
assertEqual( double(piCon.ones(n1,n2)), distributed.ones(n1,n2) );
end % ones

function test_piCon_permute
%% Testing permute and invpermute
n1 = randi([2,10]);
n2 = randi([2,10]);
n3 = randi([2,10]);
x  = piCon.randn(n1,n2,n3);
assertEqual(invpermute(permute(x,[3 2 1])),x);
end % permute

function test_piCon_plus
%% minus
n1 = randi(10);
n2 = randi(10);
A  = distributed( randn(n1,n2) + 1i*randn(n1,n2) );
B  = distributed( randn(n1,n2) + 1i*randn(n1,n2) );
C  = A + B;
assertEqual( double( piCon(A) + B ), C);
assertEqual( double( A + piCon(B) ), C);
assertEqual( double( piCon(A) + piCon(B) ), C);
end % plus

function test_piCon_power
%% plus
n1 = randi(10);
n2 = randi(10);
A  = distributed( randn(n1,n2) + 1i*randn(n1,n2) );
n  = randi(10);
C  = A .^ n;
assertEqual( double( piCon(A) .^ n ), C);
assertEqual( double( A .^ piCon(n) ), C);
assertEqual( double( piCon(A) .^ iCon(n) ), C);
end % power

function test_piCon_rdivide
%% rdivide
n1 = randi(10);
n2 = randi(10);
A  = distributed( randn(n1,n2) + 1i*randn(n1,n2) );
B  = distributed( randn(n1,n2) + 1i*randn(n1,n2) );
C  = A ./ B;
assertEqual( double( piCon(A) ./ B ), C);
assertEqual( double( A ./ piCon(B) ), C);
assertEqual( double( piCon(A) ./ piCon(B) ), C);
end % rdivide

function test_piCon_real
%% real
n1 = randi(10);
n2 = randi(10);
A  = distributed( randn(n1,n2) + 1i*randn(n1,n2) );
assertEqual( double(real(piCon(A))), real(A) );
end % real

function test_piCon_reshape
%% Testing piCon reshape
n1 = randi(5);
n2 = randi(5);
n3 = randi(5);
n4 = randi(5);
x  = randn(n1,n2,n3,n4);
assertEqual( gather( double(reshape(piCon(x),n1*n2,n3*n4)) ),...
    reshape(x,n1*n2,n3*n4) );
end % reshape

function test_piCon_save_load
%% save & load
% No overwrite case
n1 = randi(10);
n2 = randi(10);
td = ConDir();
rmdir(path(td));
A  = distributed( randn(n1,n2) + 1i*randn(n1,n2) );
B  = piCon(A);
B.save(path(td));
C  = piCon.load(path(td)); 
assertEqual( double(C), A );

% Overwrite case
n1 = randi(10);
n2 = randi(10);
td = ConDir();
A  = distributed( randn(n1,n2) + 1i*randn(n1,n2) );
B  = piCon(A);
B.save(path(td),1);
% save fails if we try the following since the directory already exists
% B.save(path(td));
C  = piCon.load(path(td)); 
assertEqual( double(C), A );
end % save & load

function test_piCon_sign
%% sign
n1 = randi(10);
n2 = randi(10);
A  = distributed( randn(n1,n2) + 1i*randn(n1,n2) );
assertEqual( double(sign(piCon(A))), sign(A) );
end % sign

function test_piCon_times
%% rdivide
n1 = randi(10);
n2 = randi(10);
A  = distributed( randn(n1,n2) + 1i*randn(n1,n2) );
B  = distributed( randn(n1,n2) + 1i*randn(n1,n2) );
C  = A .* B;
assertEqual( double( piCon(A) .* B ), C);
assertEqual( double( A .* piCon(B) ), C);
assertEqual( double( piCon(A) .* piCon(B) ), C);
end % times

function test_piCon_transpose
%% transpose
n1 = randi(10);
n2 = randi(10);
A  = distributed( randn(n1,n2) + 1i*randn(n1,n2) );
assertEqual( double( piCon(A).' ), A.' );
end % transpose

function test_piCon_uminus
%% uminus
n1 = randi(10);
n2 = randi(10);
A  = distributed( randn(n1,n2) + 1i*randn(n1,n2) );
assertEqual( double( -piCon(A) ), -A );
end % uminus

function test_piCon_uplus
%% uplus
n1 = randi(10);
n2 = randi(10);
A  = distributed( randn(n1,n2) + 1i*randn(n1,n2) );
assertEqual( double( +piCon(A) ), +A );
end % uplus

function test_piCon_vertcat
%% vertcat
n1 = randi(10);
n2 = randi(10);
A  = distributed( randn(n1,n2) + 1i*randn(n1,n2) );
B  = piCon(A);
assertEqual( [A; A], double([B; B]) );
end % vertcat

function test_piCon_zeros
%% zeros
n1 = randi(10);
n2 = randi(10);
assertEqual( double(piCon.zeros(n1,n2)), distributed.zeros(n1,n2) );
end % zeros

function test_piCon_gather
%% gather
n1 = randi(10);
n2 = randi(10);
A  = distributed( randn(n1,n2) + 1i*randn(n1,n2) );
assertEqual( gather(A), double(gather(piCon(A))) );
end % gather

function test_piCon_vec_invvec
%% vec invvec
x  = piCon.randn(randi(10),randi(10),randi(10));
x1 = vec(x);
assertEqual( double(x), double(invvec(x1)) );
end % vec invvec

function test_piCon_redistribute
%% Testing piCon redistribute
n1     = randi(5);
n2     = randi(5);
n3     = randi(5);
A      = distributed.randn(n1,n2,n3);
B      = piCon(A);
B      = redistribute(B,2);
B_data = double(B);
spmd
    A = redistribute(A,codistributor1d(2));
    A_part = getLocalPart(A);
    B_part = getLocalPart(B_data);
    assertEqual(A_part,B_part);
end
end % redistribute
