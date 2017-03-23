uncategorized
crudPermissionsEqualityBetween: aCollection and: anotherCollection 

	"Private - Answer true if aCollection is equal to anotherCollection."



	aCollection size = anotherCollection size ifFalse: [^false].

	aCollection with: anotherCollection

		do: [:sysop :sysop2 | (self comparePermission: sysop with: sysop2) ifFalse: [^false]].

	^true