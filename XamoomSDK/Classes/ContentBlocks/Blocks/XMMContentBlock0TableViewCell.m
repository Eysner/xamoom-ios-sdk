//
// Copyright 2015 by xamoom GmbH <apps@xamoom.com>
//
// This file is part of some open source application.
//
// Some open source application is free software: you can redistribute
// it and/or modify it under the terms of the GNU General Public
// License as published by the Free Software Foundation, either
// version 2 of the License, or (at your option) any later version.
//
// Some open source application is distributed in the hope that it will
// be useful, but WITHOUT ANY WARRANTY; without even the implied warranty
// of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with xamoom-ios-sdk. If not, see <http://www.gnu.org/licenses/>.
//

#import "XMMContentBlock0TableViewCell.h"

@implementation XMMContentBlock0TableViewCell

static int contentFontSize;
static UIColor *contentLinkColor;

- (void)awakeFromNib {
  // Initialization code
  self.titleLabel.text = @"";
  self.contentTextView.text = @"";
}

+ (int)fontSize {
  return contentFontSize;
}

+ (void)setFontSize:(int)fontSize {
  contentFontSize = fontSize;
}

+ (UIColor *)linkColor {
  return contentLinkColor;
}

+ (void)setLinkColor:(UIColor *)linkColor {
  contentLinkColor = linkColor;
}

- (void)prepareForReuse {
  self.titleLabel.text = @"";
  self.contentTextView.text = @"";
}

- (void)configureForCell:(XMMContentBlock *)block tableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
  //set title
  if(block.title != nil && ![block.title isEqualToString:@""]) {
    self.titleLabel.text = block.title;
    [self.titleLabel setFont:[UIFont systemFontOfSize:[XMMContentBlock0TableViewCell fontSize]+5 weight:UIFontWeightMedium]];
  }
  
  //set content
  if (block.text != nil && ![block.text isEqualToString:@""]) {
    self.contentTextView.textContainerInset = UIEdgeInsetsMake(0, -5, -20, -5);
    self.contentTextView.attributedText = [self attributedStringFromHTML:block.text fontSize:[XMMContentBlock0TableViewCell fontSize]];
    [self.contentTextView sizeToFit];
  } else {
    //make uitextview "disappear"
    [self.contentTextView setFont:[UIFont systemFontOfSize:0.0f]];
    self.contentTextView.textContainerInset = UIEdgeInsetsZero;
    self.contentTextView.textContainer.lineFragmentPadding = 0;
  }
  
  //set the linkcolor to a specific color
  if ([XMMContentBlock0TableViewCell linkColor] != nil) {
    [self.contentTextView setLinkTextAttributes:@{NSForegroundColorAttributeName : [XMMContentBlock0TableViewCell linkColor], }];
  } else {
    [self.contentTextView setLinkTextAttributes:@{NSForegroundColorAttributeName : [UIColor blueColor], }];
  }

}

- (NSMutableAttributedString*)attributedStringFromHTML:(NSString*)html fontSize:(int)fontSize {
  NSError *err = nil;
  
  NSString *style = [NSString stringWithFormat:@"<style>body{font-family: -apple-system, \"Helvetica Neue Light\", \"Helvetica Neue\", Helvetica, Arial, \"Lucida Grande\", sans-serif; font-size:%d; margin:0 !important;} p:last-child, p:last-of-type{margin:0px !important;} </style>", fontSize];
  
  html = [html stringByReplacingOccurrencesOfString:@"<br></p>" withString:@"</p>"];
  html = [html stringByReplacingOccurrencesOfString:@"<p></p>" withString:@""];
  html = [NSString stringWithFormat:@"%@%@", style, html];
  
  NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithData: [html dataUsingEncoding:NSUTF8StringEncoding]
                                                                                        options: @{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
                                                                                                    NSCharacterEncodingDocumentAttribute: @(NSUTF8StringEncoding)}
                                                                             documentAttributes: nil
                                                                                          error: &err];
  if(err) {
    NSLog(@"Unable to parse label text: %@", err);
  }
  
  return attributedString;
}

/*
 - (void)setSelected:(BOOL)selected animated:(BOOL)animated {
 [super setSelected:selected animated:animated];
 
 // Configure the view for the selected state
 }
 */

@end
