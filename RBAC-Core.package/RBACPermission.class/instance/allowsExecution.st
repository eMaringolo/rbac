accessing
allowsExecution
	^(bits bitAnd: 2r10000) ~= 0