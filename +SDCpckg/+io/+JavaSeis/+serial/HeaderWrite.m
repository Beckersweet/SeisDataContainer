function header = HeaderWrite(x,xprecision,xcomplex)
%HEADERWRITE creates Header as MATLAB Struct
%TESTED with header = HeaderWrite([250,30,100,10],'double',0)

% Import package
import SDCpckg.* 

% Create Header as MATLAB Struct
header = SDCpckg.basicHeaderStruct(x,xprecision,xcomplex) ;

% Verify Header Struct 
% verifyHeaderStructWithX(header,x) ;

end
