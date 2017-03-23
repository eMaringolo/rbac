members
removeMember: aRBACUser 
	"Adds aRBACProfile to the receiver members."

	self members remove: aRBACUser ifAbsent: [].
	aRBACUser onRemovedFromGroup: self