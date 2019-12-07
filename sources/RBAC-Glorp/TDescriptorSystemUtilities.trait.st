Trait {
	#name : #TDescriptorSystemUtilities,
	#category : #'RBAC-Glorp'
}

{ #category : #'models-convenience' }
TDescriptorSystemUtilities >> addDatedModelAttributesTo: aClassModel entityClass: aClass [
	
	self addDatedModelAttributesTo: aClassModel entityClass: aClass usesTime: aClassModel describedClass usesDateAndTime
]

{ #category : #'models-convenience' }
TDescriptorSystemUtilities >> addDatedModelAttributesTo: aClassModel entityClass: aClass usesTime: usesTime [
	self addIdAttributeTo: aClassModel.
	aClassModel newAttributeNamed: #businessDate.
	usesTime ifTrue: [ aClassModel newAttributeNamed: #dateAndTime ].
	aClassModel newAttributeNamed: #entity type: aClass.
	aClassModel newAttributeNamed: #comments.
]

{ #category : #'tables-convenience' }
TDescriptorSystemUtilities >> addDatedModelFieldsTo: aTable entityTable: entityTable [

	self addDatedModelFieldsTo: aTable entityTable: entityTable usesTime: false
]

{ #category : #'tables-convenience' }
TDescriptorSystemUtilities >> addDatedModelFieldsTo: aTable entityTable: entityTable usesTime: usesTime [

	self addDatedModelFieldsTo: aTable entityTable: entityTable usesTime: usesTime usesComments: false
]

{ #category : #'tables-convenience' }
TDescriptorSystemUtilities >> addDatedModelFieldsTo: aTable entityTable: entityTable usesTime: usesTime usesComments: usesComments [
	| entityId |
	entityId := aTable createFieldNamed: 'entity_id' type: self platform integer.
	aTable addForeignKeyFrom: entityId to: (entityTable fieldNamed: 'id').
	aTable createFieldNamed: 'businessDate' type: self platform date.
	usesTime ifTrue: [ 
		aTable createFieldNamed: 'dateAndTime' type: self platform dateAndTime
		].
	usesComments ifTrue: [ 
		aTable createFieldNamed: 'comments' type: (self platform varchar: 1000)
	]
]

{ #category : #'mappings-convenience' }
TDescriptorSystemUtilities >> addDatedModelMappingsTo: aDescriptor table: table [
	self
		addDatedModelMappingsTo: aDescriptor
		table: table
		entityTable: nil
		usesTime: false
		usesComments: false
]

{ #category : #'mappings-convenience' }
TDescriptorSystemUtilities >> addDatedModelMappingsTo: aDescriptor table: table entityTable: entityTable usesTime: usesTime usesComments: usesComments [
	| entityMapping  |
	self addIdMappingTo: aDescriptor table: table.
	(aDescriptor newMapping: DirectMapping) from: #businessDate to: (table fieldNamed: 'businessDate').
	usesTime 
		ifTrue: [(aDescriptor newMapping: DirectMapping) from: #dateAndTime to: (table fieldNamed: 'dateAndTime') ].
	entityMapping := (aDescriptor newMapping: OneToOneMapping) attributeName: #entity.
	entityTable notNil ifTrue: [ entityMapping join: (
								Join	
									from: (table fieldNamed: 'entity_id')
									to: (entityTable fieldNamed: 'id'))].
	usesComments ifTrue: [ 
		(aDescriptor newMapping: DirectMapping) from: #comments to: (table fieldNamed: 'comments') ]
]

{ #category : #'mappings-convenience' }
TDescriptorSystemUtilities >> addDatedModelMappingsTo: aDescriptor table: table usesTime: aBoolean [
	self
		addDatedModelMappingsTo: aDescriptor
		table: table
		entityTable: nil
		usesTime: aBoolean
		usesComments: false
]

{ #category : #'models-convenience' }
TDescriptorSystemUtilities >> addIdAttributeTo: aClassModel [
	(aClassModel newAttributeNamed: #id) useDirectAccess: true
]

{ #category : #'tables-convenience' }
TDescriptorSystemUtilities >> addIdFieldTo: aTable [
	(aTable createFieldNamed: 'id' type: self platform sequence) bePrimaryKey
]

{ #category : #'mappings-convenience' }
TDescriptorSystemUtilities >> addIdMappingTo: aDescriptor table: table [
	(aDescriptor newMapping: DirectMapping) from: #id to: (table fieldNamed: 'id')
]

{ #category : #'tables-convenience' }
TDescriptorSystemUtilities >> addModelPartFieldsTo: aTable ownerTable: ownerTable [
	| ownerId |
	ownerId := aTable createFieldNamed: 'owner_id' type: self platform integer.
	aTable addForeignKeyFrom: ownerId to: (ownerTable fieldNamed: 'id')
]

{ #category : #'mappings-convenience' }
TDescriptorSystemUtilities >> addModelPartMappingsTo: aDescriptor table: table ownerClass: aClass [
	self addIdMappingTo: aDescriptor table: table.
	(aDescriptor newMapping: OneToOneMapping )
		attributeName: #owner; 
		referenceClass: aClass
]

{ #category : #'models-convenience' }
TDescriptorSystemUtilities >> addNameAttributeTo: aClassModel [
	aClassModel newAttributeNamed: #name
]

{ #category : #'tables-convenience' }
TDescriptorSystemUtilities >> addNameFieldTo: aTable [
	aTable createFieldNamed: 'name' type: (self platform varChar: 100)
]

{ #category : #'mappings-convenience' }
TDescriptorSystemUtilities >> addNameMappingTo: aDescriptor table: table [
	(aDescriptor newMapping: DirectMapping) from: #name to: (table fieldNamed: 'name')
]

{ #category : #'models-convenience' }
TDescriptorSystemUtilities >> addNamedModelAttributesTo: aClassModel [
	self addIdAttributeTo: aClassModel.
	self addNameAttributeTo: aClassModel
]

{ #category : #'mappings-convenience' }
TDescriptorSystemUtilities >> addNamedModelMappingsTo: aDescriptor table: table [
	self addIdMappingTo: aDescriptor table: table.
	self addNameMappingTo: aDescriptor table: table
]

{ #category : #'tables-convenience' }
TDescriptorSystemUtilities >> addReferenceFieldNamed: aString to: aTable ownerTable: ownerTable [
	| referenceId |
	referenceId := aTable createFieldNamed: aString type: self platform integer.
	aTable addForeignKeyFrom: referenceId to: (ownerTable fieldNamed: 'id').
	^referenceId
]

{ #category : #'tables-convenience' }
TDescriptorSystemUtilities >> addTableFieldsForNamedModel: aTable [
	self addIdFieldTo: aTable.
	self addNameFieldTo: aTable
]

{ #category : #'mappings-convenience' }
TDescriptorSystemUtilities >> addUserMappingTo: aDescriptor [

	(aDescriptor newMapping: OneToOneMapping ) attributeName: #user; referenceClass: RBACUser
]

{ #category : #'models-convenience' }
TDescriptorSystemUtilities >> addVersioningAttributesTo: aClassModel [

	aClassModel newAttributeNamed: #creationTs.
	aClassModel newAttributeNamed: #modificationTs
]

{ #category : #'tables-convenience' }
TDescriptorSystemUtilities >> addVersioningFieldsTo: aTable [

	aTable createFieldNamed: 'created_at' type: ((self platform versionFieldFor: self platform timestamp) generatesOverExistingValues: false).
	aTable createFieldNamed: 'modified_at' type: (self platform versionFieldFor: self platform timestamp) generateOverExistingValues.
]

{ #category : #'mappings-convenience' }
TDescriptorSystemUtilities >> addVersioningMappingsTo: aDescriptor table: table [

	(aDescriptor newMapping: DirectMapping) from: #creationTs
		to: (table fieldNamed: 'created_at').
	(aDescriptor newMapping: DirectMapping) from: #modificationTs
		to: (table fieldNamed: 'modified_at')
]

{ #category : #converters }
TDescriptorSystemUtilities >> classToStringConverter [

	^PluggableDatabaseConverter new
		dbToStConverter: [:value | value notNil ifTrue: [Smalltalk at: value asSymbol ]];
		stToDbConverter: [:class | class ifNotNil: [:c | c name asString ]];
		yourself
]

{ #category : #'mappings-convenience' }
TDescriptorSystemUtilities >> configureTsPersonaDescriptor: aDescriptor [
	| table |
	table := self tableNamed: 'PERSONA'.
	aDescriptor table: table.
	self addIdMappingTo: aDescriptor table:  table.
	(aDescriptor newMapping: DirectMapping) from: #name to:  (table fieldNamed: 'name').
	(aDescriptor newMapping: DirectMapping) from: #class to:  (table fieldNamed: 'class'); beReadOnly.	
	(aDescriptor newMapping: OneToOneMapping ) attributeName: #address.
	(aDescriptor newMapping: DirectMapping) from: #category to:  (table fieldNamed: 'category').
	(aDescriptor newMapping: DirectMapping) from: #phone to:  (table fieldNamed: 'phone').	
	(aDescriptor newMapping: DirectMapping) from: #email to:  (table fieldNamed: 'email').			
	(aDescriptor newMapping: DirectMapping) from: #email2 to:  (table fieldNamed: 'email2').
	(aDescriptor newMapping: DirectMapping) from: #comments to:  (table fieldNamed: 'comments').
]
