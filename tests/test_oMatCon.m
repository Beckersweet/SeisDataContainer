function test_suite = test_oMatCon
    initTestSuite;
end

function test_oMatCon_complex
%% complex
y = oMatCon.randn(3,3,3);
y = complex(y,0);
y = y + 1i*randn(3,3,3);
x = randn(3,3,3);
for i=1:3
    x(:,:,i) = y(:,1:3,i);
end
assertEqual(imag(x),imag(y));
y = oMatCon.randn(3,3,3);
z = oMatCon.randn(3,3,3);
y = complex(y,z);
x = randn(3,3,3);
for i=1:3
    x(:,:,i) = y(:,1:3,i);
end
assertEqual(imag(x),imag(y));
end % complex

function test_oMatCon_conj
%% conj
y = oMatCon.randn(3,3,3);
y = complex(y,0);
y = y + 1i*randn(3,3,3);
x = randn(3,3,3);
for i=1:3
    x(:,:,i) = y(:,1:3,i);
end
assertEqual(conj(x),conj(y));
end % conj

function test_oMatCon_ctranspose
%% ctranspose
x  = complex(oMatCon.randn(3,3,3), oMatCon.randn(3,3,3));
y  = double(x);
x  = reshape(x,[9 3]);
y  = reshape(y,[9 3]);
xt = x';
yt = y';
assertEqual(size(yt), size(xt));
assertEqual(double(xt),yt);
end % ctranspose

function test_oMatCon_imag
%% imag
y = oMatCon.randn(3,3,3);
y = complex(y,0);
y = y + 1i*randn(3,3,3);
x = randn(3,3,3);
for i=1:3
    x(:,:,i) = y(:,1:3,i);
end
assertEqual(imag(x),imag(y));
end % imag

function test_oMatCon_inputParser
%% inputParser
y = oMatCon.randn(3,3,3,'varName','Velocity','varUnits','m/s','label',...
    {'source1' 'source1' 'source1'},'unit',{'m/s' 'm/s^2' 'm/s'});
y = complex(y,0);
y = y + 1i*randn(3,3,3);
assertEqual(varName(y),'Velocity');
assertEqual(varUnits(y),'m/s');
assertEqual(label(y),{'source1' 'source1' 'source1'});
assertEqual(unit(y),{'m/s' 'm/s^2' 'm/s'});

% saving the dataContainer
td = ConDir();
y.save(path(td),1);

% testing different load modes and making sure the arguments match
w = oMatCon.load(path(td),'copy',0);
SDCpckg.isequalHeaderStruct(y.header,w.header)

w = oMatCon.load(path(td),'copy',1);
SDCpckg.isequalHeaderStruct(y.header,w.header)

w = oMatCon.load(path(td),'readonly',0);
SDCpckg.isequalHeaderStruct(y.header,w.header)

w = oMatCon.load(path(td),'readonly',1);
SDCpckg.isequalHeaderStruct(y.header,w.header)

w = oMatCon.load(path(td),'copy',0,'readonly',0);
SDCpckg.isequalHeaderStruct(y.header,w.header)

w = oMatCon.load(path(td),'copy',0,'readonly',1);
SDCpckg.isequalHeaderStruct(y.header,w.header)

w = oMatCon.load(path(td),'copy',1,'readonly',0);
SDCpckg.isequalHeaderStruct(y.header,w.header)

w = oMatCon.load(path(td),'copy',1,'readonly',1);
SDCpckg.isequalHeaderStruct(y.header,w.header)
end % inputParser

function test_oMatCon_invvec
%% invvec
y = oMatCon.randn(3,4,3);
y = complex(y,0);
y = y + 1i*randn(3,4,3);
x = vec(y);
assertEqual(y,invvec(x));
end % invvec

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
end % io

function test_oMatCon_ldivide
%% ldivide
y = oMatCon.randn(3,3,3);
x = zeros(3,3,3);
for i=1:3
    x(:,:,i) = y(:,1:3,i);
end
z = oMatCon.randn(3,3,3);
w = zeros(3,3,3);
for i=1:3
    w(:,:,i) = z(:,1:3,i);
end
assertEqual(y./z,x./w);
end % ldivide

function test_oMatCon_minus
%% minus
y = oMatCon.randn(3,3,3);
y = complex(y,0);
y = y + 1i*randn(3,3,3);
x = randn(3,3,3);
for i=1:3
    x(:,:,i) = y(:,1:3,i);
