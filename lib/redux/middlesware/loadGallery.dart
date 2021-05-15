import 'package:firebase_auth/firebase_auth.dart';
import 'package:tomasfamilyapp/redux/actions.dart';
import 'package:tomasfamilyapp/redux/state.dart';
import 'package:redux/redux.dart';
import 'package:tomasfamilyapp/models/GalleryService.dart';

void loadGalleryMiddleware(Store<AppState> store, dynamic action, NextDispatcher next) async {
  if (action is LoadGallery) {
    if (store.state.user != null) {
      final service = GalleryService(familyId: store.state.user.family);
      final imgs = await service.loadImages();
      store.dispatch(UpdateGallery(imgs));
    } else {
      store.dispatch(LoadUser(FirebaseAuth.instance.currentUser.uid));
      store.dispatch(LoadGallery());
    }
  }
  next(action);
}