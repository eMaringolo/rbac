printing
printOn: aStream
	"Prints the receiver on aStream."

	aStream nextPut: ${.
	aStream
		nextPut:
			(self allowsCreation
				ifTrue: [ $C ]
				ifFalse: [ $- ]);
		nextPut:
			(self allowsRead
				ifTrue: [ $R ]
				ifFalse: [ $- ]);
		nextPut:
			(self allowsUpdate
				ifTrue: [ $U ]
				ifFalse: [ $- ]);
		nextPut:
			(self allowsDeletion
				ifTrue: [ $D ]
				ifFalse: [ $- ]);
		nextPut:
			(self allowsExecution
				ifTrue: [ $X ]
				ifFalse: [ $- ]);
		space;
		nextPutAll: self target printString;
		nextPut: $}