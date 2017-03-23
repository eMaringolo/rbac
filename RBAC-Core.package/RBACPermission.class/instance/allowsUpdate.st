accessing
allowsUpdate
	^ (bits bitAnd: 2r100) ~= 0