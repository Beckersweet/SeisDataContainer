function test_suite = test_oMatCon
    initTestSuite;
end

function test_oMatCon_io
%% norm
y = oMatCon.randn(3,5,3,6);
x = zeros(3,5,3,6);

% over first dimension
x(1:3,5,3,6) = y(1:3,5,3,6);
assertEqual(x(:,5,3,6),y(:,5,3,6));

% over 3rd dimension
for i=1:6
    x(:,:,1:3,i) = y(:,:,1:3,i);
end
assertEqual(x,y);

% over last dimension
x(:,:,:,1:6) = y(:,:,:,1:6);
assertEqual(x,y);
end % norm

function test_oMatCon_norm
%% norm
y = oMatCon.randn(3,3,3);
y = complex(y,1);
x(:,:,1) = y(:,1:3,1);
x(:,:,2) = y(:,1:3,2);
x(:,:,3) = y(:,1:3,3);
assertElementsAlmostEqual(y.norm(0),norm(vec(x),0));
assertElementsAlmostEqual(y.norm(1),norm(vec(x),1));
assertElementsAlmostEqual(y.norm(2),norm(vec(x),2));
assertElementsAlmostEqual(y.norm(inf),norm(vec(x),inf));
assertElementsAlmostEqual(y.norm(-inf),norm(vec(x),-inf));
assertElementsAlmostEqual(y.norm('fro'),norm(vec(x),'fro'));
end % norm

function test_oMatCon_imag
%% imag
y = oMatCon.randn(3,3,3);
y = complex(y,1);
x(:,:,1) = y(:,1:3,1);
x(:,:,2) = y(:,1:3,2);
x(:,:,3) = y(:,1:3,3);
assertEqual(imag(x),imag(y));
end % imag

function test_oMatCon_minus
%% minus
y = oMatCon.randn(3,3,3);
x(:,:,1) = y(:,1:3,1);
x(:,:,2) = y(:,1:3,2);
x(:,:,3) = y(:,1:3,3);
z = oMatCon.randn(3,3,3);
w(:,:,1) = z(:,1:3,1);
w(:,:,2) = z(:,1:3,2);
w(:,:,3) = z(:,1:3,3);
assertEqual(y-z,x-w);
end % minus

function test_oMatCon_plus
%% plus
y = oMatCon.randn(3,3,3);
x(:,:,1) = y(:,1:3,1);
x(:,:,2) = y(:,1:3,2);
x(:,:,3) = y(:,1:3,3);
z = oMatCon.randn(3,3,3);
w(:,:,1) = z(:,1:3,1);
w(:,:,2) = z(:,1:3,2);
w(:,:,3) = z(:,1:3,3);
assertEqual(y-z,x-w);
end % plus

function test_oMatCon_real
%% real
y = oMatCon.randn(3,3,3);
y = complex(y,1);
x(:,:,1) = y(:,1:3,1);
x(:,:,2) = y(:,1:3,2);
x(:,:,3) = y(:,1:3,3);
assertEqual(real(x),real(y));
end % real

function test_oMatCon_sign
%% sign
y = oMatCon.randn(3,3,3);
y = complex(y,1);
x(:,:,1) = y(:,1:3,1);
x(:,:,2) = y(:,1:3,2);
x(:,:,3) = y(:,1:3,3);
assertEqual(sign(x),sign(y));
end % sign

function test_oMatCon_zeros
%% zeros
y = oMatCon.zeros(3,3,3);
x = zeros(3,3,3);
assertEqual(x,y);
end % zeros

function test_oMatCon_ones
%% ones
y = oMatCon.ones(3,3,3);
x = ones(3,3,3);
assertEqual(x,y);
end % ones