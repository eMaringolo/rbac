roles
containsRole: aRole 

	aRole = self ifTrue: [^true].
	self allSubrolesDo: [:each | each = aRole ifTrue: [^true]].
	^false