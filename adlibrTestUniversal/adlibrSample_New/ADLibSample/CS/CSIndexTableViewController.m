//
//  CSIndexTableViewController.m
//  ADLibSample
//
//  Created by gskang on 2017. 3. 29..
//
//

#import "CSIndexTableViewController.h"

#define kLastIdx 3

@interface CSIndexTableViewController ()

@property (nonatomic, strong) NSMutableArray *indexList;

@end

@implementation CSIndexTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _indexList = [[NSMutableArray alloc] init];
    
    int lastIdx = kLastIdx;
    
    NSString *idxnum = nil;
    
    for (int i = 1 ; i <= lastIdx; i ++) {
        idxnum = [NSString stringWithFormat:@"CS%03d", i];
        [_indexList addObject:idxnum];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _indexList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CSIndexTableCell" forIndexPath:indexPath];
    
    cell.textLabel.text = [_indexList objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    @try {
        NSString *nibName = [_indexList objectAtIndex:indexPath.row];
        
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"CSStoryboard" bundle:nil];
        UIViewController *ctr = [sb instantiateViewControllerWithIdentifier:nibName];
        ctr.title = nibName;
        
        [self.navigationController pushViewController:ctr animated:YES];
        
    } @catch (NSException *exception) {
        NSLog(@"exception : %@", exception);
    }
}

@end
