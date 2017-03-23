operations
permissionOr: permission
	^ self asTransient setBits: (self bits bitOr: permission bits)