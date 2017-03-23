permissions
includesPermissionFor: target
	^ self permissions anySatisfy: [ :one | one target = target ]