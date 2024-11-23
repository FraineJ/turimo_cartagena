import 'package:flutter/material.dart';

class ReviewCard extends StatelessWidget {
  final String userName;
  final String userRole;
  final String reviewText;
  final String userImageUrl;
  final double rating;

  const ReviewCard({
    Key? key,
    required this.userName,
    required this.userRole,
    required this.reviewText,
    required this.userImageUrl,
    required this.rating,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        border: Border.all(
          color: Colors.grey.withOpacity(0.2), // Borde sutil y suave
          width: 1.0, // Grosor del borde
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1), // Sombra suave
            blurRadius: 8, // Radio de difuminado de la sombra
            offset: Offset(0, 4), // Dirección de la sombra
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // User image
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Colors.grey.withOpacity(0.2), // Borde sutil y suave
                      width: 1.0, // Grosor del borde
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1), // Sombra suave
                        blurRadius: 8, // Radio de difuminado de la sombra
                        offset: Offset(0, 4), // Dirección de la sombra
                      ),
                    ],
                    image:  DecorationImage(
                      image: NetworkImage(userImageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                const SizedBox(width: 16),
                // Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Name and role
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                userName,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                userRole,
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          // Rating
                          Container(
                            padding: EdgeInsets.all(4.0),
                            decoration: BoxDecoration(
                                color: Colors.amber[200],
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 18,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  rating.toString(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            // Review text
            Text(
              reviewText,
              style: TextStyle(
                color: Colors.grey[800],
                fontSize: 14,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
