//
//  CPAlertStyle.swift
//  CityPopup
//
//  Created by Чилимов Павел on 03.11.2020.
//

import UIKit

public struct CPAlertStyle {
    
    // MARK: - Public types
    public enum ActionsAxis {
        /// Actions will be align vertically.
        case vertical
        /// Actions will be align horizontally and can be fit into container or can be scrollable.
        case horizontal(shouldFitIntoContainer: Bool)
    }
    
    // MARK: - Internal properties
    
    private var _cornerCurve: Any?
    @available(iOS 13.0, *)
    private(set) var cornerCurve: CALayerCornerCurve {
        get { _cornerCurve as? CALayerCornerCurve ?? .circular }
        set { _cornerCurve = newValue }
    }
    
    let cornerRadius: CGFloat
    let backgroundColor: UIColor
    
    let shadowColor: UIColor
    let shadowOffset: CGSize
    let shadowRadius: CGFloat
    let shadowOpacity: Float
    
    let contentMargin: UIEdgeInsets
    
    let headerViewHeight: CGFloat?
    let centerViewHeight: CGFloat?
    let footerViewHeight: CGFloat?
    
    let titleFont: UIFont
    let titleColor: UIColor
    let titleTextAlignment: NSTextAlignment
    let titleNumberOfLines: Int
    
    let messageFont: UIFont
    let messageColor: UIColor
    let messageTextAligment: NSTextAlignment
    let messageNumberOfLines: Int
    
    let actionsAxis: ActionsAxis
    
    let spacingAfterCoverView: CGFloat
    let spacingAfterTitle: CGFloat
    let spacingAfterMessage: CGFloat
    let spacingBetweenActions: CGFloat
    
    // MARK: - Init
    public init(
        cornerRadius: CGFloat = 8,
        backgroundColor: UIColor = CPColor.white_gray14,
        shadowColor: UIColor = UIColor.clear,
        shadowOffset: CGSize = CGSize(width: 0, height: 3),
        shadowRadius: CGFloat = 6.0,
        shadowOpacity: Float = 0.3,
        contentMargin: UIEdgeInsets = .init(top: 24, left: 24, bottom: 24, right: 24),
        headerViewHeight: CGFloat? = nil,
        centerViewHeight: CGFloat? = nil,
        footerViewHeight: CGFloat? = nil,
        titleFont: UIFont = .boldSystemFont(ofSize: 24),
        titleColor: UIColor = CPColor.black_white,
        titleTextAlignment: NSTextAlignment = .center,
        titleNumberOfLines: Int = 0,
        messageFont: UIFont = .systemFont(ofSize: 16),
        messageColor: UIColor = CPColor.black_white,
        messageTextAligment: NSTextAlignment = .center,
        messageNumberOfLines: Int = 0,
        actionsAxis: ActionsAxis = .vertical,
        spacingAfterCoverView: CGFloat = 24,
        spacingAfterTitle: CGFloat = 24,
        spacingAfterMessage: CGFloat = 24,
        spacingBetweenActions: CGFloat = 16)
    {
        self.cornerRadius = cornerRadius
        self.backgroundColor = backgroundColor
        self.shadowColor = shadowColor
        self.shadowOffset = shadowOffset
        self.shadowRadius = shadowRadius
        self.shadowOpacity = shadowOpacity
        self.contentMargin = contentMargin
        self.headerViewHeight = headerViewHeight
        self.centerViewHeight = centerViewHeight
        self.footerViewHeight = footerViewHeight
        self.titleFont = titleFont
        self.titleColor = titleColor
        self.titleTextAlignment = titleTextAlignment
        self.titleNumberOfLines = titleNumberOfLines
        self.messageFont = messageFont
        self.messageColor = messageColor
        self.messageTextAligment = messageTextAligment
        self.messageNumberOfLines = messageNumberOfLines
        self.actionsAxis = actionsAxis
        self.spacingAfterCoverView = spacingAfterCoverView
        self.spacingAfterTitle = spacingAfterTitle
        self.spacingAfterMessage = spacingAfterMessage
        self.spacingBetweenActions = spacingBetweenActions
    }
    
    @available(iOS 13.0, *)
    public init(
        cornerRadius: CGFloat = 8,
        cornerCurve: CALayerCornerCurve = .circular,
        backgroundColor: UIColor = CPColor.white_gray14,
        shadowColor: UIColor = UIColor.clear,
        shadowOffset: CGSize = CGSize(width: 0, height: 3),
        shadowRadius: CGFloat = 6.0,
        shadowOpacity: Float = 0.3,
        contentMargin: UIEdgeInsets = .init(top: 24, left: 24, bottom: 24, right: 24),
        headerViewHeight: CGFloat? = nil,
        centerViewHeight: CGFloat? = nil,
        footerViewHeight: CGFloat? = nil,
        titleFont: UIFont = .boldSystemFont(ofSize: 24),
        titleColor: UIColor = CPColor.black_white,
        titleTextAlignment: NSTextAlignment = .center,
        titleNumberOfLines: Int = 0,
        messageFont: UIFont = .systemFont(ofSize: 16),
        messageColor: UIColor = CPColor.black_white,
        messageTextAligment: NSTextAlignment = .center,
        messageNumberOfLines: Int = 0,
        actionsAxis: ActionsAxis = .vertical,
        spacingAfterCoverView: CGFloat = 24,
        spacingAfterTitle: CGFloat = 24,
        spacingAfterMessage: CGFloat = 24,
        spacingBetweenActions: CGFloat = 16)
    {
        self.cornerRadius = cornerRadius
        self.backgroundColor = backgroundColor
        self.shadowColor = shadowColor
        self.shadowOffset = shadowOffset
        self.shadowRadius = shadowRadius
        self.shadowOpacity = shadowOpacity
        self.contentMargin = contentMargin
        self.headerViewHeight = headerViewHeight
        self.centerViewHeight = centerViewHeight
        self.footerViewHeight = footerViewHeight
        self.titleFont = titleFont
        self.titleColor = titleColor
        self.titleTextAlignment = titleTextAlignment
        self.titleNumberOfLines = titleNumberOfLines
        self.messageFont = messageFont
        self.messageColor = messageColor
        self.messageTextAligment = messageTextAligment
        self.messageNumberOfLines = messageNumberOfLines
        self.actionsAxis = actionsAxis
        self.spacingAfterCoverView = spacingAfterCoverView
        self.spacingAfterTitle = spacingAfterTitle
        self.spacingAfterMessage = spacingAfterMessage
        self.spacingBetweenActions = spacingBetweenActions
        
        self.cornerCurve = cornerCurve
    }
    
}

// MARK: - Public predefined style
extension CPAlertStyle {
    
    public static let `default` = CPAlertStyle()
    
}

// MARK: - Internal ActionsAxis extension
extension CPAlertStyle.ActionsAxis {
    
    var axis: NSLayoutConstraint.Axis {
        switch self {
        case .horizontal:
            return .horizontal
            
        case .vertical:
            return .vertical
        }
    }
    
}
