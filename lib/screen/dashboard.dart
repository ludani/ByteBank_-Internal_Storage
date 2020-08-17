import 'package:bankbyte/screen/contacts_list.dart';
import 'package:bankbyte/screen/transactions_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('lib/images/bytebank_logo.png'),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                _FeatureItem(
                  'Transfer',
                  Icons.monetization_on,
                  onClick: () {
                    _showContactsList(context);
                  },
                ),
                _FeatureItem(
                  'Transaction Feed',
                  Icons.monetization_on,
                  onClick: () {
                    _showTransactionsList(context);
                  },
                ),
                _FeatureItem(
                  'List',
                  Icons.description,
                  onClick: () {},
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void _showContactsList(BuildContext context) {
  Navigator.of(context).push(
    (MaterialPageRoute(
      builder: (context) => ContactsList(),
    )),
  );
}

void _showTransactionsList(BuildContext context) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => TransactionsList(),
    ),
  );
}

class _FeatureItem extends StatelessWidget {
  final String name;
  final IconData icon;
  final Function onClick;

  _FeatureItem(this.name, this.icon, {@required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Theme.of(context).primaryColor,
        child: InkWell(
          onTap: () => onClick(),
          child: Container(
            height: 100,
            width: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    icon,
                    color: Colors.white,
                    size: 24.0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    name,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
