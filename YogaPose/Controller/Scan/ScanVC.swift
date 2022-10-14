//
//  ScanVC.swift
//  YogaPose
//
//  Created by iMac-00017 on 04/10/22.
//

import UIKit
import AVFoundation
import PassioPlatformSDK

class ScanVC: UIViewController {

    @IBOutlet weak var btnCancelScanning: UIButton!
    @IBOutlet weak var labelDetected: UILabel!
    @IBOutlet weak var scanFrameImgVw: UIImageView!
    @IBOutlet weak var scanningLabel: UILabel!
    //MARK: - Outlets -
    @IBOutlet weak var viewYogaDescription: UIView!
    @IBOutlet weak var lblAsanaName: UILabel!
    @IBOutlet weak var txtViewDescription: UITextView!
    @IBOutlet weak var btnKnowMore: UIButton!
    @IBOutlet weak var btnClose: UIButton!
    
    private var scanningAnimationlayer = CAGradientLayer()
    private var isScanningAnimationRunning = true
    
    let passioSDK = PassioPlatformAISDK.shared
    var videoLayer: AVCaptureVideoPreviewLayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var passioConfig = PassioConfiguration(key: key)
        passioConfig.projectID = projectID
        passioSDK.configure(passioConfiguration: passioConfig) { status in
            print( "SDK status = \(status)")
        }
        passioSDK.statusDelegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.view.alpha = 1
        labelDetected.text = "Configuring SDK"
        self.navigationController?.navigationBar.isHidden = true
        if AVCaptureDevice.authorizationStatus(for: .video) == .authorized { // already authorized
            setupVideoLayer()
        } else {
            AVCaptureDevice.requestAccess(for: .video) { (granted) in
                if granted { // access to video granted
                    DispatchQueue.main.async {
                        self.setupVideoLayer()
                    }
                } else {
                    print("The user didn't grant access to use camera")
                }
            }
        }
    }
    func setupVideoLayer() {
        guard videoLayer == nil else { return }
        if let vLayer = passioSDK.getPreviewLayer() {
            self.videoLayer = vLayer
            videoLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
            videoLayer?.frame = view.frame
            view.layer.insertSublayer(vLayer, at: 0)
        }
        showScanningAnimation()
        if passioSDK.status.mode == .isReadyForDetection {
            startDetection()
        }
    }

    func startDetection() {
        passioSDK.startDetection(detectionDelegate: self) { isReady in
            print("startCustomObjectDetection started \(isReady)" )
        }
    }

    func stopDetection() {
        passioSDK.stopDetection()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        passioSDK.stopDetection()
        videoLayer?.removeFromSuperlayer()
        videoLayer = nil
        self.navigationController?.navigationBar.isHidden = false
    }
    
    @IBAction func btnCancelScanningTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension ScanVC:ClosePopUpDelegate{
    func onCloseTapped() {
        showScanningAnimation()
        self.view.alpha = 1
        self.labelDetected.text = "Scanning"
        self.startDetection()
    }
}

extension ScanVC: DetectionDelegate {

    func detectionResult(candidates: [DetectionCandidate]?,
                         image: UIImage?) {
        DispatchQueue.main.async {
            self.labelDetected.text = "Scanning"
            if let first = candidates?.first {
                print("confidence = \(first.confidence)")
                if first.confidence > 0.8 {
                    self.displayCandidate(candidate: first)
                }
            }
        }
    }

    func displayCandidate(candidate: DetectionCandidate) {
        removeScanningAnimation()
        self.labelDetected.text = candidate.label?.capitalized ?? candidate.passioID + " " + "\(candidate.confidence)"
        DispatchQueue.main.async {
            self.resultView(candidate: candidate)
        }
    }
    func resultView(candidate: DetectionCandidate?) {
        passioSDK.stopDetection()
        self.view.alpha = 0.5
        let vc = storyboard?.instantiateViewController(withIdentifier: "YogaPoseDetailsVC") as! YogaPoseDetailsVC
        vc.delegate = self
        vc.passioId = candidate?.passioID ?? ""
        let navController = UINavigationController(rootViewController: vc)
        navController.modalPresentationStyle = .overFullScreen
        self.present(navController, animated: true, completion: nil)
    }

}

extension ScanVC: PassioStatusDelegate {

    func passioStatusChanged(status: PassioStatus) {
        if status.mode == .isReadyForDetection {
            DispatchQueue.main.async {
                self.startDetection()
            }
        }
    }

    func passioProcessing(filesLeft: Int) {
    }

    func completedDownloadingAllFiles(filesLocalURLs: [FileLocalURL]) {
    }

    func completedDownloadingFile(fileLocalURL: FileLocalURL, filesLeft: Int) {
    }

    func downloadingError(message: String) {
    }

}


//MARK: - Scanning Animation
extension ScanVC {
    private func showScanningAnimation() {

        scanningAnimationlayer.colors = [UIColor.green.cgColor,
                                         UIColor.green.withAlphaComponent(0).cgColor]
        scanningAnimationlayer.opacity = 0.4
        scanningAnimationlayer.frame = CGRect(x: 0,
                                              y: 0,
                                              width: scanFrameImgVw.frame.width,
                                              height: scanFrameImgVw.frame.height / 4)

        let containerViewHeight = scanFrameImgVw.frame.height
        let scanningFrameHeight = scanningAnimationlayer.frame.height
        let value = containerViewHeight - scanningFrameHeight

        let initialYPosition = scanningAnimationlayer.position.y
        let finalYPosition = initialYPosition + value
        let duration: CFTimeInterval = 1

        scanFrameImgVw.layer.insertSublayer(scanningAnimationlayer, at: 0)

        let animation = CABasicAnimation(keyPath: "position.y")
        animation.fromValue = initialYPosition
        animation.toValue = finalYPosition
        animation.duration = duration
        animation.repeatCount = .infinity
        animation.autoreverses = true
        animation.isRemovedOnCompletion = false

        scanningAnimationlayer.add(animation, forKey: nil)
    }

    private func removeScanningAnimation() {

        scanningAnimationlayer.removeAllAnimations()
        scanningAnimationlayer.removeFromSuperlayer()
    }
}
