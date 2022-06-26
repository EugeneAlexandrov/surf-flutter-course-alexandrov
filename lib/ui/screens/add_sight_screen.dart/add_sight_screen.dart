import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/app_router.dart';
import 'package:places/app_strings.dart';
import 'package:places/colors.dart';
import 'package:places/domain/model/sight.dart';
import 'package:places/domain/repository/filter_repository.dart';
import 'package:places/domain/repository/sight_repository.dart';
import 'package:places/image_paths.dart';
import 'package:places/ui/components/custom_text_field.dart';
import 'package:places/ui/screens/res/themes.dart';
import 'package:provider/provider.dart';

class NewSightScreen extends StatefulWidget {
  const NewSightScreen({Key? key}) : super(key: key);

  @override
  State<NewSightScreen> createState() => _NewSightScreenState();
}

class _NewSightScreenState extends State<NewSightScreen> {
  // FocusNodes
  final titleFocus = FocusNode();
  // широта
  final latitudeFocus = FocusNode();
  // долгота
  final longitudeFocus = FocusNode();
  final descriptionFocus = FocusNode();

  //Controllers
  final titleController = TextEditingController();
  final latitudeController = TextEditingController();
  final longitudeController = TextEditingController();
  final descriptionController = TextEditingController();

  int? filterId;

  final decoration = InputDecoration(
    // suffixIcon: IconButton(
    //   color: AppColors.lmGreen,
    //   icon: const Icon(
    //     Icons.cancel,
    //   ),
    //   onPressed: () {
    //     print('suffix tap');
    //   },
    // ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: AppColors.lmGreen, width: 1),
      borderRadius: BorderRadius.circular(8),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: AppColors.lmGreen, width: 2),
      borderRadius: BorderRadius.circular(8),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leadingWidth: 80,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          AppStrings.addSightAppbarTitle,
          style: Theme.of(context)
              .textTheme
              .headline6
              ?.copyWith(color: Theme.of(context).colorScheme.lmMainDmWhite),
        ),
        centerTitle: true,
        leading: TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            AppStrings.cancel,
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                color: Theme.of(context).colorScheme.smallSecondaryTwo),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 8),
              height: 72,
              alignment: Alignment.center,
              color: Colors.amber,
              child: const Text('Galary'),
            ),
            MyInputField(
              title: AppStrings.addSightCategories,
              child: ListTile(
                contentPadding: const EdgeInsets.all(0),
                onTap: () {
                  _navigateAndPickFIlterType(context);
                },
                title: Text(filterId == null
                    ? AppStrings.addSightNoFiltersSelect
                    : Provider.of<FilterRepository>(context)
                        .getFilterById(filterId!)
                        .title),
                trailing: SvgPicture.asset(AssetImages.iconRihgtArrowPath),
              ),
            ),
            const Divider(),
            MyInputField(
              title: AppStrings.addSightSightTitle,
              child: TextField(
                controller: titleController,
                textAlign: TextAlign.start,
                focusNode: titleFocus,
                onSubmitted: (String value) {
                  FocusScope.of(context).requestFocus(latitudeFocus);
                },
                textInputAction: TextInputAction.next,
                style: Theme.of(context).textTheme.bodyText1,
                decoration: decoration,
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: MyInputField(
                    title: AppStrings.addSightLatitude,
                    child: TextField(
                      controller: latitudeController,
                      focusNode: latitudeFocus,
                      onSubmitted: (String value) {
                        FocusScope.of(context).requestFocus(longitudeFocus);
                      },
                      keyboardType: const TextInputType.numberWithOptions(),
                      textInputAction: TextInputAction.next,
                      decoration: decoration,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: MyInputField(
                    title: AppStrings.addSightLongitude,
                    child: TextField(
                      controller: longitudeController,
                      focusNode: longitudeFocus,
                      onSubmitted: (String value) {
                        FocusScope.of(context).requestFocus(descriptionFocus);
                      },
                      keyboardType: const TextInputType.numberWithOptions(),
                      textInputAction: TextInputAction.next,
                      decoration: decoration,
                    ),
                  ),
                ),
              ],
            ),
            TextButton(
              onPressed: () {},
              child: const Text(AppStrings.addSightShowOnMap),
            ),
            Expanded(
              child: MyInputField(
                title: AppStrings.addSightDescription,
                child: Expanded(
                  child: TextField(
                    textAlign: TextAlign.justify,
                    controller: descriptionController,
                    focusNode: descriptionFocus,
                    maxLines: null,
                    expands: true,
                    textInputAction: TextInputAction.done,
                    decoration: decoration.copyWith(),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 28),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: (titleController.text.isEmpty ||
                        longitudeController.text.isEmpty ||
                        latitudeController.text.isEmpty ||
                        descriptionController.text.isEmpty ||
                        filterId == null)
                    ? null
                    : () {
                        addSight(context);
                      },
                child: const Text(AppStrings.addSightCreate),
              ),
            )
          ],
        ),
      ),
    );
  }

  void addSight(BuildContext context) {
    Sight newSight = Sight(
        name: titleController.text,
        lon: double.parse(longitudeController.text),
        lat: double.parse(latitudeController.text),
        details: descriptionController.text,
        filterId: filterId!);
    Provider.of<SightRepository>(context, listen: false).addSight(newSight);
    Navigator.pop(context);
  }

  void _navigateAndPickFIlterType(BuildContext context) async {
    final int? result =
        await Navigator.of(context).pushNamed(AppRouter.chooseFilter) as int?;
    setState(() {
      filterId = result;
    });
  }
}
