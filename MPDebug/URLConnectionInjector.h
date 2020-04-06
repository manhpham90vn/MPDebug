#import <Foundation/Foundation.h>

@class URLConnectionInjector;

@protocol URLConnectionInjectorDelegate

- (void)urlConnectionInjector:(URLConnectionInjector*)injector didReceiveResponse:(NSURLConnection*)urlConnection response:(NSURLResponse*)response;

- (void)urlConnectionInjector:(URLConnectionInjector*)injector didReceiveData:(NSURLConnection*)urlConnection data:(NSData*)data;

- (void)urlConnectionInjector:(URLConnectionInjector*)injector didFailWithError:(NSURLConnection*)urlConnection error:(NSError*)error;

- (void)urlConnectionInjector:(URLConnectionInjector*)injector didFinishLoading:(NSURLConnection*)urlConnection;

@end

@interface URLConnectionInjector : NSObject

@property (nonatomic, weak) id<URLConnectionInjectorDelegate> delegate;

- (instancetype)initWithDelegate:(id<URLConnectionInjectorDelegate>)delegate;

- (void)inject;

@end
