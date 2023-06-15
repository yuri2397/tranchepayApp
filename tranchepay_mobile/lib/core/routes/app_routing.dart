import 'package:get/get.dart';
import 'package:tranchepay_mobile/app/modules/auth/login/login.binding.dart';
import 'package:tranchepay_mobile/app/modules/auth/login/login.page.dart';
import 'package:tranchepay_mobile/app/modules/auth/login/pin.page.dart';
import 'package:tranchepay_mobile/app/modules/auth/register/take_pin.page.dart';
import 'package:tranchepay_mobile/app/modules/auth/register/confirm_pin.page.dart';
import 'package:tranchepay_mobile/app/modules/auth/register/register.binding.dart';
import 'package:tranchepay_mobile/app/modules/auth/register/register.page.dart';
import 'package:tranchepay_mobile/app/modules/auth/register/take_pin_confirm.page.dart';
import 'package:tranchepay_mobile/app/modules/client/binding/client_deplafonnement.binding.dart';
import 'package:tranchepay_mobile/app/modules/client/binding/client_order_detail.binding.dart';
import 'package:tranchepay_mobile/app/modules/client/binding/client_payment_detail.binding.dart';
import 'package:tranchepay_mobile/app/modules/client/binding/client_profile.binding.dart';
import 'package:tranchepay_mobile/app/modules/client/binding/make_payment.binding.dart';
import 'package:tranchepay_mobile/app/modules/client/client.module.binding.dart';
import 'package:tranchepay_mobile/app/modules/client/client.module.dart';
import 'package:tranchepay_mobile/app/modules/client/pages/client_deplafonnement.page.dart';
import 'package:tranchepay_mobile/app/modules/client/pages/client_profile.page.dart';
import 'package:tranchepay_mobile/app/modules/client/pages/client_update_profile.page.dart';
import 'package:tranchepay_mobile/app/modules/client/pages/make_payment.page.dart';
import 'package:tranchepay_mobile/app/modules/client/widgets/client_order_detail.widget.dart';
import 'package:tranchepay_mobile/app/modules/client/widgets/client_payment_detail.widget.dart';
import 'package:tranchepay_mobile/app/modules/vendor/binding/confirm_order.binding.dart';
import 'package:tranchepay_mobile/app/modules/vendor/pages/add_client_page.dart';
import 'package:tranchepay_mobile/app/modules/vendor/pages/confirm_order.page.dart';
import 'package:tranchepay_mobile/app/modules/vendor/pages/search_client_page.dart';
import 'package:tranchepay_mobile/app/views/shared/first_time_in_app.page.dart';
import 'package:tranchepay_mobile/app/views/shared/general_info.page.dart';
import 'package:tranchepay_mobile/app/views/shared/help_center.page.dart';
import 'package:tranchepay_mobile/app/views/shared/partener/partener.binding.dart';
import 'package:tranchepay_mobile/app/views/shared/partener/partener.page.dart';
import 'package:tranchepay_mobile/app/views/shared/payment.page.dart';
import 'package:tranchepay_mobile/app/views/shared/splash_screen.view.dart';
import 'package:tranchepay_mobile/app/views/shared/update-pin-code/update_pin_code.binding.dart';
import 'package:tranchepay_mobile/app/views/shared/update-pin-code/update_pin_code.page.dart';
import 'package:tranchepay_mobile/core/routes/routes.dart';

import '../../app/modules/vendor/binding/add_boutique.binding.dart';
import '../../app/modules/vendor/binding/add_client.binding.dart';
import '../../app/modules/vendor/binding/add_order.binding.dart';
import '../../app/modules/vendor/binding/search_client.binding.dart';
import '../../app/modules/vendor/pages/add_order_page.dart';
import '../../app/modules/vendor/pages/vendor_add_shop.page.dart';
import '../../app/modules/vendor/vendor.module.dart';
import '../../app/modules/vendor/vendor_module.binding.dart';

class AppRouting {
  static const initial = AppRoutes.splashScreen;

  static final routes = [
    GetPage(name: AppRoutes.initial, page: () => const SplashScreenView()),
    GetPage(
      name: AppRoutes.firstTimeInstall,
      page: () => FirstTimeInstall(),
    ),
    GetPage(name: AppRoutes.login, page: () => const LoginPinPage()),
    GetPage(
        name: AppRoutes.loginNumber,
        page: () => const LoginPage(),
        binding: LoginBinding()),
    GetPage(
        name: AppRoutes.makePayment,
        page: () => const MakePaymentPage(),
        binding: MakePaymentBinding()),
    GetPage(
        name: AppRoutes.register,
        page: () => const RegisterPage(),
        binding: RegisterBinding()),
    GetPage(
        name: AppRoutes.clientModule,
        page: () => const ClientModule(),
        binding: ClientModuleBinding()),
    GetPage(
        name: AppRoutes.deplafonnement,
        page: () => const ClientDeplafonnementPage(),
        binding: ClientDeplafonnementBindings()),
    GetPage(
        name: AppRoutes.orderDetails,
        page: () => ClientOrderDetailWidget(),
        binding: ClientOrderDetailBinding()),
    GetPage(
        name: AppRoutes.paymentDetails,
        page: () => const ClientPaymentDetailWidget(),
        binding: ClientPaymentDetailBinding()),
    GetPage(name: AppRoutes.pinPage, page: () => const TakePinPage()),
    GetPage(
        name: AppRoutes.pinConfirmPage, page: () => const TakePinConfirmPage()),
    GetPage(
        name: AppRoutes.optVerification,
        page: () => const RegisterConfirmPinPage()),
    GetPage(name: AppRoutes.paymentPage, page: () => PaymentPage()),
    GetPage(
        name: AppRoutes.clientProfile,
        page: () => const ClientProfilePage(),
        binding: ClientProfileBinding()),
    GetPage(
        name: AppRoutes.clientUpdateProfile,
        page: () => ClientUpdateProfileProfile(),
        binding: ClientProfileBinding()),

    GetPage(
        name: AppRoutes.addShop,
        binding: AddBoutiqueBinding(),
        page: () => const VendorAddShopPage()),

    GetPage(
        name: AppRoutes.vendorModule,
        binding: VendorModuleBinding(),
        page: () => const VendorModule()),

    GetPage(
        name: AppRoutes.addOrder,
        binding: AddOrderBinding(),
        page: () => const AddOrderPage()),

    GetPage(
        name: AppRoutes.searchClient,
        binding: SearchClientBinding(),
        page: () => SearchClientPage()),

    GetPage(
        name: AppRoutes.addClient,
        binding: AddClientBinding(),
        page: () => AddClientPage()),

    GetPage(
        name: AppRoutes.confirmOrder,
        binding: ConfirmOrderBinding(),
        page: () => const ConfirmOrderPage()),

    // SHARED

    GetPage(
        name: AppRoutes.parteners,
        page: () => const PartenerPage(),
        binding: PartenerBinding()),

    GetPage(
        name: AppRoutes.updatePinCode,
        page: () => const UpdatePinCodePage(),
        binding: UpdateCodePinBindings()),
    GetPage(name: AppRoutes.newPinCode, page: () => const UpdatePinCodePage()),
    GetPage(
        name: AppRoutes.confNewPinCode, page: () => const UpdatePinCodePage()),
    GetPage(name: AppRoutes.helpCenter, page: () => const HelpCenterPage()),

    GetPage(name: AppRoutes.generalInfo, page: () => const GeneralInformation())
  ];
}
