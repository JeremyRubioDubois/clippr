import 'package:clippr/app.dart';
import 'package:clippr/screens/provider/provider.dart';
import 'package:flutter/material.dart';

class CardProvider extends StatelessWidget {
  final String _lastName;
  final String _firstName;
  final String _profilePicture;
  final String _grade;

  CardProvider(
      this._lastName, this._firstName, this._profilePicture, this._grade);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _onProviderTap(context, _firstName),
      child: Container(
        margin: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 15),
                decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 15.0,
                    spreadRadius: -5.0,
                  ),
                ]),
                height: 120,
                width: 120,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(_profilePicture),
                ),
              ),
              Container(
                  margin: const EdgeInsets.only(bottom: 15),
                  child: Text(_lastName + ' ' + _firstName,
                      style: Theme.of(context).textTheme.headline5)),
              Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(Radius.circular(100.0))),
                  width: 100,
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  margin: const EdgeInsets.only(bottom: 15),
                  child: Center (
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.grey,
                            size: 20.0,
                          ),
                          Text(
                            _grade,
                            style: Theme.of(context).textTheme.bodyText2
                          ),
                        ]
                      )
                    )
                  )
              )
            ]),
      ),
    );
  }

  _onProviderTap(BuildContext context, _firstName) {
    Navigator.pushNamed(context, ProviderRoute, arguments: {'id': _firstName});
  }

}
