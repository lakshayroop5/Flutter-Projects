import 'package:flutter/material.dart';
import 'package:home_construction/provider/projects.dart';
import 'package:home_construction/widgets/home_screen/add_project.dart';
import 'package:provider/provider.dart';

import '../../models/project.dart';
import 'home_tile.dart';

class HomeTileList extends StatefulWidget {
  const HomeTileList({super.key});

  @override
  State<HomeTileList> createState() => _HomeTileListState();
}

class _HomeTileListState extends State<HomeTileList> {
  List<Project> list = [];
  bool _isLoading = false;
  bool _isInit = true;

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      try {
        Provider.of<Projects>(context).fetchProjectData().then((value) {
          Future.delayed(const Duration(seconds: 5), (() {
            setState(() {
              list = Provider.of<Projects>(context, listen: false).projects;
              _isLoading = false;
            });
          }));
        });
      } catch (error) {
        rethrow;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    print(list);
    return RefreshIndicator(
      onRefresh: () async {
        setState(() {
          list = Provider.of<Projects>(context, listen: false).projects;
        });
      },
      child: Stack(
        children: [
          _isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : list.isEmpty
                  ? Center(
                      child: Text(
                        'No Projects',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(
                          vertical: 30, horizontal: 20),
                      itemCount: list.length,
                      itemBuilder: (context, i) => HomeTile(list[i].name),
                    ),
          Positioned(
            bottom: 50,
            right: 40,
            child: SizedBox(
              height: 65,
              width: 65,
              child: FloatingActionButton(
                onPressed: () async {
                  await showModalBottomSheet(
                    context: context,
                    builder: (_) => AddProject(
                      'Add Project',
                      Project(
                        name: '',
                        albums: [],
                        contacts: [],
                        materials: [],
                        workers: [],
                      ),
                    ),
                  );
                  setState(() {
                    list =
                        Provider.of<Projects>(context, listen: false).projects;
                  });
                },
                child: const Icon(
                  Icons.add,
                  size: 35,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
