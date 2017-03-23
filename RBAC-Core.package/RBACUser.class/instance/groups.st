accessing
groups
	"Answer the groups to which the receiver belongs."

	groups ifNil: [self initializeGroups].
	^groups