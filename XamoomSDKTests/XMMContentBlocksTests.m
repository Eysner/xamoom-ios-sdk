//
//  XMMContentBlocksTests.m
//  XamoomSDK
//
//  Created by Raphael Seher on 03/02/16.
//  Copyright © 2016 xamoom GmbH. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import "XMMEnduserApi.h"
#import "XMMContentBlocks.h"
#import "XMMMusicPlayer.h"

@interface XMMContentBlocksTests : XCTestCase

@property id mockedApi;
@property id mockedTableView;
@property XMMContentBlocks *contentBlocks;
@property XMMStyle *style;

@end

@implementation XMMContentBlocksTests

- (void)setUp {
  [super setUp];
  self.mockedApi = OCMClassMock([XMMEnduserApi class]);
  self.mockedTableView = OCMClassMock([UITableView class]);

  self.style = [[XMMStyle alloc] init];
  self.style.foregroundFontColor = @"#222222";
  self.style.highlightFontColor = @"#0000FF";
  self.style.backgroundColor = @"#FFFFFF";
  
  UITableView *tableView = [[UITableView alloc] init];
  self.contentBlocks = [[XMMContentBlocks alloc] initWithTableView:tableView api:self.mockedApi];
  self.contentBlocks.style = self.style;
}

- (void)tearDown {
  // Put teardown code here. This method is called after the invocation of each test method in the class.
  [super tearDown];
}

- (void)testContentBlockInitWithTableView {
  XMMContentBlocks *contentBlocks = [[XMMContentBlocks alloc] initWithTableView:self.mockedTableView api:self.mockedApi];
  
  XCTAssertNotNil(contentBlocks);
  XCTAssertNotNil(contentBlocks.api);
  XCTAssertNotNil(contentBlocks.tableView);
}

- (void)testDisplayContentSetsItems {
  XMMContentBlocks *contentBlocks = [[XMMContentBlocks alloc] initWithTableView:self.mockedTableView api:self.mockedApi];
  
  [contentBlocks displayContent:[self xamoomStaticContent]];

  XCTAssertTrue(contentBlocks.items.count == 2);
}

- (void)testDisplayContentSetsItemsWithoutHeader {
  XMMContentBlocks *contentBlocks = [[XMMContentBlocks alloc] initWithTableView:self.mockedTableView api:self.mockedApi];
  
  [contentBlocks displayContent:[self xamoomStaticContent] addHeader:YES];
  
  XCTAssertTrue(contentBlocks.items.count == 2);
}

- (void)testDisplayContentSetsItemsWithHeader {
  XMMContentBlocks *contentBlocks = [[XMMContentBlocks alloc] initWithTableView:self.mockedTableView api:self.mockedApi];
  
  [contentBlocks displayContent:[self xamoomStaticContent] addHeader:NO];
  
  XCTAssertTrue(contentBlocks.items.count == 1);
}

- (void)testkContentBlock9MapContentLinkNotification {
  XCTAssertTrue([[XMMContentBlocks kContentBlock9MapContentLinkNotification] isEqualToString:@"com.xamoom.ios.kContentBlock9MapContentLinkNotification"]);
}

- (void)testThatUpdateFontSizeUpdatesValue {
  XMMContentBlocks *contentBlocks = [[XMMContentBlocks alloc] initWithTableView:self.mockedTableView api:self.mockedApi];

  [contentBlocks updateFontSizeTo:BigFontSize];
  
  XCTAssertTrue([XMMContentBlock0TableViewCell fontSize] == BigFontSize);
}

- (void)testThatItemsCountIsSet {
  XMMContentBlocks *contentBlocks = [[XMMContentBlocks alloc] initWithTableView:self.mockedTableView api:self.mockedApi];
  
  [contentBlocks displayContent:[self xamoomStaticContent]];
  
  XCTAssertTrue([contentBlocks tableView:self.mockedTableView numberOfRowsInSection:0] == 2);
}

