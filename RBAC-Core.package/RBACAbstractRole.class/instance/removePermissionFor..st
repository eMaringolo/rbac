permissions
removePermissionFor: target
	| perm |
	(perm := self permissionFor: target) isTransient
		ifFalse: [ self permissions remove: perm ].
	^ perm