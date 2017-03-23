permissions
addPermission: aRBACPermission
	| previous |
	aRBACPermission role: self.
	^ (self hasPermissionFor: aRBACPermission target)
		ifTrue: [ (self permissionFor: aRBACPermission target) mergeFrom: aRBACPermission ]
		ifFalse: [ self permissions add: aRBACPermission ]