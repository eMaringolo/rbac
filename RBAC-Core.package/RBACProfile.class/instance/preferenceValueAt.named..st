preferences
preferenceValueAt: sectionName named: preferenceName
	^ (self preferenceAt: sectionName named: preferenceName) ifNotNil: [ :p | p value ]