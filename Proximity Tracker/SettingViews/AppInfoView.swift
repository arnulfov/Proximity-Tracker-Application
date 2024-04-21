//
//  AppInfoView.swift
//  Proximity Tracker
//
//  Created by user238598 on 4/2/24.
//

import SwiftUI

struct InformationView: View {
    
    @Environment(\.openURL) var openURL
    
    var body: some View {
        
        NavigationSubView(spacing: Constants.SettingsSectionSpacing) {
            
            VStack(spacing: 0) {
                Button {
                    // Easter egg :)
                    mediumVibration()
                } label: {
                    /*ScanAnimation(size: 70, withBackground: true)
                        .cornerRadius(25)
                        .padding()*/
                }
                
                Text(String(format: "informationview_os".localized(), getOSName()))
                    .padding(.bottom, 3)
                Text("version".localized() + " \(getAppVersion())")
                    .opacity(0.5)
            }
            .padding(.top)
            
            
            CustomSection(){
                
                Button(action: {
                    writeMail(to: "promixitytracker99@gmail.com")
                }) {
                    NavigationLinkLabel(imageName: "envelope.fill", text: "contact_developer", backgroundColor: Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)), isNavLink: false)
                }
                
                /*NavigationLink(destination: ArticleView(article: faqArticle)) {
                    NavigationLinkLabel(imageName: "questionmark.bubble.fill", text: "FAQ", backgroundColor: .purple, isNavLink: true)
                }*/
            }
            
            CustomSection(header: "credits") {
                
                if let url = URL(string: "https://abrahamjeffrey.com") {
                    Link(destination: url, label: {
                        NavigationLinkLabel(imageName: "curlybraces", text: "developer", backgroundColor: .green, isNavLink: false, status: "Jeffrey Abraham")
                    })
                }
                
                Button(action: {
                    writeMail(to: "bluetoothscanner99@gmail.com")
                }) {
                    NavigationLinkLabel(imageName: "person.fill", text: "maintainer", backgroundColor: .orange, isNavLink: false, status: "Jeffrey Abraham")
                }
            }
  
            /*
            CustomSection(header: "copyright") {
                Text("copyright_text")
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(Color("MainColor"))
                    .padding(.vertical)
            }
             */
        }
        .navigationBarTitle("", displayMode: .inline)
    }
    
    func writeMail(to address: String) {
        if let url = URL(string: "mailto:\(address)") {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
}


/// Returns the app version number.
private func getAppVersion() -> String {
    let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    return "\(appVersion ?? "unknown")"
}


struct Previews_AppInfoView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            InformationView()
        }
    }
}
