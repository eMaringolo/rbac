Class {
	#name : #BaselineOfRBAC,
	#superclass : #BaselineOf,
	#category : #BaselineOfRBAC
}

{ #category : #baselines }
BaselineOfRBAC >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ spec
				package: 'RBAC-Core' with: [spec requires: #('Cryptography')];
				package: 'RBAC-Tests' with: [ spec requires: #('RBAC-Core') ];
				package: 'RBAC-Glorp' with: [ spec requires: #('RBAC-Core') ];
				package: 'RBAC-Seaside' with: [ spec requires: #('RBAC-Core') ].
				spec
				group: 'default' with: #('core' 'tests');
				group: 'core' with: #('RBAC-Core');
				group: 'glorp' with: #('RBAC-Glorp');
				group: 'seaside' with: #('core' 'Seaside') ].
]

{ #category : #baselines }
BaselineOfRBAC >> setUpDependencies: spec [
	spec
		baseline: 'Cryptography'
			with:
				[ spec repository: 'github://pharo-contributions/Cryptography/source' ];
		baseline: 'Glorp'
			with: [ spec repository: 'github://pharo-rdbms/glorp' ]
]
