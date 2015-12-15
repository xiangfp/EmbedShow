//
//  TBControllerManager.m
//  Breeze2.1.1
//
//  Created by xiangfp on 15/4/11.
//
//

#import "TinyControllerManger.h"
#import "TinyViewController.h"
#import "TinyTabViewController.h"
#import "DocumentContext.h"
#import "Request.h"

@implementation TinyControllerManger

#pragma TinyViewDelegate

-(BOOL)tinyView:(TinyView*)tinyView requestPage:(Request *)request
{
    //    TinyViewController *viewController = [[TinyViewController alloc] init];
    //    [viewController.webView openWindowWithRequest:request];
    //    [self.navigationController pushViewController:viewController animated:YES];
    
    return YES;
}

-(BOOL)tinyView:(TinyView*)tinyView popToContext:(NSString *)pageID
{
    [self.delegate tbControllerManager:self popViewControllerAnimated:YES];
//    [self.navigationController popViewControllerAnimated:YES];
    return NO;
}

-(BOOL)tinyView:(TinyView*)tinyView pushContext:(DocumentContext *)context
{
    if([context.uri.relativeString isEqualToString:@"T_WDZA.hsml"]) {
        TinyTabViewController *tabViewController = [[TinyTabViewController alloc]init];
        tabViewController.viewController1.tinyView.frame = tinyView.frame;
        [tabViewController.viewController1.tinyView openWindowWithContext:context];
        
        Request *request2 = [Request requestWithURIString:@"T_SJYHDL_MENU.hsml" relativeToURL:context.uri delegate:nil];
        tabViewController.viewController2.tinyView.frame = tinyView.frame;
        [tabViewController.viewController2.tinyView openWindowWithRequest:request2];
        
        
        Request *request3 = [Request requestWithURIString:@"T_JRZS.hsml" relativeToURL:context.uri delegate:nil];
        tabViewController.viewController3.tinyView.frame = tinyView.frame;
        [tabViewController.viewController3.tinyView openWindowWithRequest:request3];
        
        
        Request *request4 = [Request requestWithURIString:@"T_SHZS.hsml" relativeToURL:context.uri delegate:nil];
        tabViewController.viewController4.tinyView.frame = tinyView.frame;
        [tabViewController.viewController4.tinyView openWindowWithRequest:request4];
        
        
        [self.delegate tbControllerManager:self pushViewController:tabViewController];
        
    } else {
        TinyViewController *viewController = [[TinyViewController alloc] initWithTinyViewFrame:tinyView.frame];
        [viewController.tinyView openWindowWithContext:context];
       
        [self.delegate tbControllerManager:self pushViewController:viewController];
    }
    return NO;
}


@end
