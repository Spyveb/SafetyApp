// A custom topbar widget commonly used in the notification and search shops/user screen.
import 'package:distress_app/config/size_config.dart';
import 'package:distress_app/utils/app_colors.dart';
import 'package:distress_app/utils/app_fonts.dart';
import 'package:flutter/material.dart';

class CustomTopBar extends StatelessWidget {
  const CustomTopBar({
    Key? key,
    required this.onTabSelect,
    required this.currentIndex,
    required this.items,
    this.backgroundColor = const Color(0xff1F1F1F),
    this.padding = const EdgeInsets.all(8),
  }) : super(key: key);

  /// Called when one of the [items] is tapped.
  final ValueChanged<int> onTabSelect;

  /// Current active index of the top bar
  final int currentIndex;

  /// top bar items list
  ///
  /// provide topbar items as a List<String>
  final List<String> items;

  /// background color of the top bar. default color is light grey
  final Color backgroundColor;

  /// Padding around the top bar
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Container(
        padding: const EdgeInsets.all(0),
        height: getProportionateScreenHeight(31),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(
            getProportionateScreenWidth(25),
          ),
          border: Border.all(color: Colors.black, width: 1),
        ),
        child: Row(
          children: _buildTabTiles(),
        ),
      ),
    );
  }

  List<Widget> _buildTabTiles() {
    List<Widget> tabTiles = [];
    for (int i = 0; i < items.length; i++) {
      if (currentIndex == 0 && i == 2) {
        tabTiles.add(
          SizedBox(
            height: getProportionateScreenHeight(16),
            child: VerticalDivider(
              color: const Color(0xFF3C3C43).withOpacity(0.36),
              thickness: 1,
              width: 1,
            ),
          ),
        );
      }

      tabTiles.add(
        TopBarTile(
          title: items[i],
          isSelected: i == currentIndex,
          onTap: () {
            onTabSelect.call(i);
          },
        ),
      );

      if (currentIndex == 2 && i == 0) {
        tabTiles.add(
          SizedBox(
            height: getProportionateScreenHeight(16),
            child: VerticalDivider(
              color: const Color(0xFF3C3C43).withOpacity(0.36),
              thickness: 1,
              width: 1,
            ),
          ),
        );
      }
    }
    return tabTiles;
  }
}

class TopBarTile extends StatelessWidget {
  const TopBarTile({
    Key? key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  final String title;
  final bool isSelected;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(
              getProportionateScreenWidth(25),
            ),
          ),
          child: Text(
            title,
            style: TextStyle(
              fontSize: getProportionalFontSize(13),
              fontFamily: AppFonts.sansFont500,
              color: isSelected ? AppColors.primaryColor : AppColors.whiteColor,
            ),
          ),
        ),
      ),
    );
  }
}
