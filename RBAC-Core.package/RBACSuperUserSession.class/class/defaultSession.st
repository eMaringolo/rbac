uncategorized
defaultSession
	"Answer the default session."

	^self for: (RBACUser atName: self superUserName)