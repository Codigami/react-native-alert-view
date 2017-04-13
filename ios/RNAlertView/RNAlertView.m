//
//  RNAlertView.m
//  RNAlertView
//
//  Created by Karan Thakkar on 12/04/17.
//  Copyright © 2017 Crowdfire Inc. All rights reserved.
//

#import "RNAlertView.h"
#import <React/RCTConvert.h>

@import CFAlertViewController;

@implementation RNAlertView

// This RCT (React) "macro" exposes the current module to JavaScript
RCT_EXPORT_MODULE();

// We must explicitly expose methods otherwise JavaScript can't access anything
RCT_EXPORT_METHOD(show:(NSDictionary *)options callback:(RCTResponseSenderBlock)callback)
{
    
    NSString *title = [RCTConvert NSString:options[@"title"]];
    NSString *message = [RCTConvert NSString:options[@"message"]];
    
    // Handle different alert view styles
    NSString *preferredStyleFromBridge = [RCTConvert NSString:options[@"preferredStyle"]];
    CFAlertControllerStyle preferredStyle = CFAlertControllerStyleAlert;
    if ([preferredStyleFromBridge isEqualToString:@"actionSheet"]) {
        preferredStyle = CFAlertControllerStyleActionSheet;
    }
    
    // Handle textAlignment
    NSString *textAlignmentFromBridge = [RCTConvert NSString:options[@"textAlignment"]];
    NSTextAlignment textAlignment = NSTextAlignmentLeft;
    if ([textAlignmentFromBridge isEqualToString:@"right"]) {
        textAlignment = NSTextAlignmentRight;
    } else if ([textAlignmentFromBridge isEqualToString:@"center"]) {
        textAlignment = NSTextAlignmentCenter;
    } else if ([textAlignmentFromBridge isEqualToString:@"justified"]) {
        textAlignment = NSTextAlignmentJustified;
    }
    
    NSArray<NSDictionary *> *buttons = [RCTConvert NSDictionaryArray:options[@"buttons"]];
    
    // Show Confirmation Alert
    CFAlertViewController *actionSheet = [CFAlertViewController alertControllerWithTitle:title
                                                                                 message:message
                                                                           textAlignment:textAlignment
                                                                          preferredStyle:preferredStyle
                                                                  didDismissAlertHandler:nil];
    
    NSInteger index = 0;
    for (NSDictionary *button in buttons) {
        
        // Button text
        NSString *buttonTitle = button[@"title"];
        
        // Handle different button width styles
        CFAlertActionStyle buttonStyle = CFAlertActionStyleDefault;
        if ([button[@"style"] isEqualToString:@"destructive"]) {
            buttonStyle = CFAlertActionStyleDestructive;
        } else if ([button[@"style"] isEqualToString:@"cancel"]) {
            buttonStyle = CFAlertActionStyleCancel;
        }
        
        // Handle different alignment types
        CFAlertActionAlignment buttonAlignment = CFAlertActionAlignmentJustified;
        if ([button[@"alignment"] isEqualToString:@"left"]) {
            buttonAlignment = CFAlertActionAlignmentLeft;
        } else if ([button[@"alignment"] isEqualToString:@"right"]) {
            buttonAlignment = CFAlertActionAlignmentRight;
        } else if ([button[@"alignment"] isEqualToString:@"center"]) {
            buttonAlignment = CFAlertActionAlignmentCenter;
        }
        
        // Button UI styles
        UIColor *backgroundColor = [RCTConvert UIColor:button[@"backgroundColor"]];
        UIColor *textColor = [RCTConvert UIColor:button[@"textColor"]];
        
        // Build action object
        NSInteger localIndex = index;
        CFAlertAction *action = [CFAlertAction actionWithTitle:buttonTitle
                                                         style:buttonStyle
                                                     alignment:buttonAlignment
                                               backgroundColor:backgroundColor
                                                     textColor:textColor
                                                       handler:^(CFAlertAction *action) {
                                                           callback(@[@(localIndex)]);
                                                       }];
        index++;
        [actionSheet addAction:action];
    }
    
    UIViewController *rootViewController = [self topViewControllerWithRootViewController:[[[UIApplication sharedApplication] delegate] window].rootViewController];

    dispatch_async(dispatch_get_main_queue(), ^{
        [rootViewController presentViewController:actionSheet animated:YES completion:nil];
    });
}

- (UIViewController *)topViewControllerWithRootViewController:(UIViewController*)rootViewController {
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController* tabBarController = (UITabBarController*)rootViewController;
        return [self topViewControllerWithRootViewController:tabBarController.selectedViewController];
    } else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController* navigationController = (UINavigationController*)rootViewController;
        return [self topViewControllerWithRootViewController:navigationController.visibleViewController];
    } else if (rootViewController.presentedViewController) {
        UIViewController* presentedViewController = rootViewController.presentedViewController;
        return [self topViewControllerWithRootViewController:presentedViewController];
    } else {
        return rootViewController;
    }
}

@end
