import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:home_construction/models/album.dart';
import 'package:home_construction/models/contact.dart';
import 'package:home_construction/models/material.dart';
import 'package:home_construction/models/worker.dart';

import '../models/project.dart';

class Projects with ChangeNotifier {
  List<Project> _projects = [
    // Project(
    //   name: 'project1',
    //   albums: [
    //     Album(
    //       id: DateTime.now().toString(),
    //       name: 'map',
    //       photos: [
    //         Photo(
    //           image: Image.asset(
    //             'assets/site_image.jpg',
    //             fit: BoxFit.cover,
    //           ),
    //           date: DateTime.now(),
    //         ),
    //         Photo(
    //           image: Image.asset('assets/site_image.jpg'),
    //           date: DateTime.now(),
    //         ),
    //         Photo(
    //           image: Image.asset('assets/site_image.jpg'),
    //           date: DateTime.now(),
    //         ),
    //         Photo(
    //           image: Image.asset('assets/site_image.jpg'),
    //           date: DateTime.now(),
    //         ),
    //       ],
    //     ),
    //     Album(
    //       id: DateTime.now().toString(),
    //       name: 'map1',
    //       photos: [
    //         // Photo(
    //         //   image: Image.asset('assets/site_image.jpg'),
    //         //   date: DateTime.now(),
    //         // ),
    //         // Photo(
    //         //   image: Image.asset('assets/site_image.jpg'),
    //         //   date: DateTime.now(),
    //         // ),
    //         // Photo(
    //         //   image: Image.asset('assets/site_image.jpg'),
    //         //   date: DateTime.now(),
    //         // ),
    //         // Photo(
    //         //   image: Image.asset('assets/site_image.jpg'),
    //         //   date: DateTime.now(),
    //         // ),
    //       ],
    //     ),
    //   ],
    //   contacts: [
    //     Contact(
    //       id: DateTime.now().toString(),
    //       name: 'Lakshay',
    //       number: '9636534941',
    //     ),
    //     Contact(
    //       id: DateTime.now().toString(),
    //       name: 'Lakshay',
    //       number: '9636534941',
    //     ),
    //   ],
    //   materials: [
    //     MaterialItem(
    //       id: DateTime.now().toString(),
    //       name: 'Cement',
    //       unit: 'in bags',
    //       quantity: 0,
    //       total: 0,
    //       records: [],
    //     ),
    //   ],
    //   workers: [
    //     Worker(
    //       id: DateTime.now().toString(),
    //       name: 'Laven',
    //       totalAmount: 100,
    //       transactions: [],
    //     ),
    //   ],
    // )
  ];

  // Project List
  List<Project> get projects {
    return [..._projects];
  }

  //Project Functions
  Future<void> fetchProjectData() async {
    final url = Uri.parse(
        "https://home-construction-8f2e1-default-rtdb.firebaseio.com/projects.json");
    try {
      final response = await http.get(url);
      if (json.decode(response.body) == null) {
        _projects = [];
        return;
      }
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      print(extractedData);
      final List<Project> loadedProjects = [];

      try {
        extractedData.forEach((projectId, projectData) async {
          loadedProjects.add(Project(
            name: projectId,
            albums: await fetchAlbums(projectId),
            contacts: await fetchContacts(projectId),
            materials: await fetchMaterials(projectId),
            workers: await fetchWorkers(projectId),
          ));
        });

        _projects = loadedProjects;
        notifyListeners();
      } catch (error) {
        rethrow;
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<void> addProject(String name) async {
    if (checkNamePresent(name)) {
      throw Exception('Name already present');
    }
    final url = Uri.parse(
        "https://home-construction-8f2e1-default-rtdb.firebaseio.com/projects/$name.json");

    try {
      await http.post(
        url,
        body: json.encode(
          {
            'name': name,
          },
        ),
      );
    } catch (error) {
      rethrow;
    }
    Project newProject = Project(
      name: name,
      albums: [],
      contacts: [],
      materials: [],
      workers: [],
    );
    _projects.add(newProject);
    notifyListeners();
  }

  Future<void> deleteProject(String name) async {
    final url = Uri.parse(
        "https://home-construction-8f2e1-default-rtdb.firebaseio.com/projects/$name.json");
    await http.delete(url);
    _projects.removeWhere((element) => element.name == name);
    notifyListeners();
  }

  bool checkNamePresent(String name) {
    if (_projects.any((element) => element.name == name)) {
      return true;
    }
    return false;
  }

  Project findProject(String name) {
    return _projects.firstWhere((element) => element.name == name);
  }

  //Worker Functions
  Future<List<Worker>> fetchWorkers(String project) async {
    final url =
        'https://home-construction-8f2e1-default-rtdb.firebaseio.com/projects/$project/workers.json';
    try {
      final response = await http.get(Uri.parse(url));
      if (json.decode(response.body) == null) {
        return [];
      }
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      print(json.decode(response.body));
      final List<Worker> loadedWorkers = [];
      extractedData.forEach((workerId, workerData) async {
        loadedWorkers.add(Worker(
          id: workerId,
          name: workerData['name'],
          totalAmount: workerData['totalAmount'],
          transactions: await fetchTransactions(project, workerId),
        ));
      });
      return loadedWorkers;
    } catch (error) {
      rethrow;
    }
  }

  Future<void> addWorker(Worker worker, String project) async {
    final url = Uri.parse(
        "https://home-construction-8f2e1-default-rtdb.firebaseio.com/projects/$project/workers.json");
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            // 'id': worker.id,
            'name': worker.name,
            'totalAmount': worker.totalAmount,
          },
        ),
      );
      print(json.decode(response.body));
      Worker tempWorker = Worker(
          id: json.decode(response.body)['name'],
          name: worker.name,
          totalAmount: worker.totalAmount,
          transactions: worker.transactions);
      findProject(project).workers.add(tempWorker);
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> editWorker(Worker worker, String project) async {
    print(worker);
    final url = Uri.parse(
        "https://home-construction-8f2e1-default-rtdb.firebaseio.com/projects/$project/workers/${worker.id}.json");
    try {
      await http.patch(
        url,
        body: json.encode(
          {
            'name': worker.name,
          },
        ),
      );
    } catch (error) {
      rethrow;
    }
    findProject(project)
        .workers
        .removeWhere((element) => element.id == worker.id);
    findProject(project).workers.add(worker);
    notifyListeners();
  }

  Future<void> deleteWorker(Worker worker, String project) async {
    final url = Uri.parse(
        "https://home-construction-8f2e1-default-rtdb.firebaseio.com/projects/$project/workers/${worker.id}.json");
    await http.delete(url);
    findProject(project)
        .workers
        .removeWhere((element) => element.id == worker.id);
    notifyListeners();
  }

  Future<List<Transaction>> fetchTransactions(
      String project, String workerId) async {
    final url =
        'https://home-construction-8f2e1-default-rtdb.firebaseio.com/projects/$project/workers/$workerId/transactions.json';
    try {
      final response = await http.get(Uri.parse(url));
      if (json.decode(response.body) == null) {
        return [];
      }
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Transaction> loadedTransactions = [];
      extractedData.forEach((transactionId, transactionData) {
        loadedTransactions.add(Transaction(
          id: transactionId,
          date: DateTime.parse(transactionData['date']),
          amount: transactionData['amount'],
          description: transactionData['description'],
        ));
      });
      return loadedTransactions;
    } catch (error) {
      rethrow;
    }
  }

  Future<void> addTransaction(
      Transaction transaction, String workerId, String project) async {
    var key;
    var url = Uri.parse(
        "https://home-construction-8f2e1-default-rtdb.firebaseio.com/projects/$project/workers/$workerId/transactions.json");
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'amount': transaction.amount,
            'date': transaction.date.toIso8601String(),
            'description': transaction.description,
          },
        ),
      );
      key = json.decode(response.body)['name'];
    } catch (error) {
      rethrow;
    }
    var tempUrl = Uri.parse(
        "https://home-construction-8f2e1-default-rtdb.firebaseio.com/projects/$project/workers/$workerId.json");
    final response = await http.get(tempUrl);
    final currentTotal = json.decode(response.body)['totalAmount'];
    try {
      await http.patch(
        tempUrl,
        body: json.encode(
          {
            'totalAmount': currentTotal + transaction.amount,
          },
        ),
      );
    } catch (error) {
      rethrow;
    }
    Transaction tempTransaction = Transaction(
      amount: transaction.amount,
      date: transaction.date,
      description: transaction.description,
      id: key,
    );
    findProject(project)
        .workers
        .firstWhere((element) => element.id == workerId)
        .transactions
        .insert(0, tempTransaction);
    findProject(project)
        .workers
        .firstWhere((element) => element.id == workerId)
        .totalAmount += tempTransaction.amount;
    notifyListeners();
  }

  Future<void> editTransaction(
      Transaction transaction, String workerId, String project) async {
    var url = Uri.parse(
        "https://home-construction-8f2e1-default-rtdb.firebaseio.com/projects/$project/workers/$workerId.json");

    final response = await http.get(url);
    print(json.decode(response.body));
    final currentTotal = json.decode(response.body)['totalAmount'];
    try {
      await http.patch(
        url,
        body: json.encode(
          {
            'totalAmount': currentTotal -
                findProject(project)
                    .workers
                    .firstWhere((element) => element.id == workerId)
                    .transactions
                    .firstWhere((element) => element.id == transaction.id)
                    .amount +
                transaction.amount,
          },
        ),
      );
    } catch (error) {
      rethrow;
    }
    url = Uri.parse(
        "https://home-construction-8f2e1-default-rtdb.firebaseio.com/projects/$project/workers/$workerId/transactions/${transaction.id}.json");
    try {
      await http.patch(
        url,
        body: json.encode(
          {
            'id': transaction.id,
            'amount': transaction.amount,
            'date': transaction.date.toIso8601String(),
            'description': transaction.description,
          },
        ),
      );
    } catch (error) {
      rethrow;
    }
    Transaction temp = findProject(project)
        .workers
        .firstWhere((element) => element.id == workerId)
        .transactions
        .firstWhere((element) => element.id == transaction.id);

    findProject(project)
        .workers
        .firstWhere((element) => element.id == workerId)
        .totalAmount -= temp.amount;

    findProject(project)
        .workers
        .firstWhere((element) => element.id == workerId)
        .transactions
        .removeWhere((element) => element.id == temp.id);
    findProject(project)
        .workers
        .firstWhere((element) => element.id == workerId)
        .transactions
        .insert(0, transaction);

    findProject(project)
        .workers
        .firstWhere((element) => element.id == workerId)
        .totalAmount += transaction.amount;
    notifyListeners();
  }

  Future<void> deleteTransaction(
      Transaction transaction, String workerId, String project) async {
    var url = Uri.parse(
        "https://home-construction-8f2e1-default-rtdb.firebaseio.com/projects/$project/workers/$workerId.json");
    var response = await http.get(url);
    var currentTotal = json.decode(response.body)['totalAmount'];
    try {
      await http.patch(
        url,
        body: json.encode(
          {
            'totalAmount': currentTotal - transaction.amount,
          },
        ),
      );
    } catch (error) {
      rethrow;
    }
    url = Uri.parse(
        "https://home-construction-8f2e1-default-rtdb.firebaseio.com/projects/$project/workers/$workerId/transactions/${transaction.id}.json");

    await http.delete(url);
    Worker tempWorker = findProject(project)
        .workers
        .firstWhere((element) => element.id == workerId);

    tempWorker.totalAmount -= transaction.amount;
    tempWorker.transactions
        .removeWhere((element) => element.id == transaction.id);

    notifyListeners();
  }

  //Material Functions
  Future<List<MaterialItem>> fetchMaterials(String project) async {
    print(1);
    var url = Uri.parse(
        "https://home-construction-8f2e1-default-rtdb.firebaseio.com/projects/$project/materials.json");
    try {
      final response = await http.get(url);
      if (json.decode(response.body) == null) {
        return [];
      }
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData.isEmpty) {
        return [];
      }
      final List<MaterialItem> loadedMaterials = [];
      extractedData.forEach((materialId, materialData) async {
        loadedMaterials.add(MaterialItem(
            id: materialId,
            name: materialData['name'],
            quantity: materialData['quantity'],
            unit: materialData['unit'],
            total: materialData['total'],
            records: await fetchRecords(project, materialId)));
      });
      return loadedMaterials;
    } catch (error) {
      rethrow;
    }
  }

  Future<void> addMaterial(MaterialItem material, String project) async {
    dynamic key;
    var url = Uri.parse(
        "https://home-construction-8f2e1-default-rtdb.firebaseio.com/projects/$project/materials.json");
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'name': material.name,
            'unit': material.unit,
            'quantity': material.quantity,
            'total': material.total,
          },
        ),
      );
      key = json.decode(response.body)['name'];
    } catch (error) {
      rethrow;
    }
    MaterialItem temp = MaterialItem(
      id: key,
      name: material.name,
      quantity: material.quantity,
      total: material.total,
      unit: material.unit,
      records: material.records,
    );
    findProject(project).materials.add(temp);
    notifyListeners();
  }

  Future<void> editMaterial(MaterialItem material, String project) async {
    var url = Uri.parse(
        "https://home-construction-8f2e1-default-rtdb.firebaseio.com/projects/$project/materials/${material.id}.json");
    try {
      await http.patch(
        url,
        body: json.encode(
          {
            'name': material.name,
            'unit': material.unit,
            'quantity': material.quantity,
            'total': material.total,
          },
        ),
      );
    } catch (error) {
      rethrow;
    }
    findProject(project)
        .materials
        .removeWhere((element) => element.id == material.id);
    findProject(project).materials.add(material);
    notifyListeners();
  }

  Future<void> deleteMaterial(MaterialItem material, String project) async {
    var url = Uri.parse(
        "https://home-construction-8f2e1-default-rtdb.firebaseio.com/projects/$project/materials/${material.id}.json");
    await http.delete(url);
    findProject(project)
        .materials
        .removeWhere((element) => element.id == material.id);
    notifyListeners();
  }

  Future<List<Record>> fetchRecords(String project, String materialId) async {
    var url = Uri.parse(
        "https://home-construction-8f2e1-default-rtdb.firebaseio.com/projects/$project/materials/$materialId/records.json");
    try {
      final response = await http.get(url);
      if (json.decode(response.body) == null) {
        return [];
      }
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData.isEmpty) {
        return [];
      }
      final List<Record> loadedRecords = [];
      extractedData.forEach((recordId, recordData) {
        loadedRecords.add(Record(
          id: recordId,
          date: DateTime.parse(recordData['date']),
          quantity: recordData['quantity'],
          pricePerUnit: recordData['pricePerUnit'],
        ));
      });
      return loadedRecords;
    } catch (error) {
      rethrow;
    }
  }

  Future<void> addRecord(
      Record record, String materialId, String project) async {
    dynamic key;
    var url = Uri.parse(
        "https://home-construction-8f2e1-default-rtdb.firebaseio.com/projects/$project/materials/$materialId.json");
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final currentQuantity = extractedData['quantity'];
      final currentTotal = extractedData['total'];
      await http.patch(
        url,
        body: json.encode(
          {
            'quantity': currentQuantity + record.quantity,
            'total': currentTotal + record.quantity * record.pricePerUnit,
          },
        ),
      );
    } catch (error) {
      rethrow;
    }
    url = Uri.parse(
        "https://home-construction-8f2e1-default-rtdb.firebaseio.com/projects/$project/materials/$materialId/records.json");
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'date': record.date.toIso8601String(),
            'quantity': record.quantity,
            'pricePerUnit': record.pricePerUnit,
          },
        ),
      );
      key = json.decode(response.body)['name'];
    } catch (error) {
      rethrow;
    }
    Record temp = Record(
      id: key,
      date: record.date,
      quantity: record.quantity,
      pricePerUnit: record.pricePerUnit,
    );
    MaterialItem tempMaterial = findProject(project)
        .materials
        .firstWhere((element) => element.id == materialId);
    tempMaterial.records.insert(0, temp);
    tempMaterial.quantity += record.quantity;
    tempMaterial.total += (record.quantity * record.pricePerUnit);
    notifyListeners();
  }

  Future<void> editRecord(
      Record record, String materialId, String project) async {
    Record tempRecord = findProject(project)
        .materials
        .firstWhere((element) => element.id == materialId)
        .records
        .firstWhere((element) => element.id == record.id);

    MaterialItem tempMaterial = findProject(project)
        .materials
        .firstWhere((element) => element.id == materialId);

    tempMaterial.quantity -= tempRecord.quantity;
    tempMaterial.total -= (tempRecord.quantity * tempRecord.pricePerUnit);
    var url = Uri.parse(
        "https://home-construction-8f2e1-default-rtdb.firebaseio.com/projects/$project/materials/$materialId.json");
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final currentQuantity = extractedData['quantity'];
      final currentTotal = extractedData['total'];
      await http.patch(
        url,
        body: json.encode(
          {
            'quantity': currentQuantity - tempRecord.quantity + record.quantity,
            'total': currentTotal -
                (tempRecord.quantity * tempRecord.pricePerUnit) +
                (record.quantity * record.pricePerUnit),
          },
        ),
      );
    } catch (error) {
      rethrow;
    }
    url = Uri.parse(
        "https://home-construction-8f2e1-default-rtdb.firebaseio.com/projects/$project/materials/$materialId/records/${record.id}.json");
    try {
      await http.patch(
        url,
        body: json.encode(
          {
            'date': record.date.toIso8601String(),
            'quantity': record.quantity,
            'pricePerUnit': record.pricePerUnit,
          },
        ),
      );
    } catch (error) {
      rethrow;
    }

    tempMaterial.records.removeWhere((element) => element.id == tempRecord.id);
    tempMaterial.records.insert(0, record);

    tempMaterial.quantity += record.quantity;
    tempMaterial.total += (record.quantity * record.pricePerUnit);
    notifyListeners();
  }

  Future<void> deleteRecord(
      Record record, String materialId, String project) async {
    var url = Uri.parse(
        "https://home-construction-8f2e1-default-rtdb.firebaseio.com/projects/$project/materials/$materialId.json");
    final response = await http.get(url);
    final total = json.decode(response.body)['total'];
    final quantity = json.decode(response.body)['quantity'];
    await http.patch(url,
        body: json.encode({
          'total': total - (record.quantity * record.pricePerUnit),
          'quantity': quantity - record.quantity,
        }));
    url = Uri.parse(
        "https://home-construction-8f2e1-default-rtdb.firebaseio.com/projects/$project/materials/$materialId/records/${record.id}.json");
    await http.delete(url);
    MaterialItem tempMaterial = findProject(project)
        .materials
        .firstWhere((element) => element.id == materialId);

    tempMaterial.quantity -= record.quantity;
    tempMaterial.total -= (record.quantity * record.pricePerUnit);
    tempMaterial.records.removeWhere((element) => element.id == record.id);

    notifyListeners();
  }

  //Contact Functions
  Future<List<Contact>> fetchContacts(String project) async {
    var url = Uri.parse(
        "https://home-construction-8f2e1-default-rtdb.firebaseio.com/projects/$project/contacts.json");
    try {
      final response = await http.get(url);
      if (json.decode(response.body) == null) {
        return [];
      }
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Contact> loadedContacts = [];
      extractedData.forEach((contactId, contactData) {
        loadedContacts.add(Contact(
          id: contactId,
          name: contactData['name'],
          number: contactData['number'],
        ));
      });
      return loadedContacts;
    } catch (error) {
      rethrow;
    }
  }

  Future<void> addContact(Contact contact, String project) async {
    var url = Uri.parse(
        "https://home-construction-8f2e1-default-rtdb.firebaseio.com/projects/$project/contacts.json");
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'name': contact.name,
            'number': contact.number,
          },
        ),
      );
      contact.id = json.decode(response.body)['name'];
    } catch (error) {
      rethrow;
    }
    findProject(project).contacts.add(contact);
    notifyListeners();
  }

  Future<void> editContact(Contact contact, String project) async {
    var url = Uri.parse(
        "https://home-construction-8f2e1-default-rtdb.firebaseio.com/projects/$project/contacts/${contact.id}.json");
    try {
      await http.patch(
        url,
        body: json.encode(
          {
            'name': contact.name,
            'number': contact.number,
          },
        ),
      );
    } catch (error) {
      rethrow;
    }
    findProject(project)
        .contacts
        .removeWhere((element) => element.id == contact.id);
    findProject(project).contacts.add(contact);
    notifyListeners();
  }

  Future<void> deleteContact(Contact contact, String project) async {
    var url = Uri.parse(
        "https://home-construction-8f2e1-default-rtdb.firebaseio.com/projects/$project/contacts/${contact.id}.json");
    await http.delete(url);
    findProject(project)
        .contacts
        .removeWhere((element) => element.name == contact.name);
    notifyListeners();
  }

  //PHOTOS FUNCTION
  Future<List<Album>> fetchAlbums(String project) async {
    var url = Uri.parse(
        "https://home-construction-8f2e1-default-rtdb.firebaseio.com/projects/$project/albums.json");
    try {
      final response = await http.get(url);
      if (json.decode(response.body) == null) {
        return [];
      }
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Album> loadedAlbums = [];
      extractedData.forEach((albumId, albumData) {
        loadedAlbums.add(Album(
          id: albumId,
          name: albumId,
        ));
      });
      return loadedAlbums;
    } catch (error) {
      rethrow;
    }
  }

  Future<void> addAlbum(Album album, String project) async {
    final url = Uri.parse(
        "https://home-construction-8f2e1-default-rtdb.firebaseio.com/projects/$project/albums/${album.name}.json");

    try {
      final response = await http.post(url,
          body: json.encode({
            'name': album.name,
          }));
      album.id = json.decode(response.body)['name'];
    } catch (error) {
      rethrow;
    }

    findProject(project).albums.add(album);
    notifyListeners();
  }

  Future<void> editAlbum(Album album, String project) async {
    final url = Uri.parse(
        "https://home-construction-8f2e1-default-rtdb.firebaseio.com/projects/$project/albums/${album.name}.json");

    try {
      await http.patch(url,
          body: json.encode({
            'name': album.name,
          }));
    } catch (error) {
      rethrow;
    }
    findProject(project)
        .albums
        .removeWhere((element) => element.id == album.id);
    findProject(project).albums.add(album);
    notifyListeners();
  }

  Future<void> deleteAlbum(Album album, String project) async {
    final url = Uri.parse(
        "https://home-construction-8f2e1-default-rtdb.firebaseio.com/projects/$project/albums/${album.name}.json");

    try {
      await http.delete(url);
    } catch (error) {
      rethrow;
    }

    findProject(project)
        .albums
        .removeWhere((element) => element.id == album.id);
    notifyListeners();
  }
}
