//
//  HttpRequest.h
//  PhotoGallery
//
//  Created by cuelogic on 01/09/15.
//  Copyright (c) 2015 Cuelogic Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HttpConnectionDelegate <NSObject>

@required
- (void)didHttpConnectionFailWithError:(NSError*)error;
- (void)didHttpConnectionSuccessWithData:(NSData*)data;

@end

@interface HttpRequest : NSObject<NSURLConnectionDelegate, NSURLConnectionDataDelegate>
{
    NSMutableData *_responseData;//save response data
    
}
@property(nonatomic, assign) id <HttpConnectionDelegate>delegate;

- (instancetype)initWithStringURL:(NSString*)strURL withDelegate:(id)delegate;

@end
