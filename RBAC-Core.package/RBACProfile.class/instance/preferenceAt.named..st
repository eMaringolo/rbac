preferences
preferenceAt: sectionName named: preferenceName 
	"Answer the preference named preferenceName located in the 
	section named sectionName."

	^self ownOrInheritedPreferences detect: [:one | one section = sectionName and: [one name = preferenceName]]
		ifNone: [nil]