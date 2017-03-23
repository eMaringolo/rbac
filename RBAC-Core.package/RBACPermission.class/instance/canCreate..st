querying
canCreate: class
	^ self allowsCreation and: [ self notExpired ]