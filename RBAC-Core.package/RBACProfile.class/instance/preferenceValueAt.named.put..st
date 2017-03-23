preferences
preferenceValueAt: sectionName named: preferenceName put: newValue
	^ ((self preferenceValueAt: sectionName named: preferenceName)
		ifNil: [ self preferences add: (self profilePreferenceClass named: preferenceName section: sectionName) ])
		value: newValue