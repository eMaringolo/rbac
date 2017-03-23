permissions
permissionFor: anObject
	^ self groups
		inject: (super permissionFor: anObject) asTransient
		into: [ :perm :group | 
			perm
				permissionOr: (group permissionFor: anObject) ]