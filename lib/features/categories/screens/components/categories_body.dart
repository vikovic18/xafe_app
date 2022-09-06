import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:xafe/common_widgets/body_text.dart';
import 'package:xafe/common_widgets/custom_divider.dart';
import 'package:xafe/common_widgets/loader.dart';
import 'package:xafe/features/categories/controller/category_controller.dart';
import 'package:xafe/models/category.dart';
import 'package:xafe/models/emoji.dart';
import 'package:xafe/utils/colors.dart';
import 'package:xafe/utils/delete_error_alert.dart';
import 'package:xafe/utils/snackbar.dart';

class CategoriesBody extends ConsumerStatefulWidget {
  const CategoriesBody({Key? key, required this.categories}) : super(key: key);

  final Iterable<CategoryModel> categories;

  @override
  _CategoriesBodyState createState() => _CategoriesBodyState();
}

class _CategoriesBodyState extends ConsumerState<CategoriesBody> {
  bool _isLoading = false;
  void _loading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  //   List<EmojiModel> emojis = [
  //   EmojiModel(emoji: 'house', icon: Icon(Icons.house, color: Colors.blue,),),
  //   EmojiModel(emoji: 'transportation', icon: Icon(Icons.emoji_transportation, color: Colors.green)),
  //   EmojiModel(emoji: 'food', icon: Icon(Icons.restaurant, color: Colors.pink)),
  //   EmojiModel(emoji: 'medical', icon: Icon(Icons.medical_services_rounded, color: Colors.orange)),
  //   EmojiModel(emoji: 'money', icon: Icon(Icons.monetization_on_rounded, color: Colors.indigo)),
  // ];

  Icon? emojiIcon;

  // @override
  // void initState() {
  //   super.initState();
  //   for(var element in emojis){

  //   }
  // }

  void _deleteCategory(context, documentId, WidgetRef ref) async {
    final result = await showCustomDeleteDialog(context);
    
    if (result == true) {
      _loading();
      await ref
          .read(categoryControllerProvider)
          .deleteCategory(documentId)
          .then((status) => {
                if (status.isSuccess)
                  {
                    showSnackBar(
                        context: context, content: 'Deleted successfully')
                  }
              })
          .catchError((error) {
        showSnackBar(context: context, content: error.toString());
        _loading();
      });
      _loading();
    }
    // await ref
    //     .read(categoryControllerProvider)
    //     .deleteCategory(documentId)
    //     .then((status) => {
    //           if (status.isSuccess)
    //             {showSnackBar(context: context, content: 'Deleted successfully')}
    //         })
    //     .catchError((error) {
    //   showSnackBar(context: context, content: error.toString());
    // });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    List<EmojiModel> emojis = ref.watch(categoryControllerProvider).emojis;
    return Expanded(
        child: Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(size.height * 0.05),
                    topRight: Radius.circular(size.height * 0.05))),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Center(child: CustomDivider()),
              SizedBox(
                height: size.height * 0.03,
              ),
              BodyText(
                  color: AppColors.blackColor,
                  size: 16,
                  text: '${widget.categories.length} Spending Categories',
                  weight: FontWeight.w400),
              SizedBox(height: size.height * 0.03),
              Expanded(
                child: ListView.builder(
                    itemCount: widget.categories.length,
                    itemBuilder: (BuildContext context, int index) {
                      final category = widget.categories.elementAt(index);
                      for(var element in emojis){
                        if (category.emoji == element.emoji){
                          emojiIcon = element.icon;
                        }
                      }
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  emojiIcon!,
                                  const SizedBox(width: 12),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: size.height * 0.15,
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: BodyText(
                                              color: AppColors.blackColor,
                                              size: 16,
                                              text: category.name!,
                                              weight: FontWeight.w600),
                                        ),
                                      ),
                                      BodyText(
                                          color: AppColors.greyColor,
                                          size: 14,
                                          text: DateFormat('dd/MM/yy')
                                              .format(category.dateTime!),
                                          // category.dateTime!.toString(),
                                          weight: FontWeight.w400)
                                    ],
                                  )
                                ],
                              ),
                              Container(
                                width: size.height * 0.12,
                                height: size.height * 0.04,
                                decoration: BoxDecoration(
                                    color: AppColors.lightRedColor,
                                    borderRadius: BorderRadius.circular(15)),
                                child: GestureDetector(
                                    onTap: () => _deleteCategory(
                                        context, category.documentId, ref),
                                    child: !_isLoading
                                        ? const Center(
                                            child: BodyText(
                                                color: AppColors.yellowColor,
                                                size: 16,
                                                text: 'remove',
                                                weight: FontWeight.w400),
                                          )
                                        : const Loader()),
                              )
                            ],
                          ),
                          SizedBox(height: size.height * 0.05)
                        ],
                      );
                    }),
              ),
            ])));
  }
}
