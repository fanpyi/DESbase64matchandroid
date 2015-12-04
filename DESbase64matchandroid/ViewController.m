//
//  ViewController.m
//  DESbase64matchandroid
//
//  Created by fanpyi on 4/12/15.
//  Copyright © 2015 fanpyi. All rights reserved.
//

#import "ViewController.h"
#import "DESCrypt.h"
static NSString *const TestDESKey = @"8fd3f08ce8cbc2eb";
@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib
    NSString *source = @"Write the Code Change the World $#$～！@＋—＃@＃％……&";
    NSString *encrypt = [DESCrypt encryptDESSource:source key:TestDESKey];
    NSString *descrypt = [DESCrypt decryptDESSource:encrypt key:TestDESKey];
    NSLog(@"encrypt = %@",encrypt);
    NSLog(@"descrypt = %@",descrypt);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
