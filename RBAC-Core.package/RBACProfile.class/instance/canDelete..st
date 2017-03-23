permissions
canDelete: anObject
	"Answer whether receiver can delete anObject."
	
	^(self permissionFor: anObject) canDelete