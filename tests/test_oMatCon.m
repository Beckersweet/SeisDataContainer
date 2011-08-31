function test_suite = test_oMatCon
    initTestSuite;
end

function test_oMatCon_norm
%% norm
y = oMatCon.randn(3,3,3);
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

function test_oMatCon_assertEqual
%% norm
y = oMatCon.randn(3,3,3);
x = oMatCon.randn(3,3,3);
end % norm
