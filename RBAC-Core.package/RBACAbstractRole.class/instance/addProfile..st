members
addProfile: aRBACProfile

	(self hasProfile: aRBACProfile) ifFalse: [ 
		self profiles add: aRBACProfile.
		aRBACProfile onAddedToRole: self]