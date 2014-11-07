//
//  AlixPayResult.h
//  MSPInterface
//
//  Created by WenBi on 11-5-20.
//  Copyright 2011 Alipay. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface AlixPayResult : NSObject {
	int		  _statusCode;
	NSString *_statusMessage;
	NSString *_resultString;
	NSString *_signString;
	NSString *_signType;
}

@property(nonatomic, readonly) int statusCode;
@property(nonatomic, readonly) NSString *statusMessage;
@property(nonatomic, readonly) NSString *resultString;
@property(nonatomic, readonly) NSString *signString;
@property(nonatomic, readonly) NSString *signType;

- (id)initWithString:(NSString *)string;
@end
