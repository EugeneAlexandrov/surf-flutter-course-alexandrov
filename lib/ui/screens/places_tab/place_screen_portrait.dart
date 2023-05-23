import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:places/domain/store/places_store.dart';
import 'package:places/ui/components/custom_appbars.dart';
import 'package:places/ui/components/gradient_button.dart';
import 'package:places/ui/components/place_card.dart';
import 'package:provider/provider.dart';

class PortraitPlaceListScreen extends StatelessWidget {
  const PortraitPlaceListScreen({Key? key});

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
    final store = Provider.of<PlacesStore>(context);

    return Observer(
      builder: (context) {
        var places = store.getPlacesFuture?.value ?? [];
        if (store.getPlacesFuture?.status == FutureStatus.pending) {
          return const CircularProgressIndicator();
        } else {
          if (places.isEmpty) {
            return const Center(child: Text('Нет данных'));
          } else {
            return ListView.builder(
              padding: const EdgeInsets.only(top: 8),
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: PlaceCard(place: places[index]),
                );
              },
              itemCount: places.length,
            );
          }
        }
      },
    );
  }
}
