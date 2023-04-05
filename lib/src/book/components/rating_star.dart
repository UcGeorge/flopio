import 'package:flutter/material.dart';

class RatingStar extends StatelessWidget {
  final double rating;
  const RatingStar(this.rating, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 15,
      child: Row(
        children: [
          rating <= 0.5
              ? rating <= 0
                  ? const Icon(
                      Icons.star_border,
                      color: Colors.amber,
                      size: 12,
                    )
                  : const Icon(
                      Icons.star_half,
                      color: Colors.amber,
                      size: 12,
                    )
              : const Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 12,
                ),
          const SizedBox(width: 2),
          rating <= 1.5
              ? rating <= 1
                  ? const Icon(
                      Icons.star_border,
                      color: Colors.amber,
                      size: 12,
                    )
                  : const Icon(
                      Icons.star_half,
                      color: Colors.amber,
                      size: 12,
                    )
              : const Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 12,
                ),
          const SizedBox(width: 2),
          rating <= 2.5
              ? rating <= 2
                  ? const Icon(
                      Icons.star_border,
                      color: Colors.amber,
                      size: 12,
                    )
                  : const Icon(
                      Icons.star_half,
                      color: Colors.amber,
                      size: 12,
                    )
              : const Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 12,
                ),
          const SizedBox(width: 2),
          rating <= 3.5
              ? rating <= 3
                  ? const Icon(
                      Icons.star_border,
                      color: Colors.amber,
                      size: 12,
                    )
                  : const Icon(
                      Icons.star_half,
                      color: Colors.amber,
                      size: 12,
                    )
              : const Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 12,
                ),
          const SizedBox(width: 2),
          rating <= 4.5
              ? rating <= 4
                  ? const Icon(
                      Icons.star_border,
                      color: Colors.amber,
                      size: 12,
                    )
                  : const Icon(
                      Icons.star_half,
                      color: Colors.amber,
                      size: 12,
                    )
              : const Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 12,
                ),
          const SizedBox(width: 5),
          Text(
            rating.toString(),
            style: Theme.of(context).textTheme.headline2!.copyWith(
                fontSize: 11,
                color: Colors.white.withOpacity(0.8),
                letterSpacing: 1),
          )
        ],
      ),
    );
  }
}
