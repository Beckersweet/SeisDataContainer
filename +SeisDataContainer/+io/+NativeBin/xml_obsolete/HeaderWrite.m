function HeaderWrite(file_name, header)
% HEADERWRITE writes header to xml file
%
% HeaderWrite(file_name, header) writes header to xml file. header is a 
% struct which is defined using minimalHeaderStruct

% Check file_name
assert(ischar(file_name), 'file_name must be a string');

dims        = header.dims;
n           = header.size;
d           = header.interval;
o           = header.origin;
l           = header.label;
u           = header.unit;
precision   = header.precision;
complex     = header.complex;
distributedIO = header.distributedIO;

% Check complex
assert(complex == 0 || complex == 1,'complex should be either 0 or 1');

% Check precision
assert(ischar(precision), 'precision must be a string');

docNode = com.mathworks.xml.XMLUtils.createDocument... 
    ('NativeBin');

docRootNode = docNode.getDocumentElement;

% Writing n to xml
thisElement = docNode.createElement('n');
thisElement.appendChild... 
    (docNode.createTextNode(sprintf('%i',n(1))));
for i=2:dims
    thisElement.appendChild... 
    (docNode.createTextNode(sprintf(' %i',n(i))));
end % for
docRootNode.appendChild(thisElement);

% Writing d to xml
thisElement = docNode.createElement('d'); 
thisElement.appendChild... 
    (docNode.createTextNode(sprintf('%i',d(1))));
for i=2:dims
    thisElement.appendChild... 
    (docNode.createTextNode(sprintf(' %i',d(i))));
end % for
docRootNode.appendChild(thisElement);

% Writing o to xml
thisElement = docNode.createElement('o'); 
thisElement.appendChild... 
    (docNode.createTextNode(sprintf('%i',o(1))));
for i=2:dims
    thisElement.appendChild... 
    (docNode.createTextNode(sprintf(' %i',o(i))));
end % for
docRootNode.appendChild(thisElement);

% Writing l to xml
thisElement = docNode.createElement('l'); 
thisElement.appendChild... 
    (docNode.createTextNode(sprintf('%s',l{1})));
for i=2:dims     
    thisElement.appendChild... 
    (docNode.createTextNode(sprintf(' %s',l{i})));
end % for
docRootNode.appendChild(thisElement);

% Writing u to xml
thisElement = docNode.createElement('u');
thisElement.appendChild... 
    (docNode.createTextNode(sprintf('%s',u{1})));
for i=2:dims    
    thisElement.appendChild... 
    (docNode.createTextNode(sprintf(' %s',u{i})));
end % for
docRootNode.appendChild(thisElement);

% Writing complex to xml
thisElement = docNode.createElement('complex');
thisElement.appendChild... 
    (docNode.createTextNode(sprintf('%i',complex)));
docRootNode.appendChild(thisElement);

% Writing precision to xml
thisElement = docNode.createElement('precision');
thisElement.appendChild... 
    (docNode.createTextNode(sprintf('%s',precision)));
docRootNode.appendChild(thisElement);

% Writing distributedIO to xml
thisElement = docNode.createElement('distributedIO');
thisElement.appendChild... 
    (docNode.createTextNode(sprintf('%i',distributedIO)));
docRootNode.appendChild(thisElement);


% Setting the xml file name
xmlFileName = [file_name,'.xml'];
xmlwrite(xmlFileName,docNode);
%type(xmlFileName);

end % function
