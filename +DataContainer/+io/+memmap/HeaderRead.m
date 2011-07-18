function header = HeaderRead( file_name )
%HEADERREAD Reads the data from xml file

assert(ischar(file_name), 'file_name must be a string');

xDoc = xmlread([file_name,'.xml']);

%n
n =  eval(['[' char(xDoc.getElementsByTagName('n').item(0).getFirstChild.getData) ']']);

%d
d =  eval(['[' char(xDoc.getElementsByTagName('d').item(0).getFirstChild.getData) ']']);

%o
o =  eval(['[' char(xDoc.getElementsByTagName('o').item(0).getFirstChild.getData) ']']);

%l
l =  char(xDoc.getElementsByTagName('l').item(0).getFirstChild.getData);
l = regexp(l, ' ', 'split');

%u
u =  char(xDoc.getElementsByTagName('u').item(0).getFirstChild.getData);
u = regexp(u, ' ', 'split');

% precision
precision = char(xDoc.getElementsByTagName('precision').item(0).getFirstChild.getData);

% complex
complex = eval(char(xDoc.getElementsByTagName('complex').item(0).getFirstChild.getData));

% distributed
distributed = eval(char(xDoc.getElementsByTagName('distributed').item(0).getFirstChild.getData));

header = DataContainer.io.basicHeaderStruct(n, precision, complex);
header.label       = l;
header.unit        = u;
header.offset      = o;
header.interval    = d;
header.distributed = distributed;

end