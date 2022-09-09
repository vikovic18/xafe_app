import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xafe/common_widgets/body_text.dart';
import 'package:xafe/common_widgets/button.dart';
import 'package:xafe/common_widgets/loader.dart';
import 'package:xafe/common_widgets/reusable_textfield.dart';
import 'package:xafe/features/home/controller/expenses_controller.dart';
import 'package:xafe/utils/colors.dart';
import 'package:xafe/utils/snackbar.dart';

class AddIncome extends ConsumerStatefulWidget {
  const AddIncome({Key? key}) : super(key: key);

  @override
  _AddIncomeState createState() => _AddIncomeState();
}

class _AddIncomeState extends ConsumerState<AddIncome> {
  final TextEditingController incomeController = TextEditingController();

  bool _isLoading = false;
  void _loading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  String? categoryId;

  @override
  void dispose() {
    super.dispose();
    incomeController.dispose();
  }

  void _addIncome() async {
    String amount = incomeController.text.trim();
    _loading();
    await ref
        .read(expensesControllerProvider)
        .addIncome(double.parse(amount))
        .then((status) => {
              if (status.isSuccess)
                {showSnackBar(context: context, content: 'Added successfully')}
            })
        .catchError((error) {
      showSnackBar(context: context, content: error.toString());
    });
    _loading();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        body: SafeArea(
            child: !_isLoading
                ? SingleChildScrollView(
                    child: Container(
                      margin: const EdgeInsets.only(top: 20, left: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: const Icon(
                              Icons.arrow_back_ios,
                              color: AppColors.darkGreyColor,
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.06,
                          ),
                          const BodyText(
                              color: AppColors.blackColor,
                              size: 24,
                              text: 'Add your Income',
                              weight: FontWeight.w400),
                          SizedBox(
                            height: size.height * 0.04,
                          ),
                          SingleChildScrollView(
                            child: Column(children: [
                              const SizedBox(height: 10),
                              ReusableTextField(
                                controller: incomeController,
                                hintText: 'Income',
                                keyboardType: TextInputType.number,
                              ),
                              const SizedBox(height: 10),
                            ]),
                          )
                        ],
                      ),
                    ),
                  )
                : const Loader()),
        bottomNavigationBar: !_isLoading
            ? Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                child: ButtonText(onPressed: _addIncome, text: 'Add Income'))
            : const SizedBox());
  }
}
