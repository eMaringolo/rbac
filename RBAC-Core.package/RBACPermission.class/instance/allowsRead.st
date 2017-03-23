accessing
allowsRead
	^ (bits bitAnd: 2r10) ~= 0