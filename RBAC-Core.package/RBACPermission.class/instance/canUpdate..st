querying
canUpdate: class
	^ self allowsUpdate and: [ self notExpired ]