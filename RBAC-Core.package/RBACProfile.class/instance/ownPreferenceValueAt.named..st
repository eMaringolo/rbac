testing
ownPreferenceValueAt: sectionName named: preferenceName
	^ (self ownPreferenceAt: sectionName named: preferenceName) ifNotNil: [ :p | p value ]