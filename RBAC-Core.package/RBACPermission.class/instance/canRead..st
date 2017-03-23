querying
canRead: class
	^ self allowsRead and: [ self notExpired ]