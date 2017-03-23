instance creation
section: sectionString named: nameString value: anObject
	^ (self named: nameString section: sectionString)
		value: anObject;
		yourself