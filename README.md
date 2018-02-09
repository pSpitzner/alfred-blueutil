# Alfred BluetoothConnector
Allows you to (re)connect to already paired bluetooth devices (such as AirPods) through Alfred.
Tested on macOS 10.11 to 10.13

Activate in Alfred via ```bt``` Keyword followed by the device name.

Press ```alt``` to disconnect.

Bluetooth needs to be enabled since I failed to figure out how to access the required private (Obj-C) API using Swift. This would allow the workflow to change the controller state.

Feel free to modify the source
```
swiftc ./BluetoothConnector.swift
```
For the binary to work across different macOS versions, the Swift Standard Libraries need to be included (hence the huge file size). I managed that via Xcode, possibly can be done via command line, too.

The workflow is adapted from https://github.com/uchida/alfred-switch-bluetooth and the icons are bundled with macOS (all rights reserved to Apple).
If someone figures out how to access the device specific icons listed in the Bluetooth Preferences, tell me about it!
