//
// Copyright 2015 by Raphael Seher <raphael@xamoom.com>
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

#import "XMMCoreDataContentBlocks.h"

@interface XMMCoreDataContentBlocks ()

@end

@implementation XMMCoreDataContentBlocks

+ (NSDictionary *) mapping {
  return @{ @"public_status":@"publicStatus",
            @"content_block_type":@"contentBlockType",
            @"@metadata.mapping.collectionIndex":@"order",
            @"title":@"title",
            @"content_id":@"contentId",
            @"download_type":@"downloadType",
            @"file_id":@"fileId",
            @"link_type":@"linkType",
            @"link_url":@"linkUrl",
            @"soundcloud_url":@"soundcloudUrl",
            @"spot_map_tag":@"spotMapTag",
            @"youtube_url":@"youtubeUrl",
            };
}

@end