permissions
permissionFor: anObject 

	| perm |
	perm := self permissions detect: [:one | one target = anObject ] ifNone: [nil].
	^perm 
		ifNil: [RBACTransientPermission role: self target: anObject]
		ifNotNil: [perm target = anObject ifTrue: [perm] ifFalse: [perm asTransient target: anObject]]