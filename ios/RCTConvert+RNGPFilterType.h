#import "RCTConvert.h"
#import <GoogleMaps/GoogleMaps.h>

typedef NS_ENUM(NSInteger, RNGPFilterType) {
    kGMSPlacesAutocompleteTypeFilterNoFilter,
    kGMSPlacesAutocompleteTypeFilterGeocode,
    kGMSPlacesAutocompleteTypeFilterAddress,
    kGMSPlacesAutocompleteTypeFilterEstablishment,
    kGMSPlacesAutocompleteTypeFilterRegion,
    kGMSPlacesAutocompleteTypeFilterCity,
};

@interface RCTConvert (RNGPFilterType)

@end
