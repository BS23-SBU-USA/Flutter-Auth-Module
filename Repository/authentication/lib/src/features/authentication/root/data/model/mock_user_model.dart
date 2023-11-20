class MockUserModel {
  String id;
  String email;
  String firstName;
  String lastName;
  String role;
  String password;
  String otp;

  MockUserModel({
    this.id = '1234',
    this.email = 'foo@foo.com',
    this.firstName = 'Mr. Foo',
    this.lastName = 'Khan',
    this.role = 'User',
    this.password = 'Foo@1234',
    this.otp = '123456',
  });

  get fullName => '$firstName $lastName';
}
