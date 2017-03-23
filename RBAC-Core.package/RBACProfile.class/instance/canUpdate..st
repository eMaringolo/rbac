permissions
canUpdate: anObject
	"Answer whether receiver can update anObject."
	
	^(self permissionFor: anObject) canUpdate