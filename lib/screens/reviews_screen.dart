import 'package:flutter/material.dart';
import 'add_review_screen.dart';

class ReviewsScreen extends StatelessWidget {
  const ReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colors.surface,
      appBar: AppBar(
        backgroundColor: colors.surface,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colors.onSurface),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Reviews",
          style: TextStyle(
            color: colors.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // ===== Reviews Summary =====
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "245 Reviews",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: colors.onSurface,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Text(
                          "4.8",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: colors.onSurface,
                          ),
                        ),
                        const SizedBox(width: 5),
                        ...List.generate(
                          4,
                          (_) => const Icon(Icons.star,
                              color: Colors.orange, size: 16),
                        ),
                        const Icon(Icons.star_half,
                            color: Colors.orange, size: 16),
                      ],
                    ),
                  ],
                ),

                // ===== Add Review Button =====
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const AddReviewScreen(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.edit, size: 18, color: Colors.white),
                  label: const Text(
                    "Add Review",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            // ===== Reviews List =====
            Expanded(
              child: ListView(
                children: const [
                  _ReviewItem(
                    name: "Jenny Wilson",
                    date: "13 Sep, 2020",
                    rating: "4.8",
                    comment:
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque malesuada eget vitae amet...",
                    image:
                        "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=100",
                  ),
                  _ReviewItem(
                    name: "Ronald Richards",
                    date: "13 Sep, 2020",
                    rating: "4.8",
                    comment:
                        "The quality is amazing! I really love how it fits on me. Definitely buying again!",
                    image:
                        "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=100",
                  ),
                  _ReviewItem(
                    name: "Guy Hawkins",
                    date: "10 Sep, 2020",
                    rating: "4.5",
                    comment:
                        "Good product, but the delivery was a bit slow.",
                    image:
                        "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ================= Review Item =================

class _ReviewItem extends StatelessWidget {
  final String name;
  final String date;
  final String rating;
  final String comment;
  final String image;

  const _ReviewItem({
    required this.name,
    required this.date,
    required this.rating,
    required this.comment,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.only(bottom: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(image),
                radius: 25,
              ),
              const SizedBox(width: 15),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: colors.onSurface,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Row(
                      children: [
                        Icon(Icons.access_time,
                            size: 14,
                            color: colors.onSurface.withOpacity(0.5)),
                        const SizedBox(width: 5),
                        Text(
                          date,
                          style: TextStyle(
                            color: colors.onSurface.withOpacity(0.5),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Text(
                        rating,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: colors.onSurface,
                        ),
                      ),
                      Text(
                        " rating",
                        style: TextStyle(
                          color: colors.onSurface.withOpacity(0.5),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const Row(
                    children: [
                      Icon(Icons.star,
                          color: Colors.orange, size: 12),
                      Icon(Icons.star,
                          color: Colors.orange, size: 12),
                      Icon(Icons.star,
                          color: Colors.orange, size: 12),
                      Icon(Icons.star,
                          color: Colors.orange, size: 12),
                      Icon(Icons.star_border,
                          color: Colors.orange, size: 12),
                    ],
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            comment,
            style: TextStyle(
              color: colors.onSurface.withOpacity(0.6),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
