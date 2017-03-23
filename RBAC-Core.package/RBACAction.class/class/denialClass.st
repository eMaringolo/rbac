uncategorized
denialClass
	^ Smalltalk at: (self name , 'Denied') asSymbol ifAbsent: [ RBACActionDenied ]