- (void)testThatCellForRowAtIndexPathReturnsBlankCell {
  UITableView *tableView = [[UITableView alloc] init];
  XMMContentBlocks *contentBlocks = [[XMMContentBlocks alloc] initWithTableView:tableView api:self.mockedApi];
  
  [contentBlocks displayContent:[self xamoomContentWithFalseContentBlock]];
  
  NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
  
  XMMContentBlock0TableViewCell *cell = (XMMContentBlock0TableViewCell *)[contentBlocks tableView:tableView cellForRowAtIndexPath:indexPath];
  
  XCTAssertNotNil(cell);
}

- (void)testThatSetStyleSetsColor {
  UITableView *tableView = [[UITableView alloc] init];
  XMMContentBlocks *contentBlocks = [[XMMContentBlocks alloc] initWithTableView:tableView api:self.mockedApi];
  
  XMMStyle *style = [[XMMStyle alloc] init];
  style.backgroundColor = @"#000000";
  
  contentBlocks.style = style;
  
  XCTAssertTrue([contentBlocks.style.backgroundColor isEqualToString:@"#000000"]);
  XCTAssertEqual(contentBlocks.style, style);
}

- (void)testThatClickContentNotificationCallsDelegate {
  NSString *contentID = @"12314";
  UITableView *tableView = [[UITableView alloc] init];
  XMMContentBlocks *contentBlocks = [[XMMContentBlocks alloc] initWithTableView:tableView api:self.mockedApi];
  id delegateMock = OCMProtocolMock(@protocol(XMMContentBlocksDelegate));
  contentBlocks.delegate = delegateMock;
  [contentBlocks viewWillAppear];
  
  OCMExpect([delegateMock didClickContentBlock:[OCMArg isEqual:contentID]]);
  
  NSDictionary *userInfo = @{@"contentID":contentID};
  [[NSNotificationCenter defaultCenter]
   postNotificationName:XMMContentBlocks.kContentBlock9MapContentLinkNotification
   object:self userInfo:userInfo];
  
  OCMVerifyAll(delegateMock);
}

- (void)testAutomaticDimension {
  UITableView *tableView = [[UITableView alloc] init];
  XMMContentBlocks *contentBlocks = [[XMMContentBlocks alloc] initWithTableView:tableView api:self.mockedApi];
  NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];

  CGFloat height = [contentBlocks tableView:tableView heightForRowAtIndexPath:indexPath];
  
  XCTAssertEqual(height, UITableViewAutomaticDimension);
}


- (void)testThatCellForRowAtIndexPathReturnsContentBlock0Cell {
  [self.contentBlocks displayContent:[self xamoomStaticContent]];
  
  NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
  XMMContentBlock0TableViewCell *cell = (XMMContentBlock0TableViewCell *)[self.contentBlocks tableView:self.contentBlocks.tableView cellForRowAtIndexPath:indexPath];
  
  indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
  XMMContentBlock0TableViewCell *headerCell = (XMMContentBlock0TableViewCell *)[self.contentBlocks tableView:self.contentBlocks.tableView cellForRowAtIndexPath:indexPath];
  
  XCTAssertTrue([cell.titleLabel.text isEqualToString:@"Block Title"]);
  XCTAssertTrue([headerCell.titleLabel.text isEqualToString:@"Content Title"]);
}

- (void)testThatCellForRowAtIndexPathReturnsContentBlock6Cell {
  [self.contentBlocks displayContent:[self xamoomStaticContentType6]];
  
  NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
  
  XMMContentBlock6TableViewCell *cell = (XMMContentBlock6TableViewCell *)[self.contentBlocks tableView:self.contentBlocks.tableView cellForRowAtIndexPath:indexPath];
  
  XCTAssertTrue([cell.contentID isEqualToString:@"123456"]);
}

