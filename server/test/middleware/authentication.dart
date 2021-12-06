import 'package:dart_jobs_server/src/common/middleware/authentication.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main([List<String>? args]) => group(
      'authentication',
      () {
        test(
          'extract jwt from headers',
          () {
            final jwt = getJwtFromHeaders(headers);
            expect(jwt?.payload.subject, equals('WWQ42iAI7waTOnYqGe3B0oOLu3v1'));
          },
        );
      },
    );

const Map<String, String> headers = <String, String>{
  'authorization': 'Bearer '
      'eyJhbGciOiJSUzI1NiIsImtpZCI6IjQ3OTg5ZTU4ZWU1ODM4OTgzZDhhNDQwNWRlOTVkYTllZTZmNWVlYjgiLCJ0eXAiOiJKV1QifQ.'
      'eyJuYW1lIjoiUGxhZ3VlIEZveCIsInBpY3R1cmUiOiJodHRwczovL2xoMy5nb29nbGV1c2VyY29udGVudC5jb20vYS0vQU9oMTRHaVR'
      'oR3VTYXJ4cW40LXRBVHRycVhqLVdnQVBVNk9TdU5rUnZPbkI9czk2LWMiLCJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS'
      '5jb20vZGFydC1qb2IiLCJhdWQiOiJkYXJ0LWpvYiIsImF1dGhfdGltZSI6MTYzNTA5NzIzNywidXNlcl9pZCI6IldXUTQyaUFJN3dhV'
      'E9uWXFHZTNCMG9PTHUzdjEiLCJzdWIiOiJXV1E0MmlBSTd3YVRPbllxR2UzQjBvT0x1M3YxIiwiaWF0IjoxNjM4ODI5NjA0LCJleHAi'
      'OjE2Mzg4MzMyMDQsImVtYWlsIjoicGx1Z2ZveEBnbWFpbC5jb20iLCJlbWFpbF92ZXJpZmllZCI6dHJ1ZSwiZmlyZWJhc2UiOnsiaWR'
      'lbnRpdGllcyI6eyJnb29nbGUuY29tIjpbIjEwODk4MjMxNzcwMjY3MzQ2NzA0MSJdLCJlbWFpbCI6WyJwbHVnZm94QGdtYWlsLmNvbS'
      'JdfSwic2lnbl9pbl9wcm92aWRlciI6Imdvb2dsZS5jb20ifX0.Ye7DfCKKLq6zzZYU2Jbx9dobNPBUuzoIt-NBhaRXcyHU7zY5MMqE2'
      'ShDr_uXtHfEE5u9BirNqM-dbz6-W3-mlEgWeA2woZEuR1TL2tDbsVXPKK2j4c-WULwJTxnX3nIM6P-ROblKLUkuxRPhc4UI7uJ7ppWo'
      'fAYdF9gzUeJfnbKLpxgaj5C-5huLEdjPZJt0UA62f8VJEzppyui1IRP3gA3UmWh1lb5os'
};
