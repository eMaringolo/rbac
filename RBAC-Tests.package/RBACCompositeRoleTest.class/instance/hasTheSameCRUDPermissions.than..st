uncategorized
hasTheSameCRUDPermissions: aCollection than: anotherCollection 

	"Private - Answer true if aCollection has the same CRUDPermissions than anotherCollection not necessarily at the same order."



	aCollection size = anotherCollection size ifFalse: [^false].

	aCollection do: [:each | (self isIncluded: each in: anotherCollection) ifFalse: [^false]].

	^true