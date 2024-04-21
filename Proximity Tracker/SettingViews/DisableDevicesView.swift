//
//  DisableDevicesView.swift
//  Proximity Tracker
//
//  Created by user238598 on 4/2/24.
//

import SwiftUI

struct DisableDevicesView: View {
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \BaseDevice.firstSeen, ascending: true)],
        predicate: NSPredicate(format: "ignore == TRUE && deviceType != nil"),
        animation: .spring())
    private var devices: FetchedResults<BaseDevice>
    
    
    var body: some View {
        
            NavigationSubView {
                
                CustomSection(header: "device_types", footer: "ignore_type_footer") {
                    
                    
                    let types = DeviceType.allCases.filter({$0 != .Unknown && $0.constants.supportsBackgroundScanning})
                    
                    ForEach(types) { type in
                        
                        DisableDeviceTypeView(deviceType: type)
                        
                        if(type != types.last) {
                            CustomDivider()
                        }
                    }
                }
                
                if(devices.count >= 1) {
                    CustomSection(header: "devices") {
                        
                        
                        ForEach(devices) { device in
                            
                            DeviceEntryButton(device: device)
                            
                            if(device != devices.last) {
                                CustomDivider()
                            }
                        }
                    }.padding(.top)
                }
                 
                Spacer()
                
            }
            .navigationTitle("ignored_devices")
    }
}


struct DisableDeviceTypeView: View {
    
    let deviceType: DeviceType
    
    var body: some View {
        
        let binding = Binding {
            deviceType.getIgnore()
        } set: { newValue in
            deviceType.setIgnore(toValue: newValue)
        }
        
        Toggle(isOn: binding) {
            HStack {
                deviceType.constants.iconView
                Text("ignore_every".localized() + " " + deviceType.constants.name)
                    .foregroundColor(Color("MainColor"))
                
                Spacer()
            }.frame(height: Constants.SettingsLabelHeight)
        }
    }
}


struct Previews_DisableDevicesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DisableDevicesView()
        }
    }
}
