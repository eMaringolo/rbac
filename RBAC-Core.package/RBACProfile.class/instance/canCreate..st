permissions
canCreate: anObject
	"Answer whether receiver can create anObject."
	
	^(self permissionFor: anObject) canCreate