uncategorized
systemPermissionEqualityBetween: aSystemPermission and: anotherSystemPermission 

	"Private - Answer true if aSystemPermission is equal to anotherSystemPermission."



	^(aSystemPermission role equals: anotherSystemPermission role) 

		& (aSystemPermission operation = anotherSystemPermission operation)