end
z = oMatCon.randn(3,3,3);
z = complex(z,0);
z = y + 1i*randn(3,3,3);
w = randn(3,3,3);
for i=1:3
    w(:,:,i) = z(:,1:3,i);
end
assertEqual(y-z,x-w);
end % minus

function test_oMatCon_mldivide
%% mldivide
n1       = randi(10);
x        = randn(n1,n1) + 1i*randn(n1,n1);
y        = oMatCon.randn(n1,2);
y        = complex(y,0);
y        = y + 1i*randn(n1,2);
z        = zeros(n1,2);
z(:,1:2) = y(:,1:2);
assertElementsAlmostEqual(x\y,x\z);
end % mldivide

function test_oMatCon_modifyHeader
%% modifyHeader
y = oMatCon.randn(3,3,3,'varName','Velocity','varUnits','m/s','label',...
    {'source1' 'source1' 'source1'},'unit',{'m/s^2' 'm/s^2' 'm/s^2'});
y = complex(y,0);
y = y + 1i*randn(3,3,3);

% backup the original dataContainer
tr = ConDir();
y.save(path(tr),1);
z = oMatCon.load(path(tr));

% modifying one header field
y = y.modifyHeader('unit',{'m/s' 'm/s' 'm/s'});
assertEqual(varName(y),'Velocity');
assertEqual(varUnits(y),'m/s');
assertEqual(label(y),{'source1' 'source1' 'source1'});
assertEqual(unit(y),{'m/s' 'm/s' 'm/s'});

% Checking if the data itself is still untouched
assertEqual(y,z);

% modifying all of header fields
y = y.modifyHeader('varName','Force','varUnits','N','label',...
    {'source#1' 'source#2' 'source#3'},'unit',{'N' 'N' 'N'});
assertEqual(varName(y),'Force');
assertEqual(varUnits(y),'N');
assertEqual(label(y),{'source#1' 'source#2' 'source#3'});
assertEqual(unit(y),{'N' 'N' 'N'});

% Checking if the data itself is still untouched
assertEqual(y,z);

% saving the dataContainer
td = ConDir();
y.save(path(td),1);

% testing the header attributes after loading
w = oMatCon.load(path(td));
assertEqual(y,w);
SDCpckg.isequalHeaderStruct(y.header,w.header)
end % modifyHeader

function test_oMatCon_mrdivide
%% mrdivide
n1       = 2;
x        = randn(n1,n1) + 1i*randn(n1,n1);
y        = oMatCon.randn(n1,2);
y        = complex(y,0);
y        = y + 1i*randn(n1,2);
z        = zeros(n1,2);
z(:,1:2) = y(:,1:2);
assertElementsAlmostEqual(y/x,z/x);
end % mrdivide

function test_oMatCon_mtimes
%% mtimes
n1       = randi(10);
n2       = randi(10);
x        = randn(n1,n2) + 1i*randn(n1,n2);
y        = oMatCon.randn(n2,2);
y        = complex(y,0);
y        = y + 1i*randn(n2,2);
z        = zeros(n2,2);
z(:,1:2) = y(:,1:2);
assertElementsAlmostEqual(x*y,x*z);
end % mtimes

function test_oMatCon_norm
%% norm
y = oMatCon.randn(3,3,3);
y = complex(y,0);
y = y + 1i*randn(3,3,3);
x = randn(3,3,3);
for i=1:3
    x(:,:,i) = y(:,1:3,i);
end
x = x(:);
assertElementsAlmostEqual(norm(y,0),norm(x,0));
assertElementsAlmostEqual(y.norm(1),norm(x,1));
assertElementsAlmostEqual(norm(y),norm(x));
assertElementsAlmostEqual(y.norm(inf),norm(x,inf));
assertElementsAlmostEqual(norm(y,-inf),norm(x,-inf));
assertElementsAlmostEqual(y.norm('fro'),norm(x,'fro'));
assertElementsAlmostEqual(norm(y,'fro'),norm(x,'fro'));
end % norm

function test_oMatCon_ones
%% ones
y = oMatCon.ones(3,3,3);
x = ones(3,3,3);
assertEqual(x,y);
end % ones

function test_oMatCon_plus
%% plus
y = oMatCon.randn(3,3,3);
y = complex(y,0);
y = y + 1i*randn(3,3,3);
x = randn(3,3,3);
for i=1:3
    x(:,:,i) = y(:,1:3,i);
end
z = oMatCon.randn(3,3,3);
z = complex(z,0);
z = z + 1i*randn(3,3,3);
w = randn(3,3,3);
for i=1:3
    w(:,:,i) = z(:,1:3,i);
