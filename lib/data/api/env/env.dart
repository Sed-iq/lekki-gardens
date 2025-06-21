import 'package:envied/envied.dart';
part 'env.g.dart';

@Envied()
abstract class Env{
  @EnviedField(varName: "MVVMTEMPLATE_REMOTE_BASEURL")
  static const String MVVMTEMPLATE_REMOTE_BASEURL = _Env.MVVMTEMPLATE_REMOTE_BASEURL;


}