#import <Foundation/Foundation.h>

@class URLSessionInjector;

@protocol URLSessionInjectorDelegate

- (void)urlSessionInjector:(URLSessionInjector*)injector didStart:(NSURLSessionDataTask*)dataTask;

- (void)urlSessionInjector:(URLSessionInjector*)injector didReceiveResponse:(NSURLSessionDataTask*)dataTask response:(NSURLResponse*)response;

- (void)urlSessionInjector:(URLSessionInjector*)injector didReceiveData:(NSURLSessionDataTask*)dataTask data:(NSData*)data;

- (void)urlSessionInjector:(URLSessionInjector*)injector didFinishWithError:(NSURLSessionDataTask*)dataTask error:(NSError*)error;

@end

@interface URLSessionInjector : NSObject

@property (nonatomic, weak) id<URLSessionInjectorDelegate> delegate;

- (instancetype)initWithDelegate:(id<URLSessionInjectorDelegate>)delegate;

- (void)inject;

@end
