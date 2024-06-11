import SwiftUI
import Factory
#if !os(visionOS)
import SwiftUIIntrospect
#endif
import CurrencyCore

@MainActor
struct AppView: View {
    @Environment(\.openWindow) var openWindow
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @Injected(\.soundEffectManagerAPI) var soundEffectManagerAPI

    @Binding var selectedTab: Tab
    @Binding var appRouterPath: RouterPath

    @State var iosTabs = iOSTabs.shared
    @State var sidebarTabs = SidebarTabs.shared

    var body: some View {
        #if os(visionOS)
        tabBarView
        #else
        if UIDevice.current.userInterfaceIdiom == .pad || UIDevice.current.userInterfaceIdiom == .mac {
            sidebarView
        } else {
            tabBarView
        }
        #endif
    }

    var availableTabs: [Tab] {
        if UIDevice.current.userInterfaceIdiom == .phone || horizontalSizeClass == .compact {
            return iosTabs.tabs
        } else if UIDevice.current.userInterfaceIdiom == .vision {
            return iosTabs.tabs
        }
        return sidebarTabs.tabs.map { $0.tab }
    }

    var tabBarView: some View {
        TabView(selection: $selectedTab) {
            ForEach(availableTabs) { tab in
                tab.makeContentView(selectedTab: $selectedTab)
                    .tabItem {
                        tab.label
                    }
                    .tag(tab)
                    .toolbarBackground(.visible, for: .tabBar)
            }
        }.onChange(of: selectedTab) { oldvalue, newValue in
            soundEffectManagerAPI.playSound(.tabSelection)
            print("Изменение таба: \(newValue)")
        }
    }
    
#if !os(visionOS)
    var sidebarView: some View {
        SideBarView(selectedTab: $selectedTab,
                    tabs: availableTabs)
        {
            HStack(spacing: 0) {
                TabView(selection: $selectedTab) {
                    ForEach(availableTabs) { tab in
                        tab
                            .makeContentView(selectedTab: $selectedTab)
                            .tabItem {
                                Image(systemName: tab.iconName)
                            }
                            .tag(tab)
                    }
                }
                .introspect(.tabView, on: .iOS(.v17)) { (tabview: UITabBarController) in
                    tabview.tabBar.isHidden = horizontalSizeClass == .regular
                    tabview.customizableViewControllers = []
                    tabview.moreNavigationController.isNavigationBarHidden = true
                }
            }
        }
        .environment(appRouterPath)
    }
#endif
}