- (void)testThatDidSelectContentBlock2CallsOpenVideo {
  NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
  UITableView *tableView = OCMClassMock([UITableView class]);
  XMMContentBlocks *contentBlocks = [[XMMContentBlocks alloc] initWithTableView:tableView api:self.mockedApi];
  
  XMMContentBlock* contentBlock = [[XMMContentBlock alloc] init];
  contentBlock.videoUrl = @"www.xamoom.com/video.mp4";
  contentBlock.blockType = 2;
  XMMContent *content = [[XMMContent alloc] init];
  content.contentBlocks = [NSArray arrayWithObject:contentBlock];
  [contentBlocks displayContent:content];
  [contentBlocks.tableView reloadData];
  
  id cell = OCMClassMock([XMMContentBlock2TableViewCell class]);
  OCMStub([contentBlocks.tableView cellForRowAtIndexPath:[OCMArg any]]).andReturn(cell);
  
  OCMExpect([cell openVideo]);
  
  [contentBlocks tableView:contentBlocks.tableView didSelectRowAtIndexPath:indexPath];
  
  OCMVerify(cell);
}

- (void)testThatDidSelectContentBlock3CallsOpenLink {
  NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
  UITableView *tableView = OCMClassMock([UITableView class]);
  XMMContentBlocks *contentBlocks = [[XMMContentBlocks alloc] initWithTableView:tableView api:self.mockedApi];
  
  XMMContentBlock* contentBlock = [[XMMContentBlock alloc] init];
  contentBlock.linkUrl = @"www.xamoom.com/video.mp4";
  contentBlock.blockType = 3;
  XMMContent *content = [[XMMContent alloc] init];
  content.contentBlocks = [NSArray arrayWithObject:contentBlock];
  [contentBlocks displayContent:content];
  [contentBlocks.tableView reloadData];
  
  id cell = OCMClassMock([XMMContentBlock3TableViewCell class]);
  OCMStub([contentBlocks.tableView cellForRowAtIndexPath:[OCMArg any]]).andReturn(cell);
  
  OCMExpect([cell openLink]);
  
  [contentBlocks tableView:contentBlocks.tableView didSelectRowAtIndexPath:indexPath];
  
  OCMVerify(cell);
}

- (void)testThatDidSelectContentBlock4CallsOpenLink {
  NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
  UITableView *tableView = OCMClassMock([UITableView class]);
  XMMContentBlocks *contentBlocks = [[XMMContentBlocks alloc] initWithTableView:tableView api:self.mockedApi];
  
  XMMContentBlock* contentBlock = [[XMMContentBlock alloc] init];
  contentBlock.linkUrl = @"www.xamoom.com/video.mp4";
  contentBlock.blockType = 3;
  XMMContent *content = [[XMMContent alloc] init];
  content.contentBlocks = [NSArray arrayWithObject:contentBlock];
  [contentBlocks displayContent:content];
  [contentBlocks.tableView reloadData];
  
  id cell = OCMClassMock([XMMContentBlock4TableViewCell class]);
  OCMStub([contentBlocks.tableView cellForRowAtIndexPath:[OCMArg any]]).andReturn(cell);
  
  OCMExpect([cell openLink]);
  
  [contentBlocks tableView:contentBlocks.tableView didSelectRowAtIndexPath:indexPath];
  
  OCMVerify(cell);
}

- (void)testThatDidSelectContentBlock8CallsOpenLink {
  NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
  UITableView *tableView = OCMClassMock([UITableView class]);
  XMMContentBlocks *contentBlocks = [[XMMContentBlocks alloc] initWithTableView:tableView api:self.mockedApi];
  
  XMMContentBlock* contentBlock = [[XMMContentBlock alloc] init];
  contentBlock.linkUrl = @"www.xamoom.com/video.mp4";
  contentBlock.blockType = 3;
  XMMContent *content = [[XMMContent alloc] init];
  content.contentBlocks = [NSArray arrayWithObject:contentBlock];
  [contentBlocks displayContent:content];
  [contentBlocks.tableView reloadData];
  
  id cell = OCMClassMock([XMMContentBlock8TableViewCell class]);
  OCMStub([contentBlocks.tableView cellForRowAtIndexPath:[OCMArg any]]).andReturn(cell);
  
  OCMExpect([cell openLink]);
  
  [contentBlocks tableView:contentBlocks.tableView didSelectRowAtIndexPath:indexPath];
  
  OCMVerify(cell);
}

