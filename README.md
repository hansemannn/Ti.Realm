# Ti.Realm

 Summary
---------------
Ti.Realm is an open-source project to support the Realm iOS-SDK in Appcelerator's Titanium Mobile. 
The module is currently in the early alpha phase and should not be used in any productional project. 

Requirements
---------------
  - Titanium Mobile SDK 6.0.0.GA or later
  - iOS 8.0 or later
  - Xcode 8 or later

Example (PoC)
---------------
This module requires the static Framework `Realm.framework` to be downloaded in the `platform/` directory.

Example (PoC)
---------------

```js
var Realm = require('ti.realm');

var User = Realm.createObject({
    value: ['firstName', 'lastName']
});

Realm.addObject(User);

var firstName = User.get('firstName');
User.set('firstName', 'Hans');

```

Author
---------------
Hans Knoechel ([@hansemannnn](https://twitter.com/hansemannnn) / [Web](http://hans-knoechel.de))

License
---------------
Apache 2.0

Contributing
---------------
Code contributions are greatly appreciated, please submit a new [pull request](https://github.com/hansemannn/ti.realm/pull/new/master)!
