uncategorized
printOn: aStream
	aStream
		print: self section;
		nextPut: $.;
		print: self name;
		nextPut: $=;
		print: self value