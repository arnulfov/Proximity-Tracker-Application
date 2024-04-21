//
//  BluetoothPermissionView.swift
//  Proximity Tracker
//
//  Created by user238598 on 4/2/24.
//

import SwiftUI


struct BluetoothPermissionView: View {
    
    @ObservedObject var bluetoothManager = BluetoothManager.sharedInstance
    
    var body: some View {
        
        let canProceed = bluetoothManager.centralManager?.state == .poweredOn || bluetoothManager.centralManager?.state == .poweredOff
        
        PermissionView(title: "bluetooth_access", symbol: "magnifyingglass.circle.fill", subtitle: "bluetooth_access_description", action: {
            
            bluetoothManager.startCentralManager()
            
            if(bluetoothManager.centralManager?.state == .unauthorized) {
                openAppSettings()
            }
            
            if canProceed {
                IntroducationViewController.sharedInstance.canProceed = true
            }
            
        }) {
            LocationPermissionView()
        }

        .onChange(of: canProceed) { oldValue, newValue in
            IntroducationViewController.sharedInstance.canProceed = true
        }
    }
}

struct Previews_BluetoothPermissionView_Previews: PreviewProvider {
    static var previews: some View {
        BluetoothPermissionView()
    }
}
