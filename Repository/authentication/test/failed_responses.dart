import 'package:network/network.dart';

final wrongSignIn = {
  "data": {
    "statusCode": 401,
    "success": false,
    "message": "Invalid credentials.",
    "errorMessages": [
      {"path": "", "message": "Invalid credentials."}
    ]
  },
  "message": "Invalid credentials."
};

// final failedSignIn = {
//   "code": '404',
//   "name": "Not Found",
//   "error": {
//     "statusCode": "404",
//     "success": 'false',
//     "message": "User not found !",
//     "errorMessages": [
//       {"path": "", "message": "User not found !"}
//     ]
//   }
// };

// final failedSignIn = {
//   "code": '404',
//   "name": "Not Found",
//   "error": {
//     "statusCode": 404,
//     "success": false,
//     "message": "User not found !",
//   }
// };

final failedSignIn = {
  "statusCode": 404,
  "success": false,
  "message": "User not found !",
  "errorMessages": [
    {"path": "", "message": "User not found !"}
  ]
};
