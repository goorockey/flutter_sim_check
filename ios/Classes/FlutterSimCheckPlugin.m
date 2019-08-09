#import "FlutterSimCheckPlugin.h"

@implementation FlutterSimCheckPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"flutter_sim_check"
            binaryMessenger:[registrar messenger]];
  FlutterSimCheckPlugin* instance = [[FlutterSimCheckPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"check_sim_exist" isEqualToString:call.method]) {
    [self getSimCountryCode:result];
  } else if ([@"check_is_simulator" isEqualToString:call.method]) {
    result(@(NO));
  } else {
    result(FlutterMethodNotImplemented);
  }
}

- (void)getSimCountryCode:(FlutterResult)result {
    CTCarrier *carrier = [[CTTelephonyNetworkInfo new] subscriberCellularProvider];
    if (carrier != nil) {
        NSString *countryCode = carrier.isoCountryCode;
        if (countryCode != nil) {
            result(@(YES));
            return;
        }
    }
    result(@(NO));
}

@end
