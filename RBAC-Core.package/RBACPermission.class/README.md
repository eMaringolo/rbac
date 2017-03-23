I represent a permission belonging to a role, defined for a target object.

The target of receiver can be a Class or any other object based on the business rules where I am used.

Among my different grants or denials I have the four CRUD operations and an Execution to secure the execution of target.

To be more compact I store the different grants as a single byte, each bit position represents a particular grant, from less significative bit, to more significative bit.
- Creation: 1st bit
- Read: 2nd bit
- Update: 3rd  bit
- Deletion: 4th bit
- Execution: 5th bit.

So for a Permission of Creation and Read, but not deletion, the bits would be 2r00011.


