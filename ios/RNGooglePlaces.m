
#import "RNGooglePlaces.h"
#import "RCTBridge.h"
#import "RNGooglePlacesViewController.h"
#import "RCTConvert+RNGPFilterType.h"
#import "RCTRootView.h"
#import "RCTLog.h"

#import <GooglePlaces/GooglePlaces.h>

@implementation RNGooglePlaces

RCT_EXPORT_MODULE()

- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}

RCT_REMAP_METHOD(autoCompleteQuery,
                 queryString: (NSString *)query
                 filterType: (kGMSPlacesAutocompleteTypeFilter)filter
                 resolver: (RCTPromiseResolveBlock)resolve
                 rejecter: (RCTPromiseRejectBlock)reject)
{
    GMSAutocompleteFilter *autocompleteFilter = [[GMSAutocompleteFilter alloc] init];
    autocompleteFilter.type = type;

    [[GMSPlacesClient sharedClient] autocompleteQuery:query
                                               bounds:nil
                                               filter:autocompleteFilter
                                               callback:^(NSArray *results, NSError *error) {
        if (error != nil) {
          reject(@"E_AUTOCOMPLETE_ERROR", [error description], nil);
          return;
        }

        resolve(results);
    }];
}

RCT_EXPORT_METHOD(openAutocompleteModal: (RCTPromiseResolveBlock)resolve
                  rejecter: (RCTPromiseRejectBlock)reject)
{
	@try {
		RNGooglePlacesViewController* a = [[RNGooglePlacesViewController alloc] init];
		[a openAutocompleteModal: resolve rejecter: reject];
	}
	@catch (NSException * e) {
    reject(@"E_OPEN_FAILED", @"Could not open modal", [self errorFromException:e]);
  }
}

- (NSError *) errorFromException: (NSException *) exception
{
    NSDictionary *exceptionInfo = @{
        @"name": exception.name,
        @"reason": exception.reason,
        @"callStackReturnAddresses": exception.callStackReturnAddresses,
        @"callStackSymbols": exception.callStackSymbols,
        @"userInfo": exception.userInfo
    };

    return [[NSError alloc] initWithDomain: @"RNGooglePlaces"
                                      code: 0
                                  userInfo: exceptionInfo];
}


@end


