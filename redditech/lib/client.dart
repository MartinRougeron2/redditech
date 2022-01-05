import 'package:draw/draw.dart';
import 'token.dart' as token;
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:reditech/api.dart';

class RedditClient
{
    Reddit reddit = Reddit.createInstalledFlowInstance(
        clientId: "K8_N7ZiJEjVTZgw8FOltdQ",
        userAgent: "reditech",
        redirectUri: Uri.parse("com.example.reditech://success")
    );
    
    void launch() async
    {
        final authUrl = reddit.auth.url(['*'], "reditech", compactLogin: true);
        setData("AUTHURL", authUrl.toString());
        setData("CALLBACK", "reditech");
        final result = await FlutterWebAuth.authenticate(
            url: authUrl.toString(),
            callbackUrlScheme: "reditech"
        );
        String? code = Uri.parse(result).queryParameters['code'];
        await reddit.user.me();
        print("CODE ${code}");
    }
}

