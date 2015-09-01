//
//  HttpRequest.m
//  PhotoGallery
//
//  Created by cuelogic on 01/09/15.
//  Copyright (c) 2015 Cuelogic Technologies. All rights reserved.
//

#import "HttpRequest.h"

@implementation HttpRequest

- (instancetype)initWithStringURL:(NSString*)strURL withDelegate:(id)delegate
{
    self = [super init];
    if (self) {
        self.delegate = delegate;//for call back
        
        NSURL *jsonURL = [NSURL URLWithString:strURL];
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:jsonURL];
        
        NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        [connection start];
        
    }
    return self;
}



#pragma mark- Connection
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didHttpConnectionFailWithError:)]) {
        [self.delegate didHttpConnectionFailWithError:error];
    }
}
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    // NSLog(@"didReceiveRes = %@",response);
    _responseData = [[NSMutableData alloc] init];
    
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    //NSLog(@"data = %@",data);
    [_responseData appendData:data];
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    // NSLog(@"connection finish loading");
    
    NSString *responseString = [[NSString alloc] initWithData:_responseData encoding:NSUTF8StringEncoding];
    NSData *jsonData = [responseString dataUsingEncoding:NSUTF8StringEncoding];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didHttpConnectionFailWithError:)]) {
        [self.delegate didHttpConnectionSuccessWithData:jsonData];
    }
}


















@end
