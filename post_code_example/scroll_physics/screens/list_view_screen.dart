import 'package:flutter/material.dart';

class ListViewScreen extends StatelessWidget {
  final String title;
  final ScrollPhysics physics;
  final double? itemExtent;

  const ListViewScreen({
    super.key,
    required this.title,
    required this.physics,
    this.itemExtent,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title), backgroundColor: Colors.lightBlueAccent,),
      body: ListView.builder(
        physics: physics,
        itemExtent: itemExtent,
        itemBuilder: (context, index) {
          return _DemoTile(index: index, extent: itemExtent);
        },
        itemCount: 50,
      ),
    );
  }
}

class _DemoTile extends StatelessWidget {
  final int index;
  final double? extent;
  const _DemoTile({required this.index, this.extent});

  @override
  Widget build(BuildContext context) {
    final color = Colors.primaries[index % Colors.primaries.length].shade200;
    return Container(
      height: extent,
      color: color,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Text('Item #$index', style: Theme.of(context).textTheme.titleMedium),
    );
  }
}
