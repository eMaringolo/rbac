roles
subroles
	"Answer the value of the receiver's ''subroles'' instance variable."

	subroles ifNil: [self initializeSubroles].
	^subroles