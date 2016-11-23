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

// TODO: Change properties to something like `String` and write mapper-class
var User = Realm.createObject('User', {
    'firstName': 'NSString',
    'lastName': 'NSString',
    'age': 'NSNumber<RLMInt>'
});

Realm.addObject(User);

var win = Ti.UI.createWindow({
    backgroundColor: '#fff'
});

var btn = Ti.UI.createButton({
    title: 'Change name to Jon'
});

btn.addEventListener('click', function() {
    User.setProperty('firstName', 'Jon');
    User.setProperty('lastName', 'Doe');

    //  This won't work so far, because we need to detect and cast the values
    //  User.setProperty('age', 24);

    alert('Changed name to: ' + User.getProperty('firstName') + ' ' + User.getProperty('lastName')); // + '(' + User.getProperty('age') + ')');
});

win.add(btn);
win.open();


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
