final invalidSignIn = {
  "statusCode": 401,
  "success": false,
  "message": "Invalid credentials.",
  "errorMessages": [
    {"path": '', "message": "Invalid credentials."}
  ]
};

final noUserSignIn = {
  "statusCode": 404,
  "success": false,
  "message": "User not found !",
  "errorMessages": [
    {"path": '', "message": "User not found !"}
  ]
};

final invalidUserData = {
  "statusCode": 400,
  "success": false,
  "message": "Invalid requested Id",
  "errorMessages": [
    {"path": "", "message": "Invalid requested Id"}
  ]
};
