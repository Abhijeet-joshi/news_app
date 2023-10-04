import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class SavedNews {
  var TABLE_NAME = "SAVED_NEWS";
  var NEWS_ID = "news_id";
  var PUB_DET = "pub_det";
  var TITLE = "news_title";
  var DESC = "news_desc";
  var CONTENT = "news_content";
  var IMG_URL = "news_imgurl";
  var NEWS_URL = "news_url";
  var PUB_AT = "news_pubat";

  Future<Database> openDB() async {
    var myDirectory = await getApplicationDocumentsDirectory();
    await myDirectory.create(recursive: true);
    var dbPath = "$myDirectory/savednewsdb.db";
    return await openDatabase(dbPath, version: 1, onCreate: (db, version) {
      var createQuery =
          "CREATE TABLE $TABLE_NAME ($NEWS_ID integer primary key autoincrement, $PUB_DET text, $TITLE text, $DESC text, $CONTENT text, $IMG_URL text, $NEWS_URL text, $PUB_AT text)";
      db.execute(createQuery);
    });
  }

  Future<bool> addNews(
      {required String id,
      required String details,
      required String title,
      required String description,
      required String content,
      required String imgUrl,
      required String newsUrl,
      required String pub}) async {
    var db = await openDB();
    var check = await db.insert(TABLE_NAME, {
      NEWS_ID : id,
      PUB_DET : details,
      TITLE : title,
      DESC : description,
      CONTENT : content,
      IMG_URL : imgUrl,
      NEWS_URL : newsUrl,
      PUB_AT : pub,
    });
    return check > 0;
  }

  Future<List<Map<String, dynamic>>> fetchSavedNews() async{
    var db = await openDB();
    List<Map<String, dynamic>> notes = await db.query(TABLE_NAME);
    return notes;
  }

  Future<bool> deleteNews(String id) async{
    var db = await openDB();
    int check = await db.delete(TABLE_NAME, where: "$NEWS_ID = ?", whereArgs: [id]);
    return check>0;
  }

}
