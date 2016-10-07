//
//  WXAutoDictionary.m
//  WXDynamicMethodResolution
//
//  Created by 吴浠 on 2016/10/7.
//  Copyright © 2016年 吴浠. All rights reserved.
//

#import "WXAutoDictionary.h"
#import <objc/runtime.h>

@interface WXAutoDictionary ()

@property (nonatomic, strong)NSMutableDictionary *backingStore;

@end

@implementation WXAutoDictionary
@dynamic string, date, number, anyObject;

- (instancetype)init
{
    if (self = [super init])
    {
        _backingStore = [NSMutableDictionary new];
    }
    return self;
}

void autoDictionarySetter(id self, SEL _cmd, id value);
id autoDictionaryGetter(id self, SEL _cmd);

+ (BOOL)resolveInstanceMethod:(SEL)sel
{
    NSString *selectorString = NSStringFromSelector(sel);
    if ([selectorString hasPrefix:@"set"])
    {
        class_addMethod(self, sel, (IMP)autoDictionarySetter, "v@:@");
        
    }else
    {
        class_addMethod(self, sel, (IMP)autoDictionaryGetter, "@@:");
    }
    return YES;
}
//getter方法
id autoDictionaryGetter(id self, SEL _cmd)
{
    
    WXAutoDictionary *typedSelf = (WXAutoDictionary *)self;
    NSMutableDictionary *backingDictionary = typedSelf.backingStore;
    //方法名是key
    NSString *key = NSStringFromSelector(_cmd);
    
    return [backingDictionary objectForKey:key];
    
}
//setter方法
void autoDictionarySetter(id self, SEL _cmd, id value)
{
    WXAutoDictionary *typedSelf = (WXAutoDictionary *)self;
    NSMutableDictionary *backingDictionary = typedSelf.backingStore;
    //方法名是key
    NSString *selectorString = NSStringFromSelector(_cmd);
    NSMutableString *key = [selectorString mutableCopy];
    
    //去除:
    [key deleteCharactersInRange:NSMakeRange(key.length - 1, 1)];
    //去除set
    [key deleteCharactersInRange:NSMakeRange(0, 3)];
    //首字母小写
    NSString *firstCharacterLowerCase = [[key substringToIndex:1] lowercaseString];
    [key replaceCharactersInRange:NSMakeRange(0, 1) withString:firstCharacterLowerCase];
    
    if (value)
    {
        [backingDictionary setValue:value forKey:key];
    }else
    {
        [backingDictionary removeObjectForKey:key];
    }
}
@end
