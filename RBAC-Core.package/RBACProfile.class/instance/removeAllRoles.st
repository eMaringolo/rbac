roles
removeAllRoles
	self roles copy
		do: [ :each | 
			roles remove: each.
			each removeProfile: self ]