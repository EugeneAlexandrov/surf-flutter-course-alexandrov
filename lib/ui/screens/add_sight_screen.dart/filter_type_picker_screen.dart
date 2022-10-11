import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/app_strings.dart';
import 'package:places/data/mock_filters.dart';
import 'package:places/image_paths.dart';
import 'package:places/ui/screens/res/custom_color_scheme.dart';

class FilterTypePickerScreen extends StatefulWidget {
  const FilterTypePickerScreen({Key? key}) : super(key: key);

  @override
  State<FilterTypePickerScreen> createState() => _FilterTypePickerScreenState();
}

class _FilterTypePickerScreenState extends State<FilterTypePickerScreen> {
  int? _index;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.extension<CustomColors>();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          AppStrings.filterTypePickerAppbarTitle,
          style: theme.textTheme.headline6?.copyWith(color: colors!.title),
        ),
        leading: Center(
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: SvgPicture.asset(
              AssetImages.iconAppbarArrowPath,
              color: colors!.title,
              height: 32,
            ),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(mockFilters[index].title),
                    trailing: index != _index
                        ? null
                        : const Icon(
                            Icons.done,
                            color: Colors.green,
                          ),
                    onTap: () {
                      setState(() {
                        _index = index;
                      });
                    },
                  );
                },
                separatorBuilder: (context, index) => const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Divider(color: Colors.grey),
                    ),
                itemCount: mockFilters.length),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton(
                onPressed: _index == null
                    ? null
                    : () {
                        Navigator.of(context).pop(mockFilters[_index!].id);
                      },
                child: const Text(AppStrings.select)),
          ),
        ],
      ),
    );
  }
}
