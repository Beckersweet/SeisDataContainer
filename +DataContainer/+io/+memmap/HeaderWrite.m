function HeaderWrite(file_name, n, d, o, l, u, complex)
% HeaderWrite writes header to xml file
% Complex is 1 when our data is complex and 0 if our data is real

% Check file_name
assert(ischar(file_name), 'file_name must be a string');

% Check number of arguments
assert(nargin >= 2 || nargin <= 7,'# of input arguments should be between 2 and 7');

dims = length(n);

% Set the default values in case we have less than 7 arguments
if(nargin < 7)
    complex = 0;
    if(nargin < 5)
        for i=1:dims
        u(i) = {['u',int2str(i)]};
        end
    end
    if(nargin < 5)
        for i=1:dims
        l(i) = {['l',int2str(i)]};
        end
    end
    if(nargin < 4)
        for i=1:dims
        o(i) = 0;
        end
    end
    if(nargin < 3)
        for i=1:dims
        d(i) = 1;
        end
    end
end % if

% Check complex
assert(complex == 0 || complex == 1,'complex should be either 0 or 1');

docNode = com.mathworks.xml.XMLUtils.createDocument... 
    ('memmap');

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

% Setting the xml file name
xmlFileName = [file_name,'.xml'];
xmlwrite(xmlFileName,docNode);
%type(xmlFileName);

end % function