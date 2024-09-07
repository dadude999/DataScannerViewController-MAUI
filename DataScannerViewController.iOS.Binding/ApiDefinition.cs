using System;
using Foundation;
using UIKit;

namespace DataScannerViewControlleriOS
{
	// @interface DataScannerViewController : NSObject
	[BaseType (typeof(NSObject))]
	interface DataScannerViewController
	{
		// -(UIViewController * _Nonnull)getViewController __attribute__((warn_unused_result("")));
		[Export ("getViewController")]
		UIViewController ViewController { get; }

		// -(void)setScanCallbackWithCallback:(void (^ _Nonnull)(NSArray<NSString *> * _Nonnull))callback;
		[Export ("setScanCallbackWithCallback:")]
		void SetScanCallbackWithCallback (Action<string []> callback);

		// -(void)startScan;
		[Export ("startScan")]
		void StartScan ();

		// -(void)stopScan;
		[Export ("stopScan")]
		void StopScan ();
	}
}
