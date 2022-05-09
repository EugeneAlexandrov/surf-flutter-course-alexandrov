import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/colors.dart';
import 'package:places/image_paths.dart';
import 'package:places/ui/components/custom_text_field.dart';
import 'package:places/ui/screens/res/themes.dart';

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
  final titleControler = TextEditingController();
  final latitudeControler = TextEditingController();
  final longitudeControler = TextEditingController();
  final descriptionControler = TextEditingController();

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
          'Новое место',
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
            'Отмена',
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
              title: 'КАТЕГОРИИ',
              child: ListTile(
                contentPadding: const EdgeInsets.all(0),
                onTap: () {},
                title: const Text('Не выбрано'),
                trailing: SvgPicture.asset(AssetImages.iconRihgtArrowPath),
              ),
            ),
            const Divider(),
            MyInputField(
              title: 'НАЗВАНИЕ',
              child: TextField(
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
                    title: 'ШИРОТА',
                    child: TextField(
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
                    title: 'ДОЛГОТА',
                    child: TextField(
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
              child: const Text('Указать на карте'),
            ),
            Expanded(
              child: MyInputField(
                title: 'ОПИСАНИЕ',
                child: Expanded(
                  child: TextField(
                    textAlign: TextAlign.justify,
                    focusNode: descriptionFocus,
                    maxLines: null,
                    expands: true,
                    textInputAction: TextInputAction.done,
                    decoration: decoration.copyWith(),
                  ),
                ),
              ),
            ),
            SizedBox(height: 28),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('СОЗДАТЬ'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
