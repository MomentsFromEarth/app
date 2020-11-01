import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_core/amplify_core.dart';

import '../aws/amplify_config.dart';

class AmplifyService {
  static final _instance = AmplifyService._internal();

  AmplifyService._internal();

  // Instantiate Amplify
  Amplify amplifyInstance = Amplify();

  init() async {
    AmplifyAuthCognito authPlugin = AmplifyAuthCognito();
    amplifyInstance.addPlugin(authPlugins: [authPlugin]);
    await amplifyInstance.configure(amplifyconfig);
  }

  Future<bool> loggedIn() async {
    CognitoAuthSession sess = await Amplify.Auth.fetchAuthSession(options: CognitoSessionOptions(getAWSCredentials: true));
    return sess.isSignedIn;
  }

  static AmplifyService getInstance() {
    return _instance;
  }
}
