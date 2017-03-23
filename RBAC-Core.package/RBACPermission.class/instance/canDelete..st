querying
canDelete: class
	^ self allowsDeletion and: [ self notExpired ]