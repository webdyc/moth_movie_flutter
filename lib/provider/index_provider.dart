import 'package:moth_movie/provider/player_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'banner_provider.dart';

List<SingleChildStatelessWidget> Providers = [
  ChangeNotifierProvider(create: (context) {
    return BannerProvider();
  }),
  ChangeNotifierProvider(create: (context) {
    return PlayerProvider();
  }),
];
