//
//  SPServiceConnection.m
//  spara
//
//  Created by Adex on 09/08/2013.
//  Copyright (c) 2013 Spara Inc. All rights reserved.
//

#import "SPServiceConnection.h"
#import "SPAddresses.h"


@interface SPServiceConnection (){
    
    NSMutableData * _dataContainer;
    NSURLConnection * _internalConnection;
}

@property (strong, nonatomic) NSURLRequest * request;
@property (strong, nonatomic) void (^completionHandler)(SPAddresses * addresses, NSError * error);
@property (strong, nonatomic) SPAddresses * addresses;

-(void)startConnection;

@end

static NSMutableArray * _connectionHolder = nil;
@implementation SPServiceConnection
#pragma mark -
#pragma mark - Class Properties
@synthesize request = _request;
@synthesize completionHandler = _completionHandler;
@synthesize addresses = _addresses;
@synthesize isConnecting = _isConnecting;





#pragma mark -
#pragma mark - Customed Methods

-(id)initWithRequest:(NSURLRequest *)request{
    
    self = [super init];
    
    if (self) {
       
        self.request = request;
        self.addresses = [[SPAddresses alloc] init];
        self.isConnecting = NO;
    }
    
    return self;
}

-(void)startConnection{
    
    _dataContainer = [[NSMutableData alloc] init];
    _internalConnection = [[NSURLConnection alloc] initWithRequest:self.request delegate:self startImmediately:YES];
    [_internalConnection start];
    self.isConnecting = YES;
    
    if (!_connectionHolder) {
        
        _connectionHolder = [NSMutableArray array];
    }
    
    [_connectionHolder addObject:self];
}

-(void)cancelConnection{
    
    [_internalConnection cancel];
}

-(void)connectionWithCompletionHandler:(void (^)(SPAddresses *, NSError *))block{
    
    self.completionHandler = block;
    [self startConnection];
}






#pragma mark - 
#pragma mark - NSURLConnection Delegate Methods


-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    
    [_dataContainer appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
    if (self.addresses)
    {
     	
        NSError *error = nil;
        NSDictionary * dictionary = [NSJSONSerialization JSONObjectWithData:_dataContainer options:0 error:&error];
        
        if (error) {
            
            // Treat the error here
        }else{
           
            [self.addresses performAddressOperation:dictionary];
        }
     	
    }
    
    if (self.completionHandler)
    {
     	self.completionHandler (self.addresses, nil);
    }
    
    [_connectionHolder removeObject:self];
}


- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    
	if (self.completionHandler)
	{
		self.completionHandler (nil, error);
	}
    
	[_connectionHolder removeObject:self];
}

@end
