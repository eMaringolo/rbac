testing
ownPreferenceAt: sectionName named: preferenceName
	^ self preferences
		detect: [ :one | one section = sectionName and: [ one name = preferenceName ] ]
		ifNone: [ nil ]