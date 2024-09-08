import Vision
import VisionKit

@objc(DataScannerViewController)
public class ScanControllerWrapper : NSObject, DataScannerViewControllerDelegate
{
    private var viewController: DataScannerViewController
    private var scannerCallback: ((_ codes: [String]) -> Void)? = nil
    private var scannerUpdateCallback: ((_ codes: [String]) -> Void)? = nil

    @objc
    @MainActor override init()
    {
        let supportedBarcodes = VNDetectBarcodesRequest.init().symbologies
        let viewController = DataScannerViewController.init(recognizedDataTypes:[.barcode(symbologies:supportedBarcodes)])
        self.viewController = viewController

        super.init()

        self.viewController.delegate = self
    }

    @objc
    public func getViewController() -> UIViewController
    {
        return self.viewController
    }

    private func handleBarcodeCallback(barcodes: [RecognizedItem], callback: ((_ codes: [String]) -> Void)?)
    {
        if(callback != nil)
        {
            let scannedBarcodes: [String] = barcodes.map
            { (item) -> String in
                switch(item)
                {
                case .barcode(let barcode):
                        return barcode.payloadStringValue ?? "<barcode not read>"
                    default:
                        return "<not a barcode>"
                }
            }
            callback!(scannedBarcodes)
        }
    }

    public func dataScanner(_ dataScanner: DataScannerViewController, didAdd addedItems: [RecognizedItem], allItems: [RecognizedItem])
    {
        handleBarcodeCallback(barcodes: addedItems, callback: self.scannerCallback)
    }

    public func dataScanner(_ dataScanner: DataScannerViewController, didUpdate updatedItems: [RecognizedItem], allItems: [RecognizedItem])
    {
        handleBarcodeCallback(barcodes: updatedItems, callback: self.scannerUpdateCallback)
    }

    @objc
    @MainActor public func setScanCallback(callback: @escaping ([String]) -> Void)
    {
        self.scannerCallback = callback
    }

    @objc
    @MainActor public func setScanUpdatedCallback(callback: @escaping ([String]) -> Void)
    {
        self.scannerUpdateCallback = callback
    }

    @objc
    @MainActor public func startScan()
    {
        try? // NOTE: hides errors
        self.viewController.startScanning()
    }

    @objc
    @MainActor public func stopScan()
    {
        self.viewController.stopScanning()
    }
}
