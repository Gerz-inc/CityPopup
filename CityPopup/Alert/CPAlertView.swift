//
//  CPAlertView.swift
//  CityPopup
//
//  Created by Чилимов Павел on 03.11.2020.
//

import UIKit

public final class CPAlertView: CPPopupView {
    
    // MARK: - Private types
    private enum Spec {
        static let minimumWidth: CGFloat = 200
    }
    
    // MARK: - Private subviews
    private lazy var contentStackView = UIStackView() ~> {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
    }
    
    private var headerView: UIView?
    private var centerView: UIView?
    private var footerView: UIView?
    
    private lazy var titleLabel = UILabel() ~> {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = style.titleFont
        $0.textColor = style.titleColor
        $0.textAlignment = style.titleTextAlignment
        $0.numberOfLines = style.titleNumberOfLines
        $0.setContentCompressionResistancePriority(.required, for: .vertical)
    }
    private lazy var messageLabel = UILabel() ~> {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = style.messageFont
        $0.textColor = style.messageColor
        $0.textAlignment = style.messageTextAligment
        $0.numberOfLines = style.messageNumberOfLines
        $0.setContentCompressionResistancePriority(.required, for: .vertical)
    }
    private lazy var actionsStackView = UIStackView() ~> {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.distribution = .fillEqually
        $0.axis = style.actionsAxis.axis
        $0.spacing = style.spacingBetweenActions
    }
    private var actions = [UIControl]()
    
    // MARK: - Private properties
    private let title: String?
    private let message: String?
    private let attributedMessage: NSAttributedString?
    private var style: CPAlertStyle
    
    private var lastFirstResponder: UIView?
    public override var canBecomeFirstResponder: Bool {
        return true
    }
    
    // MARK: - Init
    public init(title: String?, message: String?, style: CPAlertStyle = .default) {
        self.title = title
        self.message = message
        self.attributedMessage = nil
        self.style = style
        
        super.init(frame: .zero)
        
        commonInit()
    }
    
    public init(title: String?, attributedMessage: NSAttributedString?, style: CPAlertStyle = .default) {
        self.title = title
        self.message = nil
        self.attributedMessage = attributedMessage
        self.style = style

        super.init(frame: .zero)

        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = style.backgroundColor
        layer.cornerRadius = style.cornerRadius
        if #available(iOS 13.0, *) {
            layer.cornerCurve = style.cornerCurve
        }
        layer.shadowColor = style.shadowColor.cgColor
        layer.shadowOffset = style.shadowOffset
        layer.shadowRadius = style.shadowRadius
        layer.shadowOpacity = style.shadowOpacity
        clipsToBounds = false
    }
    
    // MARK: - Lifecycle
    public override func willAppear() {
        super.willAppear()
        setupLayout()
        
        if let window = UIApplication.shared.windows.first {
            lastFirstResponder = window.firstResponder
            lastFirstResponder?.resignFirstResponder()
        }
    }
    
    public override func willDisappear() {
        super.willDisappear()
        
        lastFirstResponder?.becomeFirstResponder()
    }
    
}

// MARK: - Public methods
extension CPAlertView {
    
    /// Add a header view which will be displayed on top of the alert.
    /// - Parameter view: Some view as a cover.
    public func addHeader(_ view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        headerView = view
    }
    
    /// Add a center view which will be displayed between message and actions of the alert.
    /// - Parameter view: Some view as a cover.
    public func addContent(_ view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        centerView = view
    }
    
    /// Add a footer view which will be displayed on bottom of the alert.
    /// - Parameter view: Some view as a cover.
    public func addFooter(_ view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        footerView = view
    }
    
    /// Add action object to the alert.
    /// - Parameters:
    ///   - action: Action object which looks like a button and will be displayed on bottom of the alert.
    ///   - dismissOnTap: A flag to determine will be the alert dismissed on action tap.
    public func addAction(_ action: CPAlertActionView, dismissOnTap: Bool = true) {
        addAction(action as UIControl, dismissOnTap: dismissOnTap)
    }
    
    /// Add action objects to the alert.
    /// - Parameters:
    ///   - actions: Array of action objects which look like a buttons and will be displayed on bottom of the alert.
    ///   - dismissOnTap: A flag to determine will be the alert dismissed on actions tap.
    public func addActions(_ actions: [CPAlertActionView], dismissOnTap: Bool = true) {
        addActions(actions as [UIControl], dismissOnTap: dismissOnTap)
    }
    
