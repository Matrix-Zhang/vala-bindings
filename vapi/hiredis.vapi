[CCode (lower_case_cprefix = "", cheader_filename = "hiredis.h")]
namespace HiRedis {
	//read.h
	public const int REDIS_ERR_IO;
	public const int REDIS_ERR_EOF;
	public const int REDIS_ERR_PROTOCOL;
	public const int REDIS_ERR_OOM;
	public const int REDIS_ERR_OTHER;

	public const int REDIS_REPLY_STRING;
	public const int REDIS_REPLY_ARRAY;
	public const int REDIS_REPLY_INTEGER;
	public const int REDIS_REPLY_NIL;
	public const int REDIS_REPLY_STATUS;
	public const int REDIS_REPLY_ERROR;

	//hiredis.h
	[CCode (cname = "redisContext", free_function = "redisFree", has_type_id = "false")]
	[Compact]
	public struct Context {
		int err;
		string errstr;
	}
	[CCode (cname = "redisReply", free_function = "freeReplyObject", has_type_id = "false")]
	[Compact]
	public struct Reply {
		int type;
		int64 integer;
		int len;
		string str;
		size_t elements;
		[CCode (array_length_cname = "elements", array_length_type = "size_t")]
		Reply[] element;
	}

	[CCode (cname = "redisConnect")]
	unowned Context? connect(string ip, int port);
	[CCode (cname = "redisCommand")]
	unowned Reply? command(Context context, string command);
}

