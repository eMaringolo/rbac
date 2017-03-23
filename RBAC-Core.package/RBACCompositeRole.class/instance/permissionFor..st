permissions
permissionFor: anObject 
	"Answer the CRUD permission of the receiver for anObject."

	| permissions |
	permissions := OrderedCollection new.
	self allSubrolesDo: 
			[:each | 
			| perm |
			(perm := each permissionFor: anObject) isTransient ifFalse: [permissions add: perm]].
	^permissions inject: (RBACTransientPermission target: anObject)
		into: [:answer :perm | answer permissionOr: perm]