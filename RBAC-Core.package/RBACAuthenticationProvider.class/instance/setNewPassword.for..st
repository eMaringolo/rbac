uncategorized
setNewPassword: aString for: aRBACUser 
	"Defines aString as the new password of aRBACUser."

	aRBACUser setNewPassword: (self preparePassword: aString)