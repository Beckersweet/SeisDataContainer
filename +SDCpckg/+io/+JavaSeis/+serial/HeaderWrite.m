function header = HeaderWrite(x,xprecision,xcomplex)
%HEADERWRITE creates Header as MATLAB Struct

% Import package
import SDCpckg.* 

% Create Header as MATLAB Struct
header = basicHeaderStruct(size(x),xprecision,xcomplex) ;

% Verify Header Struct 
verifyHeaderStructWithX(header,x) ;

end