    /// Add custom action object to the alert.
    /// - Parameters:
    ///   - action: Custom action object which looks like a button and will be displayed on bottom of the alert.
    ///   - dismissOnTap: A flag to determine will be the alert dismissed on action tap.
    public func addAction(_ action: UIControl, dismissOnTap: Bool = true) {
        actions.append(action)
        if dismissOnTap {
            action.addTarget(self, action: #selector(actionTouched), for: .touchUpInside)
        }
    }
    
    /// Add custom action objects to the alert.
    /// - Parameters:
    ///   - actions: Array of custom action objects which look like a buttons and will be displayed on bottom of the alert.
    ///   - dismissOnTap: A flag to determine will be the alert dismissed on actions tap.
    public func addActions(_ actions: [UIControl], dismissOnTap: Bool = true) {
        actions.forEach { self.addAction($0, dismissOnTap: dismissOnTap) }
    }
    
}

// MARK: - Public properties for testing
extension CPAlertView {
    
    public var titleLabelAccessibilityIdentifier: String? {
        get { titleLabel.accessibilityIdentifier }
        set { titleLabel.accessibilityIdentifier = newValue }
    }
    
    public var messageLabelAccessibilityIdentifier: String? {
        get { messageLabel.accessibilityIdentifier }
        set { messageLabel.accessibilityIdentifier = newValue }
    }
    
}

// MARK: - Private setups
extension CPAlertView {
    
    private func setupLayout() {
        widthAnchor.constraint(greaterThanOrEqualToConstant: Spec.minimumWidth).isActive = true
        
        // Content
        contentStackView.backgroundColor = .clear
        embedInScrollView(
            view: contentStackView,
            offsets: style.contentMargin,
            scrollingByAxis: .vertical,
            backgroundColor: .clear
        )
        
        // Header view
        if let headerView {
            contentStackView.addArrangedSubview(headerView)
            if let headerViewHeight = style.headerViewHeight {
                headerView.heightAnchor.constraint(equalToConstant: headerViewHeight).isActive = true
            }
        }
        
        // Title
        if let title = title {
            titleLabel.text = title
            titleLabel.backgroundColor = .clear
            contentStackView.addArrangedSubview(titleLabel)
        }
        
        // Message
        if let message = message {
            messageLabel.text = message
            contentStackView.addArrangedSubview(messageLabel)
            messageLabel.backgroundColor = .clear
        } else if let attributedMessage = attributedMessage {
            messageLabel.attributedText = attributedMessage
            contentStackView.addArrangedSubview(messageLabel)
            messageLabel.backgroundColor = .clear
        }
        
        // Center view
        if let centerView {
            contentStackView.addArrangedSubview(centerView)
            if let centerViewHeight = style.centerViewHeight {
                centerView.heightAnchor.constraint(equalToConstant: centerViewHeight).isActive = true
            }
        }
        
        if contentStackView.arrangedSubviews.isEmpty {
            assertionFailure("Content of an alert can not be empty")
        }
        
        // Actions
        if !actions.isEmpty {
            actionsStackView.backgroundColor = .clear
            
            switch style.actionsAxis {
            case .horizontal(let shouldFitIntoContainer):
                if shouldFitIntoContainer {
                    contentStackView.addArrangedSubview(actionsStackView)
                    
                } else {
                    contentStackView.embedInScrollView(
                        view: actionsStackView,
                        offsets: .zero,
                        scrollingByAxis: style.actionsAxis.axis,
                        backgroundColor: .clear
                    )
                }
                
            case .vertical:
                contentStackView.addArrangedSubview(actionsStackView)
            }
            
            actions.forEach { action in
                actionsStackView.addArrangedSubview(action)
            }
        }
        
        // Footer view
        if let footerView {
            contentStackView.addArrangedSubview(footerView)
            if let footerViewHeight = style.footerViewHeight {
                footerView.heightAnchor.constraint(equalToConstant: footerViewHeight).isActive = true
            }
        }
        
        setupContentSpacings()
    }
    
    private func setupContentSpacings() {
        if let headerView {
            contentStackView.setSpacing(style.spacingAfterCoverView, after: headerView)
        }
        if title != nil {
            contentStackView.setSpacing(style.spacingAfterTitle, after: titleLabel)
        }
        if message != nil || attributedMessage != nil {
            contentStackView.setSpacing(style.spacingAfterMessage, after: messageLabel)
        }
    }
    
}

// MARK: - Private UI interactions
extension CPAlertView {
    
    @objc
    private func actionTouched() {
        hide()
    }
    
}

// MARK: - Private extensions
fileprivate extension UIView {
    
    var firstResponder: UIView? {
        guard !isFirstResponder else { return self }

        for subview in subviews {
            if let firstResponder = subview.firstResponder {
                return firstResponder
            }
        }

        return nil
    }
    
}
