import 'package:LekkiGardens/base/base_view_model.dart';
import 'package:LekkiGardens/common/view/dialog_view_utils.dart';
import 'package:LekkiGardens/features/auth/account_recovery/adapter/password_reset_confirmation.dart';
import 'package:LekkiGardens/utils/enum_data_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class AccountRecoveryViewModel extends BaseViewModel {
  Rx<AccountRecoveryState> account_recovery_state = AccountRecoveryState.EMAIL.obs;

  void nextState(AccountRecoveryState nextState) {
    account_recovery_state.value = nextState;
  }

  void showConfirmation(BuildContext context) {
    DialogViewUtils.CustomModalDialog(context: context, alignment: Alignment.center, showDecoration: false, child: PasswordResetConfirmation());
  }
}
