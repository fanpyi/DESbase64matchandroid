//
//  DESCrypt.m
//  DESbase64matchandroid
//
//  Created by fanpyi on 4/12/15.
//  Copyright © 2015 fanpyi. All rights reserved.
//

#import "DESCrypt.h"
#import <CommonCrypto/CommonCryptor.h>
#import "GTMBase64.h"
@implementation DESCrypt
+(NSData *)cryptDESOperation:(CCOperation)operation source:(NSString *)source key:(NSString *)key{
    if (!source || !key) {
        return nil;
    }
    NSData *data = nil;
    if (operation == kCCEncrypt) {
        data = [source dataUsingEncoding:NSUTF8StringEncoding];
    }else{
        NSData *d = [source dataUsingEncoding:NSUTF8StringEncoding];
        data = [GTMBase64 decodeData:d];
    }
    //让malloc的size是kCCBlockSizeDES的整数倍
    size_t dataOutAvailable = (data.length + kCCBlockSizeDES) & ~(kCCBlockSizeDES - 1);
    uint8_t *dataOut = malloc( dataOutAvailable * sizeof(uint8_t));
    size_t dataOutMoved = 0;
    memset(dataOut,0, dataOutAvailable);
    const void *vkey = (const void *) [key UTF8String];
    CCCryptorStatus status = CCCrypt(operation,
                                     kCCAlgorithmDES,
    //ios用kCCOptionECBMode | kCCOptionPKCS7Padding相当于android使用 DES/ECB/PKCS5Padding，才能保证两端统一
                                     kCCOptionECBMode | kCCOptionPKCS7Padding ,
                                     vkey,
                                     kCCKeySizeDES,
                                     NULL,
                                     [data bytes],
                                     data.length,
                                     (void *)dataOut,
                                     dataOutAvailable,
                                     &dataOutMoved);
    if (status != kCCSuccess) {
        free(dataOut);
        return nil;
    }
    NSData *result = nil;
    if (operation == kCCEncrypt) {
        
        result = [NSData dataWithBytes:dataOut length:dataOutMoved];
        free(dataOut);
        return [GTMBase64 encodeData:result];
    } else {
       result = [NSData dataWithBytes:dataOut length:dataOutMoved];
        free(dataOut);
        return result;
    }
}
+(NSData *)dataEncryptDESSource:(NSString *)source key:(NSString *)key{
    return [DESCrypt cryptDESOperation:kCCEncrypt source:source key:key];
}

+(NSData *)dataDecryptDESSource:(NSString *)source key:(NSString *)key{
    return [DESCrypt cryptDESOperation:kCCDecrypt source:source key:key];
}

+(NSString *)encryptDESSource:(NSString *)source key:(NSString *)key{
    NSData *d = [DESCrypt dataEncryptDESSource:source key:key];
    return d ? [[NSString alloc]initWithData:d encoding:NSUTF8StringEncoding] : @"";
}

+(NSString *)decryptDESSource:(NSString *)source key:(NSString *)key{
    NSData *d = [DESCrypt dataDecryptDESSource:source key:key];
    return d ? [[NSString alloc]initWithData:d encoding:NSUTF8StringEncoding] : @"";
}
@end
