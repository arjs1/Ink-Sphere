import 'package:flutter/material.dart';
import 'package:ink_sphere/core/provider/blog_provider.dart';
import 'package:provider/provider.dart';
import 'package:ink_sphere/pages/CreateBloggPage/model/blog_model.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});
  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  @override
  void initState() {
    Provider.of<BlogProvider>(context, listen: false).fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BlogProvider>(context);

    return Scaffold(
      body: StreamBuilder<List<dynamic>>(
        stream: provider.dataStream, // Listen to real-time data updates
        builder: (context, snapshot) {
          if (!snapshot.hasData || provider.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.data!.isEmpty) {
            return Center(child: Text("No data available"));
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final BlogModel item = snapshot.data![index];
              return ListTile(
                title: Text(item.title),
                subtitle: Text(item.content),
              );
            },
          );
        },
      ),
    );
  }
}
