import 'package:flutter/material.dart';
import 'package:home_construction/provider/projects.dart';
import 'package:home_construction/screens/menu_screen.dart';
import 'package:provider/provider.dart';

class HomeTile extends StatelessWidget {
  final String title;
  const HomeTile(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(MenuScreen.routeName, arguments: title);
      },
      child: Card(
        child: ListTile(
          title: Text(title),
          leading: CircleAvatar(
            child: Image.asset('assets/house_icon.png'),
          ),
          trailing: PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            itemBuilder: (context) => [
              // PopupMenuItem(
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //     children: const [
              //       Text('Edit'),
              //       Icon(Icons.edit),
              //     ],
              //   ),
              // ),
              PopupMenuItem(
                child: InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: ((_) => AlertDialog(
                            title: const Text('Delete!'),
                            content: const Text(
                                'Project will be permanentally deleted!'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('No'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Provider.of<Projects>(context, listen: false)
                                      .deleteProject(title);
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Yes'),
                              ),
                            ],
                          )),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      Text('Delete'),
                      Icon(Icons.delete),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
