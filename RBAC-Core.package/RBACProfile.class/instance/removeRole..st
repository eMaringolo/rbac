roles
removeRole: aRole
	self roles remove: aRole.
	aRole onRemovedFromProfile: self
	