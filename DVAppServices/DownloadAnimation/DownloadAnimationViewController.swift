//
//  DownloadAnimationViewController.swift
//  DVAppServices
//
//  Created by Nam Vu on 12/12/17.
//  Copyright © 2017 Nam DV. All rights reserved.
//

import UIKit

class DownloadAnimationViewController: BaseViewController {
    
    fileprivate let shapeLayer = CAShapeLayer()
    fileprivate let urlString = "https://firebasestorage.googleapis.com/v0/b/firestorechat-e64ac.appspot.com/o/intermediate_training_rec.mp4?alt=media&token=e20261d0-7219-49d2-b32d-367e1606500c"
    
    let percentageLabel: UILabel = {
        let label = UILabel()
        label.text = "Start"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 32)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //add percentage label
        percentageLabel.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        percentageLabel.center = view.center
        view.addSubview(percentageLabel)
        
        //drawing a circle
        let circularPath = UIBezierPath(arcCenter: .zero, radius: 100, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        
        //draw track layer
        let trackLayer = CAShapeLayer()
        trackLayer.path = circularPath.cgPath
        trackLayer.strokeColor = UIColor.lightGray.cgColor
        trackLayer.lineWidth = 10
        trackLayer.lineCap = kCALineCapRound
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.position = view.center
        view.layer.addSublayer(trackLayer)
        
        //drawing a layer
        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.lineWidth = 10
        shapeLayer.strokeEnd = 0
        shapeLayer.lineCap = kCALineCapRound
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.position = view.center
        shapeLayer.transform = CATransform3DMakeRotation(-CGFloat.pi / 2, 0, 0, 1)
        view.layer.addSublayer(shapeLayer)
        
        //add tap gesture
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    
    fileprivate func beginDownloadingFile() {
        
        shapeLayer.strokeEnd = 0
        
        let configuration = URLSessionConfiguration.default
        let operationQueue = OperationQueue()
        let urlSession = URLSession(configuration: configuration, delegate: self, delegateQueue: operationQueue)
        
        guard let url = URL(string: urlString) else { return }
        let downloadTask = urlSession.downloadTask(with: url)
        downloadTask.resume()
    }
    
    fileprivate func animateCircle() {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.toValue = 1
        animation.duration = 2
        animation.fillMode = kCAFillModeForwards
        animation.isRemovedOnCompletion = false
        
        shapeLayer.add(animation, forKey: "basic")
    }
    
    @objc fileprivate func handleTap() {
        beginDownloadingFile()
    }
}

extension DownloadAnimationViewController : URLSessionDownloadDelegate {
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        let percentage = CGFloat(totalBytesWritten) / CGFloat(totalBytesExpectedToWrite)
        
        DispatchQueue.main.async {
            self.percentageLabel.text = "\(Int(percentage * 100))%"
            self.shapeLayer.strokeEnd = percentage
        }
    }
}
