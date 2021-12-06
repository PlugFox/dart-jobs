import 'package:dart_jobs_server/src/common/util/jwt.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main([List<String>? args]) => group(
      'firebase_token',
      () {
        /*
        test(
          'check HS256 JWT',
          () {
            final sourceJwt = JWT.decode(token);
            const secret = 'your-256-bit-secret';
            final hs256Jwt = JWT.create(
              header: <String, Object?>{
                ...sourceJwt.header,
                'alg': 'HS256',
              },
              payload: sourceJwt.payload,
              secret: secret,
            );

            expect(hs256Jwt.validateSignature(secret), isTrue);

          },
        );
       */

        test(
          'decode and validate',
          () {
            final jwt = JWT.decode(token);
            expect(
                jwt.validatePayload(
                  dateTime: DateTime(2021, 12, 06, 00, 50, 20),
                  tolerance: const Duration(hours: 1),
                ),
                equals(<String>{}));
          },
        );
      },
    );

const String token =
    'eyJhbGciOiJSUzI1NiIsImtpZCI6IjQ3OTg5ZTU4ZWU1ODM4OTgzZDhhNDQwNWRlOTVkYTllZTZmNWVlYjgiLCJ0eXAiOiJKV1QifQ.'
    'eyJuYW1lIjoiUGxhZ3VlIEZveCIsInBpY3R1cmUiOiJodHRwczovL2xoMy5nb29nbGV1c2VyY29udGVudC5jb20vYS0vQU9oMTRHaVR'
    'oR3VTYXJ4cW40LXRBVHRycVhqLVdnQVBVNk9TdU5rUnZPbkI9czk2LWMiLCJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS'
    '5jb20vZGFydC1qb2IiLCJhdWQiOiJkYXJ0LWpvYiIsImF1dGhfdGltZSI6MTYzNTA5NzIzNywidXNlcl9pZCI6IldXUTQyaUFJN3dhV'
    'E9uWXFHZTNCMG9PTHUzdjEiLCJzdWIiOiJXV1E0MmlBSTd3YVRPbllxR2UzQjBvT0x1M3YxIiwiaWF0IjoxNjM4NzM3MTgwLCJleHAi'
    'OjE2Mzg3NDA3ODAsImVtYWlsIjoicGx1Z2ZveEBnbWFpbC5jb20iLCJlbWFpbF92ZXJpZmllZCI6dHJ1ZSwiZmlyZWJhc2UiOnsiaWR'
    'lbnRpdGllcyI6eyJnb29nbGUuY29tIjpbIjEwODk4MjMxNzcwMjY3MzQ2NzA0MSJdLCJlbWFpbCI6WyJwbHVnZm94QGdtYWlsLmNvbS'
    'JdfSwic2lnbl9pbl9wcm92aWRlciI6Imdvb2dsZS5jb20ifX0.fvW0lnWy_Tb3zJjbv8HTmovIxOkjMy6FcycUcT5uhh0kas_Oh6Ptr'
    'xttnC4WzfJcbYBmKHtf6yZjkefEXlvQYzRtTUmI105wCcHc9ClLUsUHaxJTqdwF9Ju07w3CZTJ2c8fgYLfV9-E5P1NxNmJYoSfXydyN'
    'gkY1itpNascbxhubjPYxWIdaqI-GVym5EneUMPQPT_fK6BX0DQj9_tyi5_jtsQ0XlKCqe_G_RqXBPaRQrdadgmGLU1xgJ057LhaQySc'
    'i8RNZIFAQoXPeknVpH5pOSJvas2-tVEgQRcAly0GS985Jc8Yb85Jh-_9yZ40BBUR4eKpWRa-1bWKyJMGFEg';

const String publicKey = '-----BEGIN CERTIFICATE-----\n'
    'MIIDHDCCAgSgAwIBAgIII7O5oU2RhSYwDQYJKoZIhvcNAQEFBQAwMTEvMC0GA1UE\n'
    'AxMmc2VjdXJldG9rZW4uc3lzdGVtLmdzZXJ2aWNlYWNjb3VudC5jb20wHhcNMjEx\n'
    'MjAyMDkzODM2WhcNMjExMjE4MjE1MzM2WjAxMS8wLQYDVQQDEyZzZWN1cmV0b2tl\n'
    'bi5zeXN0ZW0uZ3NlcnZpY2VhY2NvdW50LmNvbTCCASIwDQYJKoZIhvcNAQEBBQAD\n'
    'ggEPADCCAQoCggEBAJWqxjZ9ulXgFsMhrGxBLCg0FeUSjqFwfoQqnB9PnrnYSthf\n'
    '/Xvt9S+JczjI58z1pcL9c5SJ5e4l+LILGd/NZFih2G319UQOwfgDNcJz2kU15WCM\n'
    '2jPYyDsrLMB8uSAbxa2MQ0mcwMJVtqKA/9X4gxhXis97WfDr4yBZVwDgrH/XWu70\n'
    'jMcOK0fuy55z3+JE15RY/e1MF4MW5WeSsO7ivbPSB5WjZ1zsXVFJgXIv+g3KCOsJ\n'
    '8965t7pU8TJTdVbwYz/bcTpNS2IPwGRJ36xLxVhRF180jOFYYrt7Bt2FNOLz11Bq\n'
    'BlHiFOWGIxgEgACW2m4i7IYebKh32/wNZrKqR2ECAwEAAaM4MDYwDAYDVR0TAQH/\n'
    'BAIwADAOBgNVHQ8BAf8EBAMCB4AwFgYDVR0lAQH/BAwwCgYIKwYBBQUHAwIwDQYJ\n'
    'KoZIhvcNAQEFBQADggEBAEMGDqebmz0BgBOvmiCWAhcR+fWtgimuA/SHnz2Ah+Bi\n'
    'Jc7s8OMlyKigtusAC+bWJIXiSc1XOlvghupYFxKELbbqDchzI+/OV0ZT9uyt4gAy\n'
    'Ib6HO9o6h/3jir78nWjVXvUysKQX7woexujVLC1kw6HOmaPvqYxU/X4V3dvSHfVk\n'
    'xx/Rv6j9HuF+VHSCMehZ1ghr6IZxX4ForkFk640RLyaLXt+nxW8xxK70CaBJJTU8\n'
    'KJX66mGIeDuMB/23R3oqxR5c38tlKUOb6LYHK5ru74R4zEJG0DAJAMm6iBTEhSGX\n'
    'qMqv5G974Xbm5B4XrE8Msw5YC0c50mjKkgiZWl8a7Ro=\n'
    '-----END CERTIFICATE-----\n';
