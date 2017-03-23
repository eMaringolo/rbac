uncategorized
hasPermissionFor: target
	| testBlock |
	testBlock := [ :each | 
	(each permissions anySatisfy: [ :perm | perm target = target ])
		ifTrue: [ ^ true ] ].
	testBlock value: self.
	self allSubrolesDo: testBlock.
	^ false