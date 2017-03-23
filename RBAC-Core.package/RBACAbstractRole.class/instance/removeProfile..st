members
removeProfile: aRBACProfile
	
	self profiles remove: aRBACProfile.
	aRBACProfile onRemovedFromRole: self