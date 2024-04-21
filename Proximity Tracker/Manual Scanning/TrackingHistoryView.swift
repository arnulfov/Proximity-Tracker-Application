//
//  TrackingHistoryView.swift
//  Proximity Tracker
//
//  Created by user238598 on 4/2/24.
//

import SwiftUI

struct TrackerHistoryView: View {
    
    @ObservedObject var clock = Clock.sharedInstance
    
    // Show all devices EXCEPT those shown in manual scan
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \BaseDevice.lastSeen, ascending: false)],
        predicate: NSPredicate(format: "lastSeen < %@ AND deviceType != %@ AND deviceType != nil", Clock.sharedInstance.currentDate.addingTimeInterval(-Constants.manualScanBufferTime) as CVarArg, DeviceType.Unknown.rawValue),
        animation: .spring())
    private var devices: FetchedResults<BaseDevice>
    
    var body: some View {
        
        ScrollView {
            LazyVStack {
                
                ForEach(devices) { elem in
                    
                    if let detectionEvents = elem.detectionEvents, let lastSeenSeconds = getLastSeenSeconds(device: elem, currentDate: clock.currentDate) {
                        
                        let times = detectionEvents.count
                        let timesText = String(format: "seen_x_times_last".localized(), times.description, getSimpleSecondsText(seconds: lastSeenSeconds, longerDate: false))
                        
                        CustomSection(header: timesText) {
                            DeviceEntryButton(device: elem, showAlerts: true)
                            
                        }
                    }
                }
                 
                if(devices.count == 0) {
                    BigSymbolViewWithText(title: "", symbol: "questionmark.circle.fill", subtitle: "no_device_detected_yet")
                    
                }
                
                Spacer()
                
            }
            .frame(maxWidth: Constants.maxWidth)
            .frame(maxWidth: .infinity)
            .padding(.bottom)
        }
        .modifier(CustomFormBackground())
        .navigationTitle("tracker_history")
        // .modifier(GoToRootModifier(view: .ManualScan))
    }
}


struct Previews_OldTrackersView_Previews: PreviewProvider {
    
    static var previews: some View {
        TrackerHistoryView()
    }
}