end
assertEqual(y-z,x-w);
end % plus

function test_oMatCon_power
%% power
y = oMatCon.randn(3,3,3);
y = complex(y,0);
y = y + 1i*randn(3,3,3);
x = randn(3,3,3);
for i=1:3
    x(:,:,i) = y(:,1:3,i);
end
t = randn(1);
assertEqual(x.^t,y.^t);
end % power

function test_oMatCon_rdivide
%% rdivide
y = oMatCon.randn(3,3,3);
y = complex(y,0);
y = y + 1i*randn(3,3,3);
x = randn(3,3,3);
for i=1:3
    x(:,:,i) = y(:,1:3,i);
end
t = randn(1);
assertEqual(x/t,y./t);
end % rdivide

function test_oMatCon_real
%% real
y = oMatCon.randn(3,3,3);
y = complex(y,0);
y = y + 1i*randn(3,3,3);
x = randn(3,3,3);
for i=1:3
    x(:,:,i) = y(:,1:3,i);
end
assertEqual(real(x),real(y));
end % real

function test_oMatCon_reshape
%% reshape
y = oMatCon.randn(3,3,3);
y = complex(y,0);
y = y + 1i*randn(3,3,3);
x = randn(3,3,3);
for i=1:3
    x(:,:,i) = y(:,1:3,i);
end
assertEqual(size(reshape(x,[27 1 1 1])),size(reshape(y,[27 1 1 1])));
assertEqual(size(reshape(x,[27 1])),size(reshape(y,[27 1])));
assertEqual(size(reshape(x,[9 3])),size(reshape(y,[9 3])));
assertEqual(size(reshape(x,[3 3 3])),size(reshape(y,[3 3 3])));
end % reshape

function test_oMatCon_save_load
%% save and load
y = oMatCon.randn(3,3,3);
y = complex(y,0);
y = y + 1i*randn(3,3,3);
x = randn(3,3,3);
for i=1:3
    x(:,:,i) = y(:,1:3,i);
end
assertEqual(x,y);
td = ConDir();
y.save(path(td),1);
z = oMatCon.load(td);
assertEqual(x,z);
assertEqual(z,y);
SDCpckg.isequalHeaderStruct(y.header,z.header)
end % save and load

function test_oMatCon_sign
%% sign
y = oMatCon.randn(3,3,3);
y = complex(y,0);
y = y + 1i*randn(3,3,3);
x = randn(3,3,3);
for i=1:3
    x(:,:,i) = y(:,1:3,i);
end
assertEqual(sign(x),sign(y));
end % sign

function test_oMatCon_times
%% times
y = oMatCon.randn(3,3,3);
y = complex(y,0);
y = y + 1i*randn(3,3,3);
x = randn(3,3,3);
for i=1:3
    x(:,:,i) = y(:,1:3,i);
end
t = randn(1);
assertEqual(x*t,y.*t);
end % times

function test_oMatCon_transpose
%% transpose
y = oMatCon.randn(3,3);
y = complex(y,0);
y = y + 1i*randn(3,3);
x(:,1:3) = double(y(:,1:3));
assertEqual( y.', x.' );
end % transpose

function test_oMatCon_uminus
%% uminus
y = oMatCon.randn(3,3,3);
y = complex(y,0);
y = y + 1i*randn(3,3,3);
x = randn(3,3,3);
for i=1:3
    x(:,:,i) = y(:,1:3,i);
end
assertEqual(-x,-y);
end % uminus

function test_oMatCon_uplus
%% uplus
y = oMatCon.randn(3,3,3);
y = complex(y,0);
y = y + 1i*randn(3,3,3);
x = randn(3,3,3);
for i=1:3
    x(:,:,i) = y(:,1:3,i);
end
assertEqual(+x,+y);
end % uplus

function test_oMatCon_vec
%% vec
y = oMatCon.randn(3,3,3);
y = complex(y,0);
y = y + 1i*randn(3,3,3);
y = y(:);
assertEqual(size(y),[27 1]);
end % vec

function test_oMatCon_zeros
%% zeros
y = oMatCon.zeros(3,3,3);
x = zeros(3,3,3);
assertEqual(x,y);
end % zeros

function test_oMatCon_iCon
%% oMatCon
x = oMatCon.randn(3,2,4);
x = reshape(x,[6 4]);
y = iCon(x);
assertEqual(x.exsize,y.exsize);
assertEqual(double(x),double(y));
assertEqual(x.header.size,y.header.size);
end % iCon