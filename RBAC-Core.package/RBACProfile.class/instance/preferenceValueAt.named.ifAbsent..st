preferences
preferenceValueAt: sectionName named: preferenceName ifAbsent: aBlock
	^ (self preferenceAt: sectionName named: preferenceName)
		ifNil: aBlock
		ifNotNil: [ :p | p value ]