import 'package:tomasfamilyapp/redux/actions.dart';
import 'package:tomasfamilyapp/redux/state.dart';
import 'package:redux/redux.dart';
import 'package:tomasfamilyapp/models/GalleryService.dart';

void uploadImageMiddleware(Store<AppState> store, dynamic action, NextDispatcher next) async {
  if (action is UploadImage) {
    if (store.state.user != null) {
      final service = GalleryService(familyId: store.state.user.family);
      service.uploadImage(action.path);
      store.dispatch(LoadGallery());
    }
  }
  next(action);
}