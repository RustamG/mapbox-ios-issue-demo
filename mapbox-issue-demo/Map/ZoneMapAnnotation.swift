//
//  ZoneMapAnnotation.swift
//  mapbox-issue-demo
//
//  Created by Rustam G on 11.06.2020.
//  Copyright © 2020 Test. All rights reserved.
//

import Mapbox
import UIKit

class ZoneMapAnnotation: NSObject, MGLAnnotation {

    var zoneId: String
    var title: String?
    var bubbleColor: UIColor
    var coordinate: CLLocationCoordinate2D

    init(zoneId: String, title: String, bubbleColor: UIColor, coordinate: CLLocationCoordinate2D) {
        self.zoneId = zoneId
        self.bubbleColor = bubbleColor
        self.title = title
        self.coordinate = coordinate
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ZoneMapAnnotationView: MGLAnnotationView {

    private weak var annotationView: ZoneAnnotationView?

    var bubbleColor: UIColor = .clear {
        didSet {
            annotationView?.bubbleColor = bubbleColor
        }
    }

    var text: String = "" {
        didSet {
            annotationView?.text = text
        }
    }

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupView()
    }

    override init(annotation: MGLAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {

        isUserInteractionEnabled = true
        translatesAutoresizingMaskIntoConstraints = false
        let internalView = ZoneAnnotationView(frame: .zero)
        addSubview(internalView)
        internalView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        internalView.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        self.annotationView = internalView
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        centerOffset = CGVector(dx: bounds.width / 2, dy: -bounds.height / 2)
    }
}

class ZoneAnnotationView: UIView {

    private weak var bubbleView: BubbleView?
    private weak var label: UILabel?

    private static let textPadding: CGFloat = 10

    var bubbleColor: UIColor = .green {
        didSet {
            bubbleView?.color = bubbleColor
        }
    }

    var text: String = "" {
        didSet {
            label?.text = text
            bubbleView?.setNeedsDisplay()
        }
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    func setupView() {

        translatesAutoresizingMaskIntoConstraints = false
        addBubble()
        addLabel()
    }

    private func addBubble() {

        let bubbleView = BubbleView()
        bubbleView.isOpaque = false
        self.bubbleView = bubbleView
        bubbleView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(bubbleView)
        bubbleView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        bubbleView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
    }

    private func addLabel() {

        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        self.label = label
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        label.topAnchor.constraint(equalTo: self.topAnchor, constant: ZoneAnnotationView.textPadding).isActive = true
        label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: ZoneAnnotationView.textPadding).isActive = true
        label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -ZoneAnnotationView.textPadding).isActive = true
        label.bottomAnchor.constraint(equalTo: self.bottomAnchor,
                                      constant: -ZoneAnnotationView.textPadding - BubbleView.triangleHeight).isActive = true
        label.text = text
    }
}
