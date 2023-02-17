//
//  RecognizedTextDataSource.swift
//  Cookie-Health
//
//  
//

import UIKit
import Vision

protocol RecognizedTextDataSoure: AnyObject {
    func addRecognizedText(recogniedText: [VNRecognizedTextObservation])
}
