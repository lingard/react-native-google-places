#import "RCTConvert.h"
#import <GoogleMaps/GoogleMaps.h>

typedef NS_ENUM(NSInteger, kGMSPlacesAutocompleteTypeFilter) {
    kGMSPlacesAutocompleteTypeFilterNoFilter,
    kGMSPlacesAutocompleteTypeFilterGeocode,
    kGMSPlacesAutocompleteTypeFilterAddress,
    kGMSPlacesAutocompleteTypeFilterEstablishment,
    kGMSPlacesAutocompleteTypeFilterRegion,
    kGMSPlacesAutocompleteTypeFilterCity,
};

@interface RCTConvert (kGMSPlacesAutocompleteTypeFilter)

@end
