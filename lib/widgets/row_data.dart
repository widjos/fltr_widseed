import 'package:flutter/material.dart';

class RowData extends StatefulWidget {
  
  String idData1;
  String valueData1;
  String idData2;
  String valueData2;

  RowData({ Key? key, required this.idData1 , required this.valueData1, required this.idData2 , required this.valueData2  }) : super(key: key);

  @override
  State<RowData> createState() => _RowDataState();
}

class _RowDataState extends State<RowData> {
  @override
  Widget build(BuildContext context) {
    return LimitedBox(
      maxHeight: 60,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(left: 10, top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
              widget.idData1,
              style: Theme.of(context).textTheme.bodyText1,
              ),
                Text(
              widget.valueData1,
              style: Theme.of(context).textTheme.bodyText1,
              ),
            ],
            )
          ),
          Container(
            padding: const EdgeInsets.only(left: 10, top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
              widget.idData2,
              style: Theme.of(context).textTheme.bodyText1,
              ),
                Text(
              widget.valueData2,
              style: Theme.of(context).textTheme.bodyText1,
              ),
            ],
            )
          ),
        ],
      ),
      
    );
  }
}