//
//  FLNativeView.swift
//  Runner
//
//  Created by 朱晓枫 on 2023/12/22.
//

import Flutter
import UIKit

class FLNativeView: NSObject, FlutterPlatformView {
    private var _view: UIView
    
    init(
        frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?,
        binaryMessenger messenger: FlutterBinaryMessenger?
    ) {
        _view = UIView()
        super.init()
        // iOS views can be created here
        createNativeView(view: _view)
    }
    
    func view() -> UIView {
        return _view
    }
    
    func createNativeView(view _view: UIView){
        _view.backgroundColor = UIColor.systemYellow
        
        let nativeLabel = UILabel()
        nativeLabel.text = "iOS UIView.UILabel"
        nativeLabel.textColor = UIColor.white
        nativeLabel.backgroundColor = UIColor.systemBlue
        nativeLabel.textAlignment = .center
        nativeLabel.numberOfLines = 0
        nativeLabel.frame = CGRect(x: 32, y: 32, width: 180, height: 64)
        _view.addSubview(nativeLabel)
        
        func updateNativeView(timer: Timer){
            let currentDate = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm:ss.SSS"
            nativeLabel.text = "iOS UIView.UILabel" + "\n" + formatter.string(from: currentDate)
        }
        Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: updateNativeView)
    }
}
