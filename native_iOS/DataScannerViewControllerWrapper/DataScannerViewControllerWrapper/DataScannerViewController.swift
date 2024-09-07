import Vision
import VisionKit

@objc(DataScannerViewController)
public class ScanControllerWrapper : NSObject, DataScannerViewControllerDelegate
{
    private var viewController: DataScannerViewController
    private var scannerCallback: ((_ codes: [String]) -> Void)? = nil

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
        return self.viewController;
    }

    public func dataScanner(_ dataScanner: DataScannerViewController, didAdd addedItems: [RecognizedItem], allItems: [RecognizedItem])
    {
        if(self.scannerCallback != nil)
        {
            let scannedBarcodes: [String] = addedItems.map
            { (item) -> String in
                switch(item)
                {
                case .barcode(let barcode):
                        return barcode.payloadStringValue ?? "<barcode not read>"
                    default:
                        return "<not a barcode>"
                }
            };
            self.scannerCallback!(scannedBarcodes)
        }
    }

    @objc
    @MainActor public func setScanCallback(callback: @escaping ([String]) -> Void)
    {
        self.scannerCallback = callback
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
