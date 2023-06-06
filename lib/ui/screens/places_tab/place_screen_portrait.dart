import 'package:flutter/material.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/domain/place_interactor/place_interactor.dart';
import 'package:places/ui/components/custom_appbars.dart';
import 'package:places/ui/components/gradient_button.dart';
import 'package:places/ui/components/place_card.dart';
import 'package:provider/provider.dart';

class PortraitPlaceListScreen extends StatefulWidget {
  const PortraitPlaceListScreen({Key? key}) : super(key: key);

  @override
  State<PortraitPlaceListScreen> createState() =>
      _PortraitPlaceListScreenState();
}

class _PortraitPlaceListScreenState extends State<PortraitPlaceListScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<PlaceInteractor>(context, listen: false)
        .getPlaces()
        .listen((event) {}, onError: (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          action: SnackBarAction(
              label: 'закрыть',
              onPressed: () {
                ScaffoldMessenger.of(context).clearSnackBars();
              }),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return <Widget>[const SearchSliverAppBar()];
      },
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Stack(
          children: [
            _ListPortraitWidget(),
            Positioned.fill(
              bottom: 16,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: GradientButton(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ListPortraitWidget extends StatelessWidget {
  const _ListPortraitWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final places = Provider.of<PlaceInteractor>(context, listen: false).places;
    return StreamBuilder(
      initialData: places,
      stream: Provider.of<PlaceInteractor>(context, listen: false).getPlaces(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.cancel_outlined, size: 64),
                  const SizedBox(height: 24),
                  Text('Ошибка', style: theme.textTheme.bodyText1),
                  const SizedBox(height: 8),
                  const Text('Что то пошло не так\nПопробуйте позже.'),
                ],
                crossAxisAlignment: CrossAxisAlignment.center),
          );
        } else {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
            // return const LinearProgressIndicator();
            case ConnectionState.active:
              if ((snapshot.data as List<Place>).isEmpty) {
                return const Center(child: Text('Нет данных'));
              }
              final places = snapshot.data as List<Place>;
              return ListView.builder(
                padding: const EdgeInsets.only(top: 8),
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                itemCount: places.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: PlaceCard(place: places[index]),
                  );
                },
              );
            case ConnectionState.none:
              return const Center(child: Text('Нет данных'));
            case ConnectionState.done:
              return const Center(child: Text('232'));
          }
        }
      },
    );
  }
}
