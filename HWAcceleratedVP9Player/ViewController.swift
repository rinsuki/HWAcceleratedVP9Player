//
//  ViewController.swift
//  HWAcceleratedVP9Player
//
//  Created by user on 2020/08/05.
//

import Cocoa
import VideoToolbox
import AVKit

class ViewController: NSViewController {
    let playerView = AVPlayerView()
    
    override func loadView() {
        playerView.controlsStyle = .floating
        view = playerView
        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(greaterThanOrEqualToConstant: 100),
            view.heightAnchor.constraint(greaterThanOrEqualToConstant: 100),
        ])
    }

    override func viewDidAppear() {
        let kCMVideoCodecType_VP9: FourCharCode = 0x76703039 /* vp09 */
        // Enable VP9 Hardware Decoder
        VTRegisterSupplementalVideoDecoderIfAvailable(kCMVideoCodecType_VP9)
        // check this machine have a VP9 Hardware Decoder
        if VTIsHardwareDecodeSupported(kCMVideoCodecType_VP9) {
            openVideoPanel()
        } else {
            let alert = NSAlert()
            alert.alertStyle = .warning
            alert.messageText = "This Mac doesn't have a VP9 Hardware Decoder"
            alert.informativeText = "VP9 videos may not be playable."
            alert.beginSheetModal(for: self.view.window!) { _ in
                self.openVideoPanel()
            }
        }
    }
    
    func openVideoPanel() {
        let openPanel = NSOpenPanel()
        openPanel.beginSheetModal(for: self.view.window!) { res in
            guard let url = openPanel.url else {
                return
            }
            self.setVideo(url: url)
        }
    }
    
    func setVideo(url: URL) {
        let asset = AVAsset(url: url)
        if let videoTrack = asset.tracks(withMediaType: .video).first {
            let size = videoTrack.naturalSize
            NSLayoutConstraint.activate([
                view.widthAnchor.constraint(equalTo: view.heightAnchor, multiplier: size.width / size.height)
            ])
            var isVP9 = false
            let formats = videoTrack.formatDescriptions as! [CMFormatDescription]
            for formatDesc in formats {
                let type = CMFormatDescriptionGetMediaType(formatDesc)
                guard type == kCMMediaType_Video else { continue }
                let format = CMFormatDescriptionGetMediaSubType(formatDesc)
                guard format == kCMVideoCodecType_VP9 else { continue }
                isVP9 = true
            }
            if !isVP9 {
                let alert = NSAlert()
                alert.alertStyle = .warning
                alert.messageText = "This video file seems doesn't including VP9 stream"
                alert.informativeText = "Did you select the wrong file?\n(anyway we trying to play)"
                alert.beginSheetModal(for: self.view.window!)
            }
        }
        self.playerView.player = AVPlayer(url: url)
    }
}
