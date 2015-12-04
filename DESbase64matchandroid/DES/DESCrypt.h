//
//  DESCrypt.h
//  DESbase64matchandroid
//
//  Created by fanpyi on 4/12/15.
//  Copyright © 2015 fanpyi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DESCrypt : NSObject

+(NSData *)dataEncryptDESSource:(NSString *)source key:(NSString *)key;

+(NSData *)dataDecryptDESSource:(NSString *)source key:(NSString *)key;

+(NSString *)encryptDESSource:(NSString *)source key:(NSString *)key;

+(NSString *)decryptDESSource:(NSString *)source key:(NSString *)key;

@end
