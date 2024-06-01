//
//  AsyncButton.swift
//  SettingsUI_ios
//
//  Created by Weiß, Alexander on 09.09.23.
//

import SwiftUI

// MARK: - AsyncButton

/// A button that is capable of executing an asynchronous action
///
/// It offers the possibilities to:
/// * show a progress view while the action is running
/// * show a success view when the action was successful
/// * show an error view when the action failed
///
/// - Important: Be sure that errors thrown in your `action` are implementing a proper localized `errorDescription` since this is
/// used in the error label
public struct AsyncButton<ButtonLabel: View>: View {
    // MARK: - Properties
    private let role: ButtonRole?
    private let action: () async throws -> Void
    private let options: AsyncButtonOptions
    private let label: ButtonLabel

    // MARK: - State Properties
    @State private var isDisabled = false
    @State private var error: Error?
    @State private var showProgressView = false
    @State private var showSuccessView = false
    @State private var hideLabel = false

    // MARK: - Initializer

    /// Create a new AsyncButton
    /// - Parameters:
    ///   - action: The action to execute
    ///   - options: Options to modify the behavior of the button
    ///   - label: The view to show as the label of the button
    public init(
        role: ButtonRole? = nil,
        action: @escaping () async throws -> Void,
        options: AsyncButtonOptions = .default,
        @ViewBuilder label: @escaping () -> ButtonLabel
    ) {
        self.role = role
        self.options = options
        self.action = action
        self.label = label()
    }

    // MARK: - Body
    public var body: some View {
        Button(
            role: self.role,
            action: {
                // Reset states
                if options.contains(.disableButton) {
                    isDisabled = true
                }
                error = nil
                showSuccessView = false

                // Execute the action
                Task {
                    var progressViewTask: Task<Void, Error>?

                    if options.contains(.showProgressView) {
                        progressViewTask = Task {
                            try await Task.sleep(nanoseconds: 150_000_000)
                            showProgressView = true
                            hideLabel = options.contains(.hideLabelOnProgress)
                        }
                    }

                    do {
                        try await action()

                        // Trigger success view if needed
                        if options.contains(.showSuccessView) {
                            withAnimation {
                                showSuccessView = true
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                withAnimation {
                                    self.showSuccessView = false
                                }
                            }
                        }

                    } catch {
                        // Trigger error view if needed
                        if options.contains(.showErrorView) {
                            withAnimation {
                                self.error = error
                            }
                            #if os(iOS) || os(visionOS)
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                UIAccessibility.post(
                                    notification: .announcement,
                                    argument: error.localizedDescription
                                )
                            }
                            #endif
                        }
                    }

                    progressViewTask?.cancel()
                    isDisabled = false
                    showProgressView = false
                    hideLabel = false
                }
            },
            label: {
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        if !hideLabel {
                            label
                        }
                        if showProgressView {
                            if !options.contains(.hideLabelOnProgress) {
                                Spacer()
                            }
                            ProgressView()
                                .frame(width: 22, height: 22)
                                .progressViewStyle(FioriProgressViewStyle())
                        }
                        if error != nil {
                            Spacer()
                            Image(smsSymbol: .fioriNotification3)
                                .foregroundStyle(Color.black)
                        }
                        if showSuccessView {
                            Spacer()
                            Image(smsSymbol: .fioriSysEnter)
                                .foregroundStyle(Color.black)
                        }
                    }
                    // Show localized error in the line below the rest
                    if let error {
                        Text(verbatim: error.localizedDescription)
                            .foregroundStyle(Color.black)
                            .multilineTextAlignment(.leading)
                    }
                }
            }
        )
        .disabled(isDisabled)
    }
}

// MARK: - Convenience Initializers
extension AsyncButton where ButtonLabel == Text {
    public init(
        _ titleKey: LocalizedStringKey,
        role: ButtonRole? = nil,
        action: @escaping () async throws -> Void,
        options: AsyncButtonOptions = .default
    ) {
        self.init(role: role, action: action, options: options) {
            Text(titleKey)
        }
    }
}

// MARK: - AsyncButtonOptions
public struct AsyncButtonOptions: OptionSet {
    public let rawValue: Int

    /// Disables the button when the action is running
    public static let disableButton = AsyncButtonOptions(rawValue: 1 << 0)

    /// Show a progress view while the action is running
    public static let showProgressView = AsyncButtonOptions(rawValue: 1 << 1)

    /// Hide the buttons label while the action is running
    public static let hideLabelOnProgress = AsyncButtonOptions(rawValue: 1 << 2)

    /// Show a success view when the action has been successfully finished
    public static let showSuccessView = AsyncButtonOptions(rawValue: 1 << 3)

    /// Show an error view when the action has been successfully finished
    public static let showErrorView = AsyncButtonOptions(rawValue: 1 << 4)

    /// Default options
    public static let `default`: AsyncButtonOptions = [
        .disableButton,
        .showProgressView,
        .showSuccessView,
        .showErrorView,
    ]

    /// Options optimised for usage in the toolbar
    public static let toolbar: AsyncButtonOptions = [
        .disableButton,
        .showProgressView,
        .hideLabelOnProgress,
    ]

    // MARK: - Initializer
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
}

// MARK: - ProgressViewStyle
struct FioriProgressViewStyle: ProgressViewStyle {
    // MARK: - State Properties
    @State private var drawingStroke: Bool = false

    // MARK: - Private Properties
    private let animation = Animation
        .linear(duration: 1.5)
        .repeatForever(autoreverses: false)

    private let strokeColor: Color

    // MARK: - Initializer
    init(strokeColor: Color = .black) {
        self.strokeColor = strokeColor
    }

    // MARK: - Body
    func makeBody(configuration _: Configuration) -> some View {
        Circle()
            .trim(from: 0.20, to: 1)
            .stroke(
                strokeColor,
                style: StrokeStyle(lineWidth: 2, lineCap: .square)
            )
            .rotationEffect(drawingStroke ? Angle(degrees: 360) : Angle(degrees: 0))
            .animation(animation, value: drawingStroke)
            .onAppear {
                drawingStroke = true
            }
    }
}

// MARK: - Preview
#Preview("Successful action") {
    AsyncButton(action: {
        try? await Task.sleep(seconds: 3)
    }) {
        Text("Successful action")
    }
}

#Preview("Failing action") {
    AsyncButton(action: {
        try? await Task.sleep(seconds: 3)
        throw NSError(domain: "hello", code: 1, userInfo: nil)
    }) {
        Text("Failing action")
    }
}

#Preview("Inside List") {
    List {
        Section {
            Label("FAQ", systemImage: "star")
            AsyncButton(action: {
                try? await Task.sleep(seconds: 3)
                throw NSError(domain: "hello", code: 1, userInfo: nil)
            }) {
                Label(
                    title: { Text("Label") },
                    icon: { Image(systemName: "42.circle") }
                )
            }
        }

        Section {
            Text("About")
        } header: {
            Text("About")
        }
    }
    #if os(iOS) || os(visionOS)
    .listStyle(.grouped)
    #endif
}

#Preview("Toolbar usage") {
    NavigationStack {
        Text("Toolbar")
            .navigationTitle("Toolbar Usage")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    AsyncButton("Success", action: {
                        try? await Task.sleep(seconds: 3)
                    }, options: .toolbar)
                }

                ToolbarItem(placement: .cancellationAction) {
                    AsyncButton("Failure", action: {
                        try? await Task.sleep(seconds: 3)
                        throw NSError(domain: "hello", code: 1, userInfo: nil)
                    }, options: .toolbar)
                }
            }
    }
}
