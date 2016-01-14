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

#import "XMMContentBlockType9.h"

@implementation XMMContentBlockType9

#pragma mark - XMMTableViewRepresentation

- (UITableViewCell *)tableView:(UITableView *)tableView representationAsCellForRowAtIndexPath:(NSIndexPath *)indexPath {
  XMMContentBlock9TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SpotMapBlockTableViewCell"];
  if (cell == nil) {
    [tableView registerNib:[UINib nibWithNibName:@"XMMContentBlock9TableViewCell" bundle:nil]
    forCellReuseIdentifier:@"SpotMapBlockTableViewCell"];
    cell = [tableView dequeueReusableCellWithIdentifier:@"SpotMapBlockTableViewCell"];
  }
  
  //set title, spotmapTags
  cell.titleLabel.text = self.title;
  cell.spotMapTags = [self.spotMapTag componentsSeparatedByString:@","];
  [cell getSpotMap];
  
  return cell;
}

@end
