//
//  ViewController.m
//  PNCPDFTable
//
//  Created by 二哈 on 16/8/9.
//  Copyright © 2016年 侯森魁. All rights reserved.
//

#import "ViewController.h"

#import "PDFRenderer.h"

@interface ViewController ()

@property (nonatomic,strong)UIWebView *webView;

@property (nonatomic,copy)NSString *loadPath ;
@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Info.plist" ofType:nil];
    
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
    
    NSString *openCardJSON = [dict  objectForKey:@"OP"];
    
    NSString *PR = [dict  objectForKey:@"PR"];

    
    
    
    NSLog(@"openCardJSON =  %@",openCardJSON);
    
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSString *pathPDF =  [documentPath stringByAppendingPathComponent:@"开卡.pdf"];
    
    UIGraphicsBeginPDFContextToFile(pathPDF, CGRectZero, NULL);
    
    NSLog(@"pathPDF  =%@",pathPDF);
    
    self.loadPath =pathPDF ;
    
    UIGraphicsBeginPDFPageWithInfo(CGRectMake(0, 0, 1240, 1754), nil);

    [PDFRenderer openBankCard:[self JSONObject:openCardJSON] last:[self JSONObject:PR ]];
    
    
    
    UIGraphicsEndPDFContext();
    
    [self initWebView];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)initWebView{
    
    self.webView  =[[UIWebView alloc]initWithFrame:self.view.bounds];
    
    [self.view addSubview:self.webView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear: animated];
    
    NSURL *url  =[NSURL fileURLWithPath:self.loadPath];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    
}

- (id)JSONObject:(NSString *)string
{
    NSError* error = nil;
    id object = [NSJSONSerialization JSONObjectWithData:[string dataUsingEncoding:NSUTF8StringEncoding]
                                                options:NSJSONReadingMutableContainers
                                                  error:&error];
    
    if (error != nil) {
        NSLog(@"NSString JSONObject error: %@", [error localizedDescription]);
    }
    
    return object;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
