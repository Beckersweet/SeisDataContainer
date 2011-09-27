function test_suite = test_oMatCon
    initTestSuite;
end

function test_oMatCon_complex
%% complex
y = oMatCon.randn(3,3,3);
y = complex(y,1);
x(:,:,1) = y(:,1:3,1);
x(:,:,2) = y(:,1:3,2);
x(:,:,3) = y(:,1:3,3);
assertEqual(imag(x),imag(y));
clear
y = oMatCon.randn(3,3,3);
z = oMatCon.randn(3,3,3);
y = complex(y,z);
x(:,:,1) = y(:,1:3,1);
x(:,:,2) = y(:,1:3,2);
x(:,:,3) = y(:,1:3,3);
assertEqual(imag(x),imag(y));
clear
end % complex

function test_oMatCon_imag
%% imag
y = oMatCon.randn(3,3,3);
y = complex(y,1);
x(:,:,1) = y(:,1:3,1);
x(:,:,2) = y(:,1:3,2);
x(:,:,3) = y(:,1:3,3);
assertEqual(imag(x),imag(y));
clear
end % imag

function test_oMatCon_io
%% io
y = oMatCon.randn(3,5,3,6);
x = zeros(3,5,3,6);

% over first dimension
x(1:3,5,3,6) = y(1:3,5,3,6);
assertEqual(x(:,5,3,6),y(:,5,3,6));

x = zeros(3,5,3,6);
% over 2nd dimension
for i=1:6
    for j=1:3
        x(:,1:5,j,i) = y(:,1:5,j,i);
    end
end
assertEqual(x,y);

x = zeros(3,5,3,6);
% over 3rd dimension
for i=1:6
    x(:,:,1:3,i) = y(:,:,1:3,i);
end
assertEqual(x,y);

x = zeros(3,5,3,6);
% over last dimension
x(:,:,:,1:6) = y(:,:,:,1:6);
assertEqual(x,y);

% element by element access
isequal(x(1,2,3,4),y(1,2,3,4));
isequal(x(1,1,1,1),y(1,1,1,1));
isequal(x(3,5,3,6),y(3,5,3,6));
clear
end % io

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
clear
end % minus

function test_oMatCon_mtimes
%% mtimes
y = oMatCon.randn(3,3,3);
y = complex(y,1);
w = opDirac(3);
z = w*y;
assertEqual(z,y);
clear
end % mtimes

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
clear
end % norm

function test_oMatCon_ones
%% ones
y = oMatCon.ones(3,3,3);
x = ones(3,3,3);
assertEqual(x,y);
clear
end % ones

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
clear
end % plus

function test_oMatCon_real
%% real
y = oMatCon.randn(3,3,3);
y = complex(y,1);
x(:,:,1) = y(:,1:3,1);
x(:,:,2) = y(:,1:3,2);
x(:,:,3) = y(:,1:3,3);
assertEqual(real(x),real(y));
clear
end % real

function test_oMatCon_save_load
%% save and load
y = oMatCon.randn(3,3,3);
y = complex(y,1);
x(:,:,1) = y(:,1:3,1);
x(:,:,2) = y(:,1:3,2);
x(:,:,3) = y(:,1:3,3);
assertEqual(x,y);
td = DataContainer.io.makeDir();
y.save(td);
z = oMatCon.load(td);
assertEqual(x,z);
assertEqual(z,y);
clear
end % save and load

function test_oMatCon_power
%% power
y = oMatCon.randn(3,3,3);
y = complex(y,1);
x(:,:,1) = y(:,1:3,1);
x(:,:,2) = y(:,1:3,2);
x(:,:,3) = y(:,1:3,3);
t = randn(1);
y = y.^t;
x = x.^t;
assertEqual(x,y);
clear
end % power

function test_oMatCon_sign
%% sign
y = oMatCon.randn(3,3,3);
y = complex(y,1);
x(:,:,1) = y(:,1:3,1);
x(:,:,2) = y(:,1:3,2);
x(:,:,3) = y(:,1:3,3);
assertEqual(sign(x),sign(y));
clear
end % sign

function test_oMatCon_times
%% times
y = oMatCon.randn(3,3,3);
y = complex(y,1);
x(:,:,1) = y(:,1:3,1);
x(:,:,2) = y(:,1:3,2);
x(:,:,3) = y(:,1:3,3);
t = randn(1);
y = y.*t;
x = x*t;
assertEqual(x,y);
clear
end % times

function test_oMatCon_zeros
%% zeros
y = oMatCon.zeros(3,3,3);
x = zeros(3,3,3);
assertEqual(x,y);
clear
end % zeros
