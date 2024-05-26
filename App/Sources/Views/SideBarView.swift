import SwiftUI
import SMSCore
#if !os(visionOS) && !targetEnvironment(macCatalyst)
import SwiftUIIntrospect
#endif

@MainActor
struct SideBarView<Content: View>: View {
    @Environment(\.openWindow) private var openWindow
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass

    @Environment(RouterPath.self) private var routerPath

    @Binding var selectedTab: Tab
    var tabs: [Tab]
    @ViewBuilder var content: () -> Content

    @State private var sidebarTabs = SidebarTabs.shared

    private func makeIconForTab(tab: Tab) -> some View {
                SideBarIcon(systemIconName: tab.iconName,
                            isSelected: tab == selectedTab)
        .frame(width: 50, height: 50)
    }

    private var tabsView: some View {
        ForEach(tabs) { tab in
            Button {
                // ensure keyboard is always dismissed when selecting a tab
                hideKeyboard()
                selectedTab = tab
            } label: {
                makeIconForTab(tab: tab)
            }
            .help(tab.title)
        }
    }

    var body: some View {
        @Bindable var routerPath = routerPath

        HStack(spacing: 0) {
            if horizontalSizeClass == .regular {
                ScrollView {
                    VStack(alignment: .center) {
                        
                        tabsView
                        
                    }
                    .frame(width: .sidebarWidth)
                    .scrollContentBackground(.hidden)
                    .background(.thinMaterial)
//                    Divider().edgesIgnoringSafeArea(.all)
                }
                content()
            }
        }
        .background(.thinMaterial)
        .edgesIgnoringSafeArea(.bottom)
//        .withSheetDestinations(sheetDestinations: $routerPath.presentedSheet)
    }
}

private struct SideBarIcon: View {
    
    let systemIconName: String
    let isSelected: Bool

    @State private var isHovered: Bool = false

    var body: some View {
        Image(systemName: systemIconName)
            .font(.title2)
            .fontWeight(.medium)
            .foregroundColor(isSelected ? Color.cyan : Color.red)
            .symbolVariant(isSelected ? .fill : .none)
            .scaleEffect(isHovered ? 0.8 : 1.0)
            .onHover { isHovered in
                withAnimation(.interpolatingSpring(stiffness: 300, damping: 15)) {
                    self.isHovered = isHovered
                }
            }
            .frame(width: 50, height: 40)
    }
}

extension View {
    @MainActor func hideKeyboard() {
        let resign = #selector(UIResponder.resignFirstResponder)
        UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
    }
}

@MainActor
public extension CGFloat {
    static let layoutPadding: CGFloat = 20
    static let dividerPadding: CGFloat = 2
    static let scrollToViewHeight: CGFloat = 1
    static let statusColumnsSpacing: CGFloat = 8
    static let statusComponentSpacing: CGFloat = 6
    static let secondaryColumnWidth: CGFloat = 400
    static let sidebarWidth: CGFloat = 90
    static let sidebarWidthExpanded: CGFloat = 220
    static let pollBarHeight: CGFloat = 30
}
