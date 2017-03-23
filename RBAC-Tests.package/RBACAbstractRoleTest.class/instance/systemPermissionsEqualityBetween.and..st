uncategorized
systemPermissionsEqualityBetween: aCollection and: anotherCollection 

	"Private - Answer true if aCollection is equal to anotherCollection."



	aCollection size = anotherCollection size ifFalse: [^false].

	aCollection do: [:sysop | anotherCollection detect: [:sysop2 | (self systemPermissionEqualityBetween: sysop and: sysop2)] ifNone: [^false]].

	^true