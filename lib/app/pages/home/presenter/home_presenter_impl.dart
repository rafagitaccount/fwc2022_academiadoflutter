import 'dart:developer';

import 'package:fwc_album_app/app/pages/home/view/home_view.dart';
import 'package:fwc_album_app/app/repository/user/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './home_presenter.dart';

class HomePresenterImpl implements HomePresenter {
  final UserRepository userRepository;
  late HomeView _view;

  HomePresenterImpl({
    required this.userRepository,
  });

  @override
  Future<void> getUserData() async {
    try {
      _view.showLoader();
      final user = await userRepository.getMe();
      _view.updateUser(user);
    } on Exception catch (e, s) {
      log('Erro ao buscar dados do usuário', error: e, stackTrace: s);
      _view.error('Erro ao buscar dados do usuário');
    }
  }

  @override
  set view(HomeView view) => _view = view;

  @override
  Future<void> logout() async {
    _view.showLoader();
    final sp = await SharedPreferences.getInstance();
    await sp.clear();
    _view.logoutSuccess();
  }
}
