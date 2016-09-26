
#import "RNGooglePlaces.h"
#import "RCTBridge.h"
#import "RNGooglePlacesViewController.h"
#import "RCTConvert+RNGPAutocompleteTypeFilter.h"
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
                 filterType: (GMSPlacesAutocompleteTypeFilter)filter
                 resolver: (RCTPromiseResolveBlock)resolve
                 rejecter: (RCTPromiseRejectBlock)reject)
{
    NSMutableArray *autoCompleteSuggestionsList = [NSMutableArray array];
    GMSAutocompleteFilter *autocompleteFilter = [[GMSAutocompleteFilter alloc] init];
    autocompleteFilter.type = filter;

    [[GMSPlacesClient sharedClient] autocompleteQuery:query
                                               bounds:nil
                                               filter:autocompleteFilter
                                               callback:^(NSArray *results, NSError *error) {
        if (error != nil) {
          reject(@"E_AUTOCOMPLETE_ERROR", [error description], nil);
          return;
        }

        for (GMSAutocompletePrediction* result in results) {
            NSMutableDictionary *placeData =[[NSMutableDictionary alloc] init];

            placeData[@"attributedFullText"] = result.attributedFullText.string;
            placeData[@"attributedPrimaryText"] = result.attributedPrimaryText.string;
            placeData[@"attributedSecondaryText"] = result.attributedSecondaryText.string;
            placeData[@"placeID"] = result.placeID;
            placeData[@"type"] = result.types;

            [autoCompleteSuggestionsList addObject:placeData];
        }

        resolve(autoCompleteSuggestionsList);
    }];
}

RCT_REMAP_METHOD(lookUpPlaceID,
                 placeID: (NSString*)placeID
                 resolver: (RCTPromiseResolveBlock)resolve
                 rejecter: (RCTPromiseRejectBlock)reject)
{
    [[GMSPlacesClient sharedClient] lookUpPlaceID:placeID
                                         callback:^(GMSPlace *place, NSError *error) {
        if (error != nil) {
            reject(@"E_PLACE_DETAILS_ERROR", [error localizedDescription], nil);
            return;
        }

        if (place != nil) {
            NSMutableDictionary *placeData =[[NSMutableDictionary alloc] init];
            placeData[@"name"] = place.name;
            placeData[@"address"] = place.formattedAddress;
            placeData[@"attributions"] = place.attributions.string;
            placeData[@"latitude"] = [NSNumber numberWithDouble:place.coordinate.latitude];
            placeData[@"longitude"] = [NSNumber numberWithDouble:place.coordinate.longitude];
            placeData[@"phoneNumber"] = place.phoneNumber;
            placeData[@"website"] = place.website.absoluteString;
            placeData[@"placeID"] = place.placeID;

            resolve(placeData);
        } else {
            resolve(@{})
        }
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


