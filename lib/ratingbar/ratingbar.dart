import 'package:flutter/material.dart';

class Ratingbar extends StatefulWidget {
  final int ratingCount;
  final IconData selectedIcon;
  final IconData unSelectedIcon;
  final Color? selectedIconColor;
  final Color? unSelectedIconColor;
  final Curve iconAnimation;
  final bool horizontalRatingbar;

  const Ratingbar({
    super.key,
    this.ratingCount = 5,
    this.selectedIcon = Icons.star,
    this.unSelectedIcon = Icons.star_border,
    this.horizontalRatingbar = true,
    this.selectedIconColor,
    this.unSelectedIconColor,
    this.iconAnimation=Curves.elasticInOut,
  });

  @override
  State<Ratingbar> createState() => _RatingbarState();
}

class _RatingbarState extends State<Ratingbar> {
  int selectedIndex = 0;
  final double starSize = 40;
  void _updateRating(Offset localPosition) {
    int rating = (localPosition.dx ~/ starSize) + 1;
    if (rating < 0) rating = 0;
    if (rating > widget.ratingCount) rating = widget.ratingCount;

    setState(() {
      selectedIndex = rating;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: widget.horizontalRatingbar ? Axis.horizontal : Axis.vertical,
      itemBuilder: (context, index) {
        return GestureDetector(
              onPanUpdate: (details){
                _updateRating(details.localPosition);
              },
              onPanDown: (details){
                _updateRating(details.localPosition);
              },
              child: IconButton(
                onPressed: () {
                  setState(() {
                    selectedIndex = index + 1;
                  });
                },
                icon: AnimatedScale(
                  scale: index < selectedIndex ? 1.5 : 1.0,
                  curve: widget.iconAnimation,
                  duration: Duration(seconds: 2),
                  child: Icon(
                    index < selectedIndex ? widget.selectedIcon : widget.unSelectedIcon,
                    color: index < selectedIndex ? widget.selectedIconColor : widget.unSelectedIconColor,
                  ),
                ),
              ),
        );
      },
      separatorBuilder: (context, index) => SizedBox(width: 10),
      itemCount: widget.ratingCount,
    );
  }
}