- (void)skip_testThatDidSelectContentBlock6CallsDelegate {
  NSString *contentID = @"123456";
  NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];

  [self.contentBlocks displayContent:[self xamoomStaticContentType6]];
  
  id delegateMock = OCMProtocolMock(@protocol(XMMContentBlocksDelegate));
  self.contentBlocks.delegate = delegateMock;
  
  [self.contentBlocks.tableView reloadData];
  
  OCMExpect([delegateMock didClickContentBlock:[OCMArg isEqual:contentID]]);
  
  [self.contentBlocks tableView:self.contentBlocks.tableView didSelectRowAtIndexPath:indexPath];
  
  OCMVerifyAll(delegateMock);
}

- (void)testRemoveStoreLinksFromBlocks {
  XMMContentBlock *block1 = [[XMMContentBlock alloc] init];
  block1.blockType = 4;
  block1.linkType = 17;
  
  XMMContentBlock *block2 = [[XMMContentBlock alloc] init];
  block2.blockType = 4;
  block2.linkType = 16;
  
  NSArray *blocks = @[block1, block2];
  
  XMMContent *content = [[XMMContent alloc] init];
  content.contentBlocks= blocks;
  
  [self.contentBlocks displayContent:content addHeader:NO];
  
  NSArray *newBlocks = self.contentBlocks.items;
  
  XCTAssertEqual(newBlocks.count, 0);
}

- (void)testRemoveNonOfflineBlocks {
  XMMContentBlock *block1 = [[XMMContentBlock alloc] init];
  block1.blockType = 7;
  
  XMMContentBlock *block2 = [[XMMContentBlock alloc] init];
  block2.blockType = 2;
  block2.videoUrl = @"https://www.youtube.com/watch?v=vrPzsP2gl4M";
  
  XMMContentBlock *block3 = [[XMMContentBlock alloc] init];
  block3.blockType = 2;
  block3.videoUrl = @"https://vimeo.com/187372244";
  
  XMMContentBlock *block4 = [[XMMContentBlock alloc] init];
  block4.blockType = 9;
  
  NSArray *blocks = @[block1, block2, block3, block4];
  
  XMMContent *content = [[XMMContent alloc] init];
  content.contentBlocks= blocks;
  
  self.contentBlocks.offline = YES;
  [self.contentBlocks displayContent:content addHeader:NO];
  
  NSArray *newBlocks = self.contentBlocks.items;
  
  XCTAssertEqual(newBlocks.count, 0);
}

#pragma mark - Helpers

- (XMMContent *)xamoomStaticContent {
  XMMContent *content = [[XMMContent alloc] init];
  
  content.title = @"Content Title";
  content.contentDescription = @"Some content description";
  content.language = @"de";
  
  XMMContentBlock *block1 = [[XMMContentBlock alloc] init];
  block1.title = @"Block Title";
  block1.text = @"";
  block1.publicStatus = YES;
  block1.blockType = 0;
  
  content.contentBlocks = [[NSArray alloc] initWithObjects:block1, nil];
  
  return content;
}

- (XMMContent *)xamoomStaticContentType6 {
  XMMContent *content = [[XMMContent alloc] init];
  
  content.title = @"Content Title";
  content.contentDescription = @"Some content description";
  content.language = @"de";
  
  XMMContentBlock *block1 = [[XMMContentBlock alloc] init];
  block1.title = @"Block Title";
  block1.publicStatus = YES;
  block1.blockType = 6;
  block1.contentID = @"123456";
  
  content.contentBlocks = [[NSArray alloc] initWithObjects:block1, nil];
  
  return content;
}

- (XMMContent *)xamoomContentWithFalseContentBlock {
  XMMContent *content = [[XMMContent alloc] init];
  
  content.title = @"Content Title";
  content.contentDescription = @"Some content description";
  content.language = @"de";
  
  XMMContentBlock *block1 = [[XMMContentBlock alloc] init];
  block1.title = @"Block Title";
  block1.text = @"";
  block1.publicStatus = YES;
  block1.blockType = 10;
  
  content.contentBlocks = [[NSArray alloc] initWithObjects:block1, nil];
  
  return content;
}
@end
