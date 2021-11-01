import 'package:shelf/shelf.dart';

typedef OriginChecker = bool Function(String origin);

const String accessControlAllowOrigin = 'Access-Control-Allow-Origin';
const String accessControlExposeHeaders = 'Access-Control-Expose-Headers';
const String accessControlAllowCredentials = 'Access-Control-Allow-Credentials';
const String accessControlAllowHeaders = 'Access-Control-Allow-Headers';
const String accessControlAllowMethods = 'Access-Control-Allow-Methods';
const String accessControlMaxAge = 'Access-Control-Max-Age';

const String _origin = 'origin';

const List<String> _defaultHeadersList = <String>[
  'accept',
  'accept-encoding',
  'authorization',
  'content-type',
  'dnt',
  'origin',
  'user-agent',
];

const List<String> _defaultMethodsList = <String>['DELETE', 'GET', 'OPTIONS', 'PATCH', 'POST', 'PUT'];

final Map<String, String> _defaultHeaders = <String, String>{
  accessControlExposeHeaders: '',
  accessControlAllowCredentials: 'true',
  accessControlAllowHeaders: _defaultHeadersList.join(','),
  accessControlAllowMethods: _defaultMethodsList.join(','),
  accessControlMaxAge: '86400',
};

final Map<String, List<String>> _defaultHeadersAll = _defaultHeaders.map<String, List<String>>(
  (key, value) => MapEntry(
    key,
    <String>[value],
  ),
);

Middleware corsHeaders({
  Map<String, String>? headers,
  OriginChecker originChecker = originAllowAll,
}) {
  final headersAll = headers?.map((key, value) => MapEntry(key, [value]));
  return (Handler handler) => (Request request) async {
        final origin = request.headers[_origin];
        if (origin == null || !originChecker(origin)) {
          return handler(request);
        }
        final headers = <String, List<String>>{
          ..._defaultHeadersAll,
          ...?headersAll,
          accessControlAllowOrigin: <String>[origin],
        };

        if (request.method == 'OPTIONS') {
          return Response.ok(null, headers: headers);
        }

        final response = await handler(request);
        return response.change(headers: {...response.headersAll, ...headers});
      };
}

bool originAllowAll(String origin) => true;
OriginChecker originOneOf(List<String> origins) => (origin) => origins.contains(origin);
