
class VideosList{
  String kind;
  String etag;
  String nextPageToken;
  String regionCode;
  List<Item> items;
  PageInfo pageInfo;

  VideosList({required this.kind, 
  required this.etag, 
  required this.nextPageToken, 
  required this.items,
  required this.regionCode,
  required this.pageInfo
  });

  factory VideosList.fromJson(dynamic json){
    var list = json['items'] as List;

    return VideosList(
      kind: json['kind'] == null ? '' : json['kind'] as String,
      etag: json['etag'] == null ? '' : json['etag'] as String,
      nextPageToken: json['nextPageToken'] == null ? '' : json['nextPageToken'] as String,
      items: list.isNotEmpty ? list.map((i) => Item.fromJson(i)).toList() : [],
      regionCode: json['regionCode'] == null ? '' : json['regionCode'] as String,
      pageInfo: PageInfo.fromJson(json['pageInfo']),
      );
  }
}

class PageInfo{
  int totalResults;
  int resultsPerPage;

  PageInfo({required this.totalResults, 
  required this.resultsPerPage
  });

  factory PageInfo.fromJson(dynamic json){
    return PageInfo(
      totalResults: json['totalResults'] == null ? 0 : json['totalResults'] as int,
      resultsPerPage : json['resultsPerPage'] == null ? 0: json['resultsPerPage'] as int,
    );
  }
}

class Item{
  String kind;
  String etag;
  Id id;
  Snippet snippet;

  Item({required this.kind,
  required this.etag,
  required this.id,
  required this.snippet
  });

  factory Item.fromJson(dynamic json){
    return Item(
      kind: json['kind'] == null ? '':json['kind'] as String,
      etag: json['etag'] == null ? '':json['etag'] as String,
      id: Id.fromJson(json['id']),
      snippet: Snippet.fromJson(json['snippet']),
    );
  }
}

class Id{
  String kind;
  String videoId;

  Id({required this.kind, required this.videoId});

  factory Id.fromJson(dynamic json){
    return Id(
      kind: json['kind'] == null ? '' : json['kind'] as String,
      videoId: json['videoId'] == null ? '' : json['videoId'] as String,
    );
  }
}

class Snippet {
  String publishedAt;
  String channelId;
  String title;
  String description;
  Thumbnail thumbnails;
  String channelTitle;
  String liveBroadcastContent;
  String publishTime;

  Snippet({
    required this.publishedAt,
    required this.channelId,
    required this.title,
    required this.description,
    required this.thumbnails,
    required this.channelTitle,
    required this.liveBroadcastContent,
    required this.publishTime,
    
  });

  factory Snippet.fromJson(dynamic json) {
    return Snippet(
      publishedAt: json['publishedAt'] == null ? '' : json['publishedAt'] as String,
      channelId: json['channelId'] == null ? '' : json['channelId'] as String,
      title: json['title'] == null ? '' : json['title'] as String,
      description: json['description'] == null ? '' : json['description'] as String,
      thumbnails: Thumbnail.fromJson(json['thumbnails']),
      channelTitle: json['channelTitle'] == null ? '' : json['channelTitle'] as String,
      liveBroadcastContent: json['liveBroadcastContent'] == null ? '' : json['liveBroadcastContent'] as String,
      publishTime: json['publishTime'] == null ? '' : json['publishTime'] as String,
    );
  }
}

class Thumbnail {
  String default_;
  String medium;
  String high;
  String standard;
  String maxres;

  Thumbnail({
    required this.default_,
    required this.medium,
    required this.high,
    required this.standard,
    required this.maxres,
  });

  factory Thumbnail.fromJson(dynamic json) {
    return Thumbnail(
      default_: json['default'] == null ? '' : json['default']['url'] as String,
      medium: json['medium'] == null ? '' : json['medium']['url'] as String,
      high: json['high'] == null ? '' : json['high']['url'] as String,
      standard: json['standard'] == null ? '' : json['standard']['url'] as String,
      maxres: json['maxres'] == null ? '' : json['maxres']['url'] as String,
    );
  }
}

class Thumb {
  String url;
  int width = 0;
  int height = 0;

  Thumb({
    required this.url,
    required this.width,
    required this.height,
  });

  factory Thumb.fromJson(dynamic json) {
    return Thumb(
      url: json['url'] == null ? '' : json['url'] as String,
      width: json['width'] == null ? 0 : json['width'] as int,
      height: json['height'] == null ? 0 : json['height'] as int,
    );
  }
}
