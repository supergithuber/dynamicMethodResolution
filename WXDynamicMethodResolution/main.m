//
//  main.m
//  WXDynamicMethodResolution
//
//  Created by 吴浠 on 2016/10/7.
//  Copyright © 2016年 吴浠. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXAutoDictionary.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        
        WXAutoDictionary *wxDictionary = [WXAutoDictionary new];
        wxDictionary.date = [NSDate date];
        NSLog(@"%@", wxDictionary.date);
        
    }
    return 0;
}
