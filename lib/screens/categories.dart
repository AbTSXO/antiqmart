import 'package:flutter/material.dart';

class CategoriesList extends StatelessWidget {
  const CategoriesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 20.0),
            child: Text(
              'Categories',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(
            height: 120,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 4,
                itemBuilder: (context, index) => Row(
                  children: [
                    CategoriesCard(
                      image: 'assets/images/cate$index.png',
                      name: names[index],
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

List<String> names = ['Chair', 'Bed', 'Drawer', 'Sofa'];

class CategoriesCard extends StatelessWidget {
  const CategoriesCard({super.key, required this.image, required this.name});
  final String image;

  final String name;
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.red,
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.only(left: 18.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: const Color(0xFFe38f3e).withOpacity(0.2)),
              height: 60,
              width: 60,
              child: Image.asset(
                image,
                fit: BoxFit.cover,
                color: const Color(0xFFe38f3e),
              ),
            ),
            const SizedBox(height: 10),
            Text(name,
                style: TextStyle(fontSize: 12, color: Colors.grey.shade800)),
          ],
        ),
      ),
    );
  }
}
