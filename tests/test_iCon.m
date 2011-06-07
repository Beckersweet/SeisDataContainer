function test_suite = test_iCon
initTestSuite;
end

function test_iCon_bsxfun
%% bsxfun
n1 = randi([2 10]);
n2 = randi([2 10]);
A  = randn(n1,n2) + 1i*randn(n1,n2);
B  = iCon(A);
y  = randn(n1,1);
assertEqual( bsxfun(@minus,A,y), double( bsxfun(@minus,B,y) ) );
end

function test_iCon_conj
%% conj
n1 = randi(10);
n2 = randi(10);
A  = randn(n1,n2) + 1i*randn(n1,n2);
assertEqual(conj(A),double(conj(iCon(A))));
end % conj

function test_iCon_ctranspose
%% ctranspose
n1 = randi(10);
n2 = randi(10);
A  = randn(n1,n2) + 1i*randn(n1,n2);
B  = iCon(A);
assertEqual(A',double(B'));
end % ctranspose

function test_iCon_horzcat
%% horzcat
n1 = randi(10);
n2 = randi(10);
A  = randn(n1,n2) + 1i*randn(n1,n2);
B  = iCon(A);
assertEqual( [A A], double([B B]) );
end % horzcat

function test_iCon_imag
%% imag
n1 = randi(10);
n2 = randi(10);
A  = randn(n1,n2) + 1i*randn(n1,n2);
B  = iCon(A);
assertEqual( imag(A), double( imag(B) ) );
end % horzcat

function test_iCon_inv
%% inv
n1 = randi(10);
n2 = n1;
A  = randn(n1,n2) + 1i*randn(n1,n2);
assertEqual( inv(iCon(A)), inv(A) );
end % inv

function test_iCon_ldivide
%% ldivide
n1 = randi(10);
n2 = randi(10);
A  = randn(n1,n2) + 1i*randn(n1,n2);
B  = randn(n1,n2) + 1i*randn(n1,n2);
C  = A .\ B;
assertEqual( double( iCon(A) .\ B ), C);
assertEqual( double( A .\ iCon(B) ), C);
assertEqual( double( iCon(A) .\ iCon(B) ), C);
end % ldivide

function test_iCon_minus
%% minus
n1 = randi(10);
n2 = randi(10);
A  = randn(n1,n2) + 1i*randn(n1,n2);
B  = randn(n1,n2) + 1i*randn(n1,n2);
C  = A - B;
assertEqual( double( iCon(A) - B ), C);
assertEqual( double( A - iCon(B) ), C);
assertEqual( double( iCon(A) - iCon(B) ), C);
end % minus

function test_iCon_mldivide
%% mldivide
n1 = randi(10);
n2 = n1;
A  = randn(n1,n2) + 1i*randn(n1,n2);
x  = randn(n2,2)  + 1i*randn(n2,2);
y  = A*x; 
assertElementsAlmostEqual( double( iCon(A) \ y ), x);
assertElementsAlmostEqual( double( A \ iCon(y) ), x);
assertElementsAlmostEqual( double( iCon(A) \ iCon(y) ), x);
end % mldivide

