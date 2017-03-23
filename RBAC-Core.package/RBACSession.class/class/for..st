uncategorized
for: aRBACUser
	"Answer a new instance of receiver, created for aRBACUser."
	
	^self new
		user: aRBACUser;
		creationTime: DateAndTime now;
		yourself