import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:journey_joy_client/Classes/Functions/edit_route_order.dart';
import 'package:journey_joy_client/Classes/trip.dart';
import 'package:journey_joy_client/Cubits/trip_cubit.dart';
import 'package:journey_joy_client/Dialogs/error_dialog.dart';
import 'package:journey_joy_client/Tiles/RouteTile.dart';
import 'package:http/http.dart' as http;

class RouteList extends StatefulWidget {
  final Trip trip;
  final String token;

  const RouteList({Key? key, required this.trip, required this.token})
      : super(key: key);

  @override
  State createState() => _ListTileExample();
}

class InnerList {
  final String name;
  List<String> children;
  InnerList({required this.name, required this.children});
}

class _ListTileExample extends State<RouteList> {
  late List<InnerList> _lists;
  late List<List<String>> _orderedListOfAttractions;

  final weekdays = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];

  @override
  void initState() {
    super.initState();

    _orderedListOfAttractions =
        List<List<String>>.from(widget.trip.route.attractionsInOrder);
    _orderedListOfAttractions
        .add(List<String>.from(widget.trip.attractionsNotOnRoute));

    _lists = List.generate(_orderedListOfAttractions.length, (outerIndex) {
      String tileName = '';

      if (outerIndex == _orderedListOfAttractions.length - 1) {
        tileName = 'Attractions that didn\'t fit the route';
      } else {
        tileName =
            'Day ${outerIndex + 1} - ${weekdays[widget.trip.route.startDay + outerIndex % 7]}';
      }

      return InnerList(
        name: tileName,
        children: List.generate(
          _orderedListOfAttractions[outerIndex].length,
          (innerIndex) => _orderedListOfAttractions[outerIndex][innerIndex],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return DragAndDropLists(
      children: List.generate(_lists.length, (index) => _buildList(index)),
      onItemReorder: _onItemReorder,
      onListReorder: _onListReorder,
      listGhost: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30.0),
        child: Center(
          child: Container(
            padding:
                const EdgeInsets.symmetric(vertical: 30.0, horizontal: 100.0),
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(7.0),
            ),
            child: const Icon(Icons.add_box),
          ),
        ),
      ),
    );
  }

  _buildList(int outerIndex) {
    var innerList = _lists[outerIndex];
    return DragAndDropListExpansion(
      title: Text(innerList.name),
      subtitle: Text('Count: ${innerList.children.length}'),
      leading: const Icon(Icons.calendar_month),
      children: List.generate(innerList.children.length,
          (index) => _buildItem(innerList.children[index], outerIndex)),
      listKey: ObjectKey(innerList),
    );
  }

  _buildItem(String item, int outerIndex) {
    return DragAndDropItem(
      child: Expanded(
        child: RouteTile(
          attraction: widget.trip.attractions
              .firstWhere((element) => element.tripAdvisorLocationId == item),
          day: outerIndex,
          showHours: true,
        ),
      ),
    );
  }

  _onItemReorder(
      int oldItemIndex, int oldListIndex, int newItemIndex, int newListIndex) {
    setState(() {
      var movedItem = _lists[oldListIndex].children.removeAt(oldItemIndex);
      _lists[newListIndex].children.insert(newItemIndex, movedItem);

      List<List<String>> _newAttrInOrder = [];

      for (int i = 0; i < _lists.length - 1; i++) {
        _newAttrInOrder.add(_lists[i].children);
      }

      EditRouteAction()
          .edit(_newAttrInOrder, widget.trip.id, widget.token)
          .then((http.Response? response) {
        if (response != null) {
          if (response.statusCode != 200) {
            showDialog<String>(
                context: context,
                builder: (BuildContext context) =>
                    ErrorDialog(prop: response.body));
          }
        }
      });
    });
  }

  _onListReorder(int oldListIndex, int newListIndex) {}
}
