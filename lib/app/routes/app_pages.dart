import 'package:get/get.dart';

import '../modules/authentication/forgetpassword/bindings/forgetpassword_binding.dart';
import '../modules/authentication/forgetpassword/views/forgetpassword_view.dart';
import '../modules/authentication/login/bindings/login_binding.dart';
import '../modules/authentication/login/views/login_view.dart';
import '../modules/authentication/otpscreen/bindings/otpscreen_binding.dart';
import '../modules/authentication/otpscreen/views/otpscreen_view.dart';
import '../modules/authentication/register/bindings/register_binding.dart';
import '../modules/authentication/register/views/register_view.dart';
import '../modules/book/bookviewer/bindings/bookviewer_binding.dart';
import '../modules/book/bookviewer/views/bookviewer_view.dart';
import '../modules/book/detailbook/bindings/detailbook_binding.dart';
import '../modules/book/detailbook/views/detailbook_view.dart';
import '../modules/bookbypinjam/bindings/bookbypinjam_binding.dart';
import '../modules/bookbypinjam/views/bookbypinjam_view.dart';
import '../modules/bookkategoripage/bindings/bookkategoripage_binding.dart';
import '../modules/bookkategoripage/views/bookkategoripage_view.dart';
import '../modules/buktipeminjaman/bindings/buktipeminjaman_binding.dart';
import '../modules/buktipeminjaman/views/buktipeminjaman_view.dart';
import '../modules/dashboard/bindings/dashboard_binding.dart';
import '../modules/dashboard/views/dashboard_view.dart';
import '../modules/menu/bookmarks/bindings/bookmarks_binding.dart';
import '../modules/menu/bookmarks/views/bookmarks_view.dart';
import '../modules/menu/historypeminjaman/bindings/historypeminjaman_binding.dart';
import '../modules/menu/historypeminjaman/views/historypeminjaman_view.dart';
import '../modules/menu/home/bindings/home_binding.dart';
import '../modules/menu/home/views/home_view.dart';
import '../modules/menu/profile/views/profile_view.dart';
import '../modules/menu/ruangpustakapage/bindings/ruangpustakapage_binding.dart';
import '../modules/menu/ruangpustakapage/views/ruangpustakapage_view.dart';
import '../modules/onboarding/bindings/onboarding_binding.dart';
import '../modules/onboarding/views/onboarding_view.dart';
import '../modules/pagescanqrcode/bindings/pagescanqrcode_binding.dart';
import '../modules/pagescanqrcode/views/pagescanqrcode_view.dart';
import '../modules/menu/profile/bindings/profile_binding.dart';
import '../modules/splashscreen/bindings/splashscreen_binding.dart';
import '../modules/splashscreen/views/splashscreen_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASHSCREEN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SPLASHSCREEN,
      page: () => const SplashscreenView(),
      binding: SplashscreenBinding(),
    ),
    GetPage(
      name: _Paths.ONBOARDING,
      page: () => OnboardingView(),
      binding: OnboardingBinding(),
    ),
    GetPage(
        name: _Paths.LOGIN,
        page: () => const LoginView(),
        binding: LoginBinding(),
        transition: Transition.cupertinoDialog),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
      transition: Transition.cupertinoDialog,
    ),
    GetPage(
      name: _Paths.OTPSCREEN,
      page: () => const OtpscreenView(),
      binding: OtpscreenBinding(),
    ),
    GetPage(
      name: _Paths.FORGETPASSWORD,
      page: () => const ForgetpasswordView(),
      binding: ForgetpasswordBinding(),
    ),
    GetPage(
      name: _Paths.RUANGPUSTAKAPAGE,
      page: () => const RuangpustakapageView(),
      binding: RuangpustakapageBinding(),
    ),
    GetPage(
      name: _Paths.BOOKKATEGORIPAGE,
      page: () => const BookkategoripageView(),
      binding: BookkategoripageBinding(),
    ),
    GetPage(
      name: _Paths.BOOKBYPINJAM,
      page: () => const BookbypinjamView(),
      binding: BookbypinjamBinding(),
    ),
    GetPage(
      name: _Paths.DETAILBOOK,
      page: () => const DetailbookView(),
      binding: DetailbookBinding(),
    ),
    GetPage(
      name: _Paths.BOOKVIEWER,
      page: () => const BookviewerView(),
      binding: BookviewerBinding(),
    ),
    GetPage(
      name: _Paths.DASHBOARD,
      page: () => const DashboardView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.BOOKMARKS,
      page: () => const BookmarksView(),
      binding: BookmarksBinding(),
    ),
    GetPage(
      name: _Paths.BUKTIPEMINJAMAN,
      page: () => const BuktipeminjamanView(),
      binding: BuktipeminjamanBinding(),
    ),
    GetPage(
      name: _Paths.PAGESCANQRCODE,
      page: () => const PagescanqrcodeView(),
      binding: PagescanqrcodeBinding(),
    ),
    GetPage(
      name: _Paths.HISTORYPEMINJAMAN,
      page: () => const HistorypeminjamanView(),
      binding: HistorypeminjamanBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
  ];
}
