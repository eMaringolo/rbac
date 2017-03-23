members
includesMember: aRBACProfile
	"Answer whether receiver includes aRBACProfile as one of its members."

	^ self members anySatisfy: [ :one | one = aRBACProfile ]