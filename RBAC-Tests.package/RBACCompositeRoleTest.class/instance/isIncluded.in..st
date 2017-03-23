uncategorized
isIncluded: aCRUDPermission in: aCollection 

	"Private - Answer true if aCRUDPermission is included in aCollection."



	^(aCollection detect: [:one | self comparePermission: one with: aCRUDPermission] ifNone: []) notNil