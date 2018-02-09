import IOBluetooth

func printHelp() {
		print("Usage:\nBluetoothConnector 00-00-00-00-00-00\n\nGet the MAC address from the list below (if your device is missing, pair it with your computer first):");
		IOBluetoothDevice.pairedDevices().forEach({(device) in
				guard let device = device as? IOBluetoothDevice,
				let addressString = device.addressString,
				let deviceName = device.name
				else { return }
				print("\(addressString) - \(deviceName)")
		})
}

func printList() {
	IOBluetoothDevice.pairedDevices().forEach({(device) in
				guard let device = device as? IOBluetoothDevice,
				let addressString = device.addressString,
				let deviceName = device.name
				else { return }
				let deviceClass = device.deviceClassMajor // major 4 is audio.
				print("\(addressString) - \(deviceName) - \(deviceClass)")
	})
}

func printListXml() {
	print("{\"items\": [")
	IOBluetoothDevice.pairedDevices().forEach({(device) in
				guard let device = device as? IOBluetoothDevice,
				let addressString = device.addressString,
				let deviceName = device.name
				else { return }
				print("\t{\"uid\": \"\(addressString)\",")
				print("\t\"title\": \"\(deviceName)\",")
				print("\t\"arg\": \"\(addressString)\",")
				if device.isConnected() {
				print("\t\"subtitle\": \"Reconnect Bluetooth Device\",")
					print("\t\"icon\": {\"path\": \"./_active.icns\"}")
				} else {
					print("\t\"subtitle\": \"Connect Bluetooth Device\",")
					print("\t\"icon\": {\"path\": \"./_inactive.icns\"}")
				}
				print("\t},")
	})
	print("]}")
}


func connect(device : String?) {
	guard let bluetoothDevice = IOBluetoothDevice(addressString: device)
	else {
		print("Device not found")
		exit(-2)
	}
	bluetoothDevice.openConnection()
}

func disconnect(device : String?) {
	guard let bluetoothDevice = IOBluetoothDevice(addressString: device)
	else {
		print("Device not found")
		exit(-2)
	}
	bluetoothDevice.closeConnection()
}


for a in 0...CommandLine.arguments.count-1 {
	switch CommandLine.arguments[a] {
		case "-h":
			printHelp()

		case "--list":
			printList()

		case "--listforalfred":
			printListXml()

		case "--connect":
			let deviceAddress : String? = CommandLine.arguments.count > a+1 ? CommandLine.arguments[a+1] : nil
			connect(device: deviceAddress)

		case "--disconnect":
			let deviceAddress : String? = CommandLine.arguments.count > a+1 ? CommandLine.arguments[a+1] : nil
			disconnect(device: deviceAddress)

		default:break
	}
}
