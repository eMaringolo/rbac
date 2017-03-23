roles
removeRole: aRole ifAbsent: exceptionBlock
	^ self roles remove: aRole ifAbsent: exceptionBlock