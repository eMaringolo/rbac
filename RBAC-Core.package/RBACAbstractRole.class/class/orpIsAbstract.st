uncategorized
orpIsAbstract
	"Answer whether the receiver is an Abstract type.
	This should be redefined for Abstract subclasses that wants
	special treatment for #at: and #all registering messages.
	Implementation Note: We are using the #orp prefix to avoid
	problems with #isAbstract defined for Development by Object Arts."
	
	^self name = RBACAbstractRole name