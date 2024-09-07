# DataScannerViewController-MAUI
.NET MAUI binding for iOS DataScannerViewController class

This project is a wrapper around the DataScannerViewController Swift class from VisionKit. The wrapping is accompished using the MAUI community toolkit [helpers for native interop](https://learn.microsoft.com/en-us/dotnet/communitytoolkit/maui/native-library-interop/).

This code is published on nuget.org as a NuGet package called `DataScannerViewController.Ios.Maui`.

Because this package is strictly for iOS, you will be required to conditionally include it (insert the following into your .csproj, where `<version>` represents your desired version: `<PackageReference Include="DataScannerViewController.Ios.Maui" Version="<version>" Condition="'$(TargetFramework)' == 'net8.0-ios'" />`).

Please note: due to [this issue](https://github.com/dotnet/maui/issues/17828#issuecomment-1897879300), you will need to enable long path support as described [here](https://learn.microsoft.com/en-us/windows/win32/fileio/maximum-file-path-limitation?tabs=registry#registry-setting-to-enable-long-paths) and then install the NuGet using `dotnet add package` as documented [here](https://learn.microsoft.com/en-us/dotnet/core/tools/dotnet-add-package). Upon building, you may encounter error `MSB3030`. If this happens, you must build from the command line (e.g. `dotnet build -c Debug`).