function test_iCon_mrdivide
%% mrdivide
n1 = randi(10);
n2 = n1;
A  = randn(n1,n2) + 1i*randn(n1,n2);
x  = randn(n2,2)  + 1i*randn(n2,2);
y  = A*x;
assertElementsAlmostEqual( double( iCon(y')/A' )', x);
assertElementsAlmostEqual( double( y'/iCon(A') )', x);
assertElementsAlmostEqual( double( iCon(y')/iCon(A') )', x);
end % mrdivide

function test_iCon_mpower
%% mpower
n1 = randi(10);
n2 = n1;
A  = randn(n1,n2) + 1i*randn(n1,n2);
n  = randi(10);
y  = A^n;
assertEqual( iCon(A) ^ n, y );
assertEqual( A ^ iCon(n), y );
assertEqual( iCon(A) ^ iCon(n), y );
end % mpower

function test_iCon_mtimes
%% mtimes
n1 = randi(10);
n2 = randi(10);
A  = randn(n1,n2) + 1i*randn(n1,n2);
B  = randn(n2,2)  + 1i*randn(n2,2);
C  = A*B; 
assertEqual( double( iCon(A) * B ), C);
assertEqual( double( A * iCon(B) ), C);
assertEqual( double( iCon(A) * iCon(B) ), C);
end % mtimes

function test_iCon_opMatrix
%% opMatrix
n1 = randi(10);
n2 = randi(10);
A  = randn(n1,n2) + 1i*randn(n1,n2);
assertEqual(double(opMatrix(iCon(A))), A);
end % opMatrix

function test_iCon_permute
%% Testing permute and invpermute
n1 = randi([2,10]);
n2 = randi([2,10]);
n3 = randi([2,10]);
x  = iCon.randn(n1,n2,n3);
assertEqual(invpermute(permute(x,[3 2 1])),x);
end % permute

function test_iCon_plus
%% plus
n1 = randi(10);
n2 = randi(10);
A  = randn(n1,n2) + 1i*randn(n1,n2);
B  = randn(n1,n2) + 1i*randn(n1,n2);
C  = A + B;
assertEqual( double( iCon(A) + B ), C);
assertEqual( double( A + iCon(B) ), C);
assertEqual( double( iCon(A) + iCon(B) ), C);
end % plus

function test_iCon_power
%% plus
n1 = randi(10);
n2 = randi(10);
A  = randn(n1,n2) + 1i*randn(n1,n2);
n  = randi(10);
C  = A .^ n;
assertEqual( double( iCon(A) .^ n ), C);
assertEqual( double( A .^ iCon(n) ), C);
assertEqual( double( iCon(A) .^ iCon(n) ), C);
end % power

function test_iCon_rdivide
%% rdivide
n1 = randi(10);
n2 = randi(10);
A  = randn(n1,n2) + 1i*randn(n1,n2);
B  = randn(n1,n2) + 1i*randn(n1,n2);
C  = A ./ B;
assertEqual( double( iCon(A) ./ B ), C);
assertEqual( double( A ./ iCon(B) ), C);
assertEqual( double( iCon(A) ./ iCon(B) ), C);
end % rdivide

function test_iCon_real
%% real
n1 = randi(10);
n2 = randi(10);
A  = randn(n1,n2) + 1i*randn(n1,n2);
assertEqual( double(real(iCon(A))), real(A) );
end % real

function test_iCon_reshape
%% Testing reshape function
n1 = randi(10);
n2 = randi(10);
n3 = randi(10);
n4 = randi(10);
x  = randn(n1,n2,n3,n4);
assertEqual( double(reshape(iCon(x),n1*n2,n3*n4)), reshape(x,n1*n2,n3*n4) );

end

function test_iCon_sign
%% sign
n1 = randi(10);
n2 = randi(10);
A  = randn(n1,n2) + 1i*randn(n1,n2);
assertEqual( double(sign(iCon(A))), sign(A) );
end % sign

function test_iCon_times
%% times
n1 = randi(10);
n2 = randi(10);
A  = randn(n1,n2) + 1i*randn(n1,n2);
B  = randn(n1,n2) + 1i*randn(n1,n2);
C  = A .* B;
assertEqual( double( iCon(A) .* B ), C);
assertEqual( double( A .* iCon(B) ), C);
assertEqual( double( iCon(A) .* iCon(B) ), C);
end % times

function test_iCon_transpose
%% transpose
n1 = randi(10);
n2 = randi(10);
A  = randn(n1,n2) + 1i*randn(n1,n2);
assertEqual( double(iCon(A).'), A.' );
end % transpose

function test_iCon_uminus
%% uminus
n1 = randi(10);
n2 = randi(10);
A  = randn(n1,n2) + 1i*randn(n1,n2);
assertEqual( double( -iCon(A) ), -A );
end % uminus

function test_iCon_uplus
%% uplus
n1 = randi(10);
n2 = randi(10);
A  = randn(n1,n2) + 1i*randn(n1,n2);
assertEqual( double( +iCon(A) ), +A );
end % uplus

function test_iCon_vertcat
%% vertcat
n1 = randi(10);
n2 = randi(10);
A  = randn(n1,n2) + 1i*randn(n1,n2);
B  = iCon(A);
assertEqual( [A; A], double([B; B]) );
end % vertcat

function test_iCon_zeros
%% zeros
n1 = randi(10);
n2 = randi(10);
assertEqual( double(iCon.zeros(n1,n2)), zeros(n1,n2) );
end % zeros

function test_iCon_invvec
%% vec invvec
x  = iCon.randn(randi(10),randi(10),randi(10));
x1 = vec(x);
assertEqual( double(x), double(invvec(x1)) );
end % vec invvec