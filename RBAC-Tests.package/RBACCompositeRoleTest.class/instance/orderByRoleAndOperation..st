uncategorized
orderByRoleAndOperation: aCollection 

	"Private - Order aCollection (that contains system permissions) by role and then by operation."



	^aCollection asSortedCollection: 

			[:a :b | 

			a role id < b role id | (a role id = b role id & (a operation id < b operation id))]