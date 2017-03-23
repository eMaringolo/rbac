permissions
permissionFor: anObject
	| permissions |
	permissions := OrderedCollection new.
	self roles do: [ :each | permissions add: (each permissionFor: anObject) ].
	^ permissions inject: (RBACTransientPermission target: anObject) into: [ :answer :perm | answer mergeFrom: perm ]