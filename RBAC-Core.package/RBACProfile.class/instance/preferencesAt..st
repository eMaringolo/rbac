preferences
preferencesAt: sectionName
	| dict |
	dict := Dictionary new.
	dict
		addAll:
			(self ownOrInheritedPreferences
				select: [ :each | each section = sectionName ]
				thenCollect: [ :each | each name -> each ]).
	^ dict