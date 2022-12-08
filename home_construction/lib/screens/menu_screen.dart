import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:home_construction/models/album.dart';
import 'package:home_construction/models/contact.dart';
import 'package:home_construction/models/project.dart';
import 'package:home_construction/provider/projects.dart';
import 'package:home_construction/screens/contacts_screen/add_contact.dart';
import 'package:home_construction/screens/photos_screen/add_album.dart';
import 'package:home_construction/widgets/contacts_screen/contacts_list.dart';
import 'package:home_construction/widgets/material_screen/material_list.dart';
import 'package:home_construction/widgets/photos_screen/album_list.dart';
import 'package:home_construction/widgets/workers_screen/workers_list.dart';
import 'package:provider/provider.dart';

import '../models/material.dart';
import '../models/worker.dart';
import '../widgets/add_button.dart';
import 'material_screen/add_material.dart';
import 'worker_screen/add_worker.dart';

class MenuScreen extends StatefulWidget {
  static const routeName = '/menu-screen';
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> with TickerProviderStateMixin {
  late String title;
  late Project project;
  late TabController tabController = TabController(length: 4, vsync: this);

  @override
  void didChangeDependencies() {
    title = ModalRoute.of(context)!.settings.arguments as String;
    project = Provider.of<Projects>(context).findProject(title);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        bottom: TabBar(
          dragStartBehavior: DragStartBehavior.down,
          controller: tabController,
          tabs: const [
            Tab(child: FittedBox(fit: BoxFit.fitWidth, child: Text('Workers'))),
            Tab(
                child:
                    FittedBox(fit: BoxFit.fitWidth, child: Text('Materials'))),
            Tab(
                child:
                    FittedBox(fit: BoxFit.fitWidth, child: Text('Contacts'))),
            Tab(child: FittedBox(fit: BoxFit.fitWidth, child: Text('Photos'))),
            // Text('Materials'),
            // Text('Contacts'),
            // Text('Photos'),
          ],
        ),
      ),
      body: TabBarView(
        dragStartBehavior: DragStartBehavior.down,
        controller: tabController,
        children: [
          project.workers.isEmpty
              ? NoItemText(
                  'No Workers Added!',
                  title,
                  AddWorker(
                      Worker(
                        id: '',
                        name: '',
                        totalAmount: 0,
                        transactions: [],
                      ),
                      'Add Worker',
                      title),
                )
              : WorkersList(project.workers, title),
          project.materials.isEmpty
              ? NoItemText(
                  'No Materials Added!',
                  title,
                  AddMaterial(
                      MaterialItem(
                        id: '',
                        name: '',
                        unit: '',
                        quantity: 0,
                        total: 0,
                        records: [],
                      ),
                      'Add Material',
                      title),
                )
              : MaterialList(project.materials, title),
          project.contacts.isEmpty
              ? NoItemText(
                  'No Contacts Added!',
                  title,
                  AddContact(Contact(id: '', name: '', number: ''),
                      'Add Contact', title),
                )
              : ContactsList(project.contacts, title),
          project.albums.isEmpty
              ? NoItemText(
                  'No Albums Added!',
                  title,
                  AddAlbum(
                      Album(id: '', name: '', photos: []), 'Add Album', title),
                )
              : AlbumList(title, project.albums)
        ],
      ),
    );
  }
}

class NoItemText extends StatelessWidget {
  final String text;
  final String project;
  final Widget widget;
  const NoItemText(this.text, this.project, this.widget, {super.key});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Text(
            text,
            style: const TextStyle(fontSize: 20),
          ),
        ),
        AddButton(
          widget,
          project,
        ),
      ],
    );
  }
}
