accessing
members
	"Answer the value of the receiver's ''members'' instance variable."

	members ifNil: [self initializeMembers].
	^members