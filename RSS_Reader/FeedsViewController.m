//
//  NewsListViewController.m
//  RSSReader
//  Created by Sh2dow on 31.10.12.
//  Copyright (c) 2012 Sh2dow. All rights reserved.
//


#import "FeedsViewController.h"
#import "RSSListViewController.h"


@implementation FeedsViewController

- (id)initWithNewsSourceList:(NSMutableArray * )list {
    self = [super initWithNibName:@"FeedsViewController" bundle:nil];
    if (self) {
        self->_newsSourceList = list;
    }
    return self;
}

- (void)dealloc{
    self->_newsSourceList = nil;
    
    [super dealloc];
}

#pragma mark - View lifecycle

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    // Return the number of rows in the section.
    return [_newsSourceList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    NSDictionary * newsSourceItem = (NSDictionary *)[_newsSourceList objectAtIndex:indexPath.row];
    [cell.textLabel setText:[newsSourceItem objectForKey:@"BlogTitle"]];
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary * newsSourceItem = (NSDictionary *)[_newsSourceList objectAtIndex:indexPath.row];
    RSSListViewController * rssListViewController = [[RSSListViewController alloc] initWithRSSURL:[newsSourceItem objectForKey:@"BlogURL"]];
    [rssListViewController setTitle:[newsSourceItem objectForKey:@"BlogTitle"]];
    
    [self.navigationController pushViewController:rssListViewController animated:YES];
    [rssListViewController release];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.title = @"List of sites";
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    UIBarButtonItem* addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertFeed)];
    self.navigationItem.leftBarButtonItem = addButton;
    [addButton release];
}

-(void)insertFeed
{
    UIAlertView *dialog = [[UIAlertView alloc] initWithTitle:@"Adding sites: " message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Add", nil];
    
    dialog.message = @"Insert URL of feed";
    dialog.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
    
    UITextField *feedTitle = [dialog textFieldAtIndex:0];
    UITextField *feedURL = [dialog textFieldAtIndex:1];
    
    feedTitle.placeholder =  @"Enter Title";
    feedTitle.returnKeyType = UIReturnKeyDone;
    feedTitle.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    feedURL.text = @"http://";
    feedURL.placeholder = @"Enter feed's URL";
    feedURL.keyboardType = UIKeyboardTypeURL;
    feedURL.returnKeyType = UIReturnKeyDone;
    feedURL.secureTextEntry = NO;
    
	[dialog show];
    [dialog release];
}

- (BOOL)alertViewShouldEnableFirstOtherButton:(UIAlertView *)alertView {
    UITextField *feedTitle = [alertView textFieldAtIndex:0];
    UITextField *feedURL = [alertView textFieldAtIndex:1];
    
    if ([feedURL.text length] <= 0 || [feedTitle.text length] <= 0)
    {
        return NO;
    }
    return YES;
}

- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(buttonIndex == 1)
    {
        NSMutableDictionary *tempFeed = [[NSMutableDictionary alloc] init];
        NSMutableArray *tempRoot = [[NSMutableArray alloc] init];
        [tempFeed setValue:[actionSheet textFieldAtIndex:0].text forKey:@"BlogTitle"];
        [tempFeed setValue:[actionSheet textFieldAtIndex:1].text forKey:@"BlogURL"];
        [tempRoot addObject:tempFeed];
        
        [_newsSourceList addObjectsFromArray:tempRoot];
        
        NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *plistPath = [rootPath stringByAppendingPathComponent:@"data.plist"];
        NSMutableArray *plist = [NSMutableArray arrayWithContentsOfFile:plistPath];
        if (plist == nil) plist = [NSMutableArray array];
        [plist addObject:tempFeed];
        
        [_newsSourceList writeToFile:plistPath atomically:YES]; 
        [self.tableView reloadData];
    }
}

// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}

// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    NSObject *feed =[[_newsSourceList objectAtIndex:fromIndexPath.row] retain];
    [_newsSourceList removeObjectAtIndex:fromIndexPath.row];
    [_newsSourceList insertObject:feed atIndex:toIndexPath.row];
    [feed release];

    [self SavePlist];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_newsSourceList removeObjectAtIndex:indexPath.row];
       [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    
    [self SavePlist];
    }
}

- (void) SavePlist
{
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *plistPath = [rootPath stringByAppendingPathComponent:@"data.plist"];
    [_newsSourceList writeToFile:plistPath atomically:YES];
}

@end
