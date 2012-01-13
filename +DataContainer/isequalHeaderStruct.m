function isequalHeaderStruct( header1,header2 )
%ISEQUALHEADERSTRUCT Compares the two header structs and returns 1 if all
%the header fields are equal, otherwise it returns 0

assertEqual(header1.varName,header2.varName)
assertEqual(header1.varUnits,header2.varUnits)
assertEqual(header1.dims,header2.dims)
assertEqual(header1.size,header2.size)
assertEqual(header1.origin,header2.origin)
assertEqual(header1.delta,header2.delta)
assertEqual(header1.label,header2.label)
assertEqual(header1.unit,header2.unit)
assertEqual(header1.precision,header2.precision)
assertEqual(header1.complex,header2.complex)
assertEqual(header1.distributedIO,header2.distributedIO)

end
