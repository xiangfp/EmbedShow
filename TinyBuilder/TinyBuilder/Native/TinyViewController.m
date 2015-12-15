//
//  TinyViewController.m
//  Breeze2.1.1
//
//  Created by xiangfp on 15/4/10.
//
//

#import "TinyViewController.h"
#import "UIColorAdditions.h"
#import "Request.h"
#import "NSStringAdditions.h"
#import "Reachability.h"
#import "Configuration.h"
#import "AppDelegate.h"

@implementation TinyViewController

- (id)init
{
    if (self = [super init]) {
        self.view.backgroundColor = [UIColor colorWithHex:@"#4075be"];

        AppDelegate *appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        self.tinyView = [[TinyView alloc] init];
        self.tinyView.delegate = self;
        [self.tinyView setWindow:appdelegate.window];
        [self.view addSubview:self.tinyView];
        appdelegate.tinyView = self.tinyView;
        
        
        /**
         *  注册插件
         */
        [self.tinyView registerEmbedClassMapping];
        
        self.tinyView.frame = self.view.bounds;
    }
    
    return self;
}





-(void)viewDidAppear:(BOOL)animated
{
    NSLog(@"viewDidAppear===============");

}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (id)initWithTinyViewFrame:(CGRect)frame
{
    if (self = [self init]) {
        self.tinyView.frame = frame;
    }
    
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark  TinyViewDelegate


-(BOOL)tinyView:(TinyView*)tinyView requestPage:(Request *)request
{
    return YES;
}

-(BOOL)tinyView:(TinyView*)tinyView popToContext:(NSString *)pageID
{
    [self.navigationController popViewControllerAnimated:YES];
    
    
    return NO;
}

-(BOOL)tinyView:(TinyView*)tinyView pushContext:(DocumentContext *)context
{
      return NO;
    
}


-(void)tinyView:(TinyView *)tinyView openUrl:(NSString *)url width:(float)width height:(float)height
{
    
}



- (void)tinyView:(TinyView *)tinyView target:(NSString *)target
{
    [self.delegate tinyViewController:self didSelectTarget:target];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
@end


@implementation TinyViewController(UIViewControllerConnect)

- (void)connect
{
    NSString *str = [[[Configuration configuration] stationList] objectAtIndex:0];
    NSMutableString *uri = [NSMutableString stringWithString:str];
    NSString *escaped = [uri stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    Request *request = [Request requestWithURIString:escaped relativeToURL:nil delegate:nil];
    request.method = RequestMethodPost;
    
    request.priority = QueuePriorityPageResource;
    UIImage *splash;
    
    if ([UIScreen mainScreen].bounds.size.height==568) {
        splash = [UIImage imageNamed:@"Default-568h.png"];
    }
    else
    {
        splash = [UIImage imageNamed:@"Default.png"];
    }

    
    self.tinyView.backgroundColor = [UIColor clearColor];
//    self.view.backgroundColor = [UIColor colorWithPatternImage:splash];

    [self.tinyView openWindowUnLockWithRequest:request];
}


- (void)connectURL:(NSString *)urlString tinyView:(TinyView *)tinyView
{
    NSMutableString *uri = [NSMutableString stringWithString:urlString];
    NSString *escaped = [uri stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    Request *request = [Request requestWithURIString:escaped relativeToURL:nil delegate:nil];
    request.method = RequestMethodPost;
    
    request.priority = QueuePriorityPageResource;
    [tinyView openWindowWithRequest:request];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        return UIInterfaceOrientationIsLandscape(interfaceOrientation);
    }
    else{
        return (interfaceOrientation == UIInterfaceOrientationPortrait);
    }
}

-(BOOL)shouldAutorotate
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        return YES;
    }
    else{
        return NO;
    }
}

-(NSUInteger)supportedInterfaceOrientations
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        return UIInterfaceOrientationMaskLandscape;
    }
    else{
        return UIInterfaceOrientationMaskPortrait;
    }
    
    
}


@end



@implementation TinyViewController(UIViewControllerTabBar)

/* 设置tabar的问题和图片，已经页面头部文字
 * @param barName 底部bar名字
 * @param title 页面title
 * @param imageName 图片
 */
-(void)setTabBarName:(NSString *)barName title:(NSString*)title imageName:(NSString*)imageName imageName_F:(NSString *)imageName_F
{
    [self.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                             [UIColor colorWithHex:@"#3300aa" andAlpha:1], NSForegroundColorAttributeName,
                                             [UIFont boldSystemFontOfSize:14.0f], NSFontAttributeName, nil] forState:UIControlStateNormal];
    UIImage *image = [UIImage imageNamed:imageName];
    UIImage *imageFocus = [UIImage imageNamed:imageName_F];

    [self.tabBarItem setImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [self.tabBarItem setSelectedImage:[imageFocus imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];

    
    self.tabBarItem.imageInsets=UIEdgeInsetsMake(5.5, 0,-5.5, 0);
    [self.tabBarItem setTitle:barName];
    
    
}


@end
