import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/app_router.dart';
import 'package:places/app_strings.dart';
import 'package:places/ui/screens/res/colors.dart';
import 'package:places/domain/model/place_image.dart';
import 'package:places/domain/model/sight.dart';
import 'package:places/domain/repository/filter_repository.dart';
import 'package:places/domain/repository/sight_repository.dart';
import 'package:places/image_paths.dart';
import 'package:places/ui/components/custom_text_field.dart';
import 'package:places/ui/screens/res/custom_color_scheme.dart';
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
  // local model for images persist
  final ImageListModel _model = ImageListModel();

  final decoration = InputDecoration(
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
    final theme = Theme.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leadingWidth: 80,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          AppStrings.addSightAppbarTitle,
          style: theme.textTheme.headline6
              ?.copyWith(color: theme.extension<CustomColors>()!.title),
        ),
        centerTitle: true,
        leading: TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            AppStrings.cancel,
            style: theme.textTheme.bodyText1?.copyWith(
                color: theme.extension<CustomColors>()!.smallSecondaryTwo),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        // решил поэкспериментировать с инхеритами
        child: ImageListProvider(
          model: _model,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gallary(),
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
                  style: theme.textTheme.bodyText1,
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
                  style: TextButton.styleFrom(padding: EdgeInsets.zero)),
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
      ),
    );
  }

  void addSight(BuildContext context) {
    Sight newSight = Sight(
        name: titleController.text,
        lon: double.parse(longitudeController.text),
        lat: double.parse(latitudeController.text),
        details: descriptionController.text,
        filterId: filterId!,
        images: ImageListProvider.read(context)?.imageList ?? <PlaceImage>[]);
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

class Gallary extends StatelessWidget {
  const Gallary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = ImageListProvider.watch(context);
    return SizedBox(
      height: 72,
      child: ListView.separated(
        physics: Platform.isAndroid
            ? const ClampingScrollPhysics()
            : const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        //смещение индексов для первого жлемента списка
        itemCount: model == null ? 1 : model.imageList.length + 1,
        itemBuilder: ((context, index) {
          return index == 0
              ? InkWell(
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  onTap: () {
                    model?.addImage();
                  },
                  splashColor: AppColors.dmInnactiveBlack,
                  child: Container(
                    width: 72,
                    child: const Icon(
                      Icons.add_rounded,
                      size: 48,
                      color: Colors.green,
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.green, width: 2)),
                  ),
                )
              : ImageTile(index - 1);
        }),
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(
            width: 16,
          );
        },
      ),
    );
  }
}

// модель для InheritedNotifier
class ImageListModel extends ChangeNotifier {
  final List<PlaceImage> _imageList = [];

  get imageList => List.castFrom(_imageList);

  void addImage() {
    imageList.add(
      PlaceImage(
        url: AssetImages.mockImageDetail1,
        color: imageList.length,
      ),
    );
    notifyListeners();
  }

  void deleteImage(int index) {
    imageList.removeAt(index);
    notifyListeners();
  }
}

//сам инхерит
class ImageListProvider extends InheritedNotifier<ImageListModel> {
  final ImageListModel model;

  const ImageListProvider(
      {required this.model, required Widget child, Key? key})
      : super(key: key, notifier: model, child: child);

  //подписка
  static ImageListModel? watch(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<ImageListProvider>()
        ?.model;
  }

  //чтение
  static ImageListModel? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<ImageListProvider>()
        ?.widget;
    return widget is ImageListProvider ? widget.notifier : null;
  }
}

//Заглушка для изображений
class ImageTile extends StatelessWidget {
  const ImageTile(this.index, {Key? key}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    final int color =
        ImageListProvider.read(context)?.imageList[index].color ?? 10;
    return Dismissible(
      direction: DismissDirection.up,
      key: UniqueKey(),
      onDismissed: (direction) {
        ImageListProvider.read(context)?.deleteImage(index);
      },
      child: Stack(
        children: [
          Container(
            height: 72,
            width: 72,
            decoration: BoxDecoration(
              color: Color.fromRGBO(
                  color * 128 % 256, 255 - color * 10, color * 15, 1),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          Positioned(
              top: 6,
              right: 6,
              child: GestureDetector(
                onTap: () {
                  ImageListProvider.read(context)?.deleteImage(index);
                },
                child: const Icon(
                  Icons.cancel,
                  color: Colors.white,
                  size: 20,
                ),
              ))
        ],
      ),
    );
  }
}
