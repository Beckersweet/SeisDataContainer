function DataSliceWrite(filename,dimensions,tempdirname,varargin)
%DATASLICEWRITE Merges the slice binary files into one binary file 
%
%   DataSliceWrite(FILENAME,DIMENSIONS,PARAM1,VALUE1,PARAM2,VALUE2,...)
%   reads the binary file specified by FILENAME and stores the real data in 
%   seperate directories depending on the number of labs. 
%   Addtional parameters include:
%   OFFSET    - An integer specifying the number of bits to skip from the 
%               start of file before actual reading occurs, defaults to 0
%   PRECISION - A string specifying the precision of one unit of data, 
%               defaults to 'double' (8 bits)
%               Supported precisions: 'double', 'single'
%   REPEAT    - Positive integer or Inf (defaults to Inf).
%               Number of times to apply the specified format to the mapped
%               region of the file. If Inf, repeat until end of file. 
%
%   Note: The absolute path to the file must be provided.
end