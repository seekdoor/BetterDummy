//
//  BetterDummy
//
//  Created by @waydabber
//

import Cocoa
import CoreGraphics

class PipViewController: NSViewController {
  var stream: CGDisplayStream?
  var displayId: CGDirectDisplayID?
  var width = 960 // This is just some default
  var height = 540 // This is just some default
  var outputWidth = 1920 // This is just some default
  var outputHeight = 1080 // This is just some default

  override func loadView() {
    view = NSView(frame: NSRect(origin: .zero, size: CGSize(width: self.width, height: self.height)))
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    if let displayId = self.displayId {
      self.stream = CGDisplayStream(
        dispatchQueueDisplay: displayId,
        outputWidth: self.outputWidth,
        outputHeight: self.outputHeight,
        pixelFormat: 1_111_970_369, // BGRA
        properties: nil,
        queue: .main,
        handler: { [weak self] _, _, frameSurface, _ in
          if let surface = frameSurface {
            self?.view.layer?.contents = surface
          }
        }
      )
      _ = self.stream?.start()
    }
  }
}
