function header = setHeaderLeftChunk(header,H,index,all_hell_breaks_loose)
%SETHEADERLEFTCHUNK subsasgn for header
%   HEADER = setHeaderLeftChunk(HEADER,H,INDEX) "subassigns" the smaller
%   header H into the parent header HEADER according to the indices INDEX.
%   
%   Left slice assignment:
%   HEADER = setHeaderLeftChunk(HEADER,H,i) will insert header H into the
%   ith slice of HEADER and return HEADER (eg. if this were a 5D
%   datacontainer it would have been as if HEADER(:,:,:,:,i) = H were
%   called, even if it may not make much sense). Do note that strict
%   compliance of units and labels will be checked before insertion, so
%   make sure your units are in order!
%
%   HEADER = setHeaderLeftChunk(HEADER,H,[ i1 i2 i3 ]) will insert header H
%   into the [i1 i2 i3]th slice of HEADER and return HEADER (eg. if this
%   were a 5D datacontainer if would have been as if HEADER(:,:,i1,i2,i3) =
%   H were called, even if it may not make much sense). Do note that strict
%   compliance of units and labels will be checked before insertion, so
%   make sure your units are in order!
%
%   
