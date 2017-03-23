permissions
canRead: anObject
	"Answer whether receiver can read anObject."
	
	^(self permissionFor: anObject) canRead