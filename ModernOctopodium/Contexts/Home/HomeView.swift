//
//  HomeView.swift
//  ModernOctopodium
//
//  Created by Nuno Gonçalves on 31/08/2019.
//  Copyright © 2019 numicago. All rights reserved.
//

import SwiftUI
import UIKit

enum Tab: Int {
    case languages, users, trending, settings

    private var tabInfo: (text: String, image: UIImage) {
        switch self {
        case .languages: return (text: "Languages", image: #imageLiteral(resourceName: "Language"))
        case .users: return (text: "Users", image: #imageLiteral(resourceName: "UserActive"))
        case .trending: return (text: "Trending", image: #imageLiteral(resourceName: "Star"))
        case .settings: return (text: "More", image: UIImage(systemName: "ellipsis")!)
        }
    }

    var item: some View {
        let info = tabInfo
        return VStack {
            Image(uiImage: info.image)
                .imageScale(.large)
            Text(info.text)
        }
    }
}

struct HomeView: View {

    @State var selectedTab = Tab.languages

    var body: some View {
        TabView(selection: $selectedTab) {
            LanguagesView(viewModel: LanguagesViewModel()).tabbed(with: .languages)
            UsersView().tabbed(with: .users)
            TrendingView().tabbed(with: .trending)
            SettingsView().tabbed(with: .settings)
        }
        .edgesIgnoringSafeArea(.top)
    }
}

private protocol ContainedInTab {
    associatedtype V: View
    func tabbed(with info: Tab) -> V
}

extension ContainedInTab where Self: View {
    func tabbed(with info: Tab) -> some View {
        self.tabItem { info.item }
            .tag(info)
    }
}

extension LanguagesView: ContainedInTab {}
extension UsersView: ContainedInTab {}
extension TrendingView: ContainedInTab {}
extension SettingsView: ContainedInTab {}

#if DEBUG
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .preferredColorScheme(.dark)
    }
}
#endif
