function x = binaryOpen(filepath,dims,precision,iscomplex)
%%BINARYOPEN    File opener for binary files
%
%   x = binaryOpen(FILEPATH,DIMS,PRECISION,ISCOMPLEX) is used to construct 
%   an out-of-core data container out of a binary file, which location is 
%   specified by FILEPATH.
%
%   By default, precision = 'double' and iscomplex = false

% Arguments preprocessing
if nargin < 4, iscomplex = false; end
if nargin < 3, precision = 'double'; end

% Construct parent class
x = oCon('Binary Parallel OutCon',dims,iscomplex);

% Convert file to binary file with precision double
binaryfilepath = DataCon.io.binaryConverter(filepath,precision);
% Note that this utility is yet to be coded, returns a temporary path
% pointing to converted binary file with precision Double

% Scatter operation
scatteredfilepath = DataCon.io.scatter(binaryfilepath);
% Returns a Composite containing structs containing the filepaths to the
% distributed real and imaginary chunks of the binary file

% Assign to class attribute
x.intrdata = scatteredfilepath;