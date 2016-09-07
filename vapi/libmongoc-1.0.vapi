/* libmongoc-1.0 Vala Bindings
 * Copyright 2015 Matrix Zhang <pigex.zhang@gmail.com>
 *
 * Permission is hereby granted, free of charge, to any person
 * obtaining a copy of this software and associated documentation
 * files (the "Software"), to deal in the Software without
 * restriction, including without limitation the rights to use, copy,
 * modify, merge, publish, distribute, sublicense, and/or sell copies
 * of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
 * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
 * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
 * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

[CCode (cheader_filename = "mongoc.h")]
namespace Libmongoc {
	[CCode (cname = "int", cprefix = "MONGOC_DELETE_", has_type_id = "false")]
	public enum DeleteFlag {
		NONE,
		SINGLE_REMOVE
	}

	[CCode (cname = "int", cprefix = "MONGOC_REMOVE_", has_type_id = "false")]
	public enum RemoveFlag {
		NONE,
		SINGLE_REMOVE
	}
	
	[CCode (cname = "int", cprefix = "MONGOC_INSERT_", has_type_id = "false")]
	public enum InsertFlag {
		NONE,
		CONTINUE_ON_ERROR
	}
	
	[CCode (cname = "int", cprefix = "MONGOC_QUERY_", has_type_id = "false")]
	public enum QueryFlag {
		NONE,
		TAILABLE_CURSOR,
		SLAVE_OK,
		OPLOG_REPLAY,
		NO_CURSOR_TIMEOUT,
		AWAIT_DATA,
		EXHAUST,
		PARTIAL
	}

	[CCode (cname = "int", cprefix = "MONGOC_REPLY_", has_type_id = "false")]
	public enum ReplyFlag {
		NONE,
		CURSOR_NOT_FOUND,
		QUERY_FAILURE,
		SHARD_CONFIG_STALE,
		AWAIT_CAPABLE
	}
	
	[CCode (cname = "int", cprefix = "MONGOC_UPDATE_", has_type_id = "false")]
	public enum UpdateFlag {
		NONE,
		UPSERT,
		MULTI_UPDAT
	}

	[CCode (cname = "int", cprefix = "MONGOC_READ_", has_type_id = "false")]
	public enum ReadMode {
		PRIMARY,
		SECONDARY,
		PRIMARY_PREFERRED,
		SECONDARY_PREFERRED,
		NEAREST
	}

	[CCode (cname = "int", cprefix = "MONGOC_INDEX_STORAGE_OPT_", has_type_id = "false")]
	public enum IndexStorageOptType {
		MMAPV1,
		WIREDTIGER,
	}
	
#if MONGOC_ENABLE_SSL
	[CCode (cname = "mongoc_ssl_opt_t", has_type_id = "false")]
	public struct SSLOpt {
		string pem_file;
		string pem_pwd;
		string ca_file;
		string ca_dir;
		string crl_file;
		bool weak_cert_validation;
		void *padding [8];
	}
	
	[CCode (cname = "mongoc_ssl_opt_get_default")]
	public SSLOpt ssl_opt_get_default();
#endif

	[CCode (cname = "mongoc_index_opt_geo_t", has_type_id = "false")]
	public struct IndexOptGeo {
		uint8 twod_sphere_version;
		uint8 twod_bits_precision;
		double  twod_location_min;
		double  twod_location_max;
		double  haystack_bucket_size;
		uint8 *padding[32];
	}

	[CCode (cname = "mongoc_index_opt_storage_t", has_type_id = "false")]
	public struct IndexOptStorage {
		int type;
	}
	
	[CCode (cname = "mongoc_index_opt_wt_t", has_type_id = "false")]
	public struct IndexOptWt {
		IndexOptStorage @base;
		string config_str;
		void *padding[8];
	}

	[CCode (cname = "mongoc_index_opt_t", has_type_id = "false")]
	public struct IndexOpt {
		bool is_initialized;
		bool background;
		bool unique;
		string name;
		bool drop_dups;
		bool sparse;
		int32 expire_after_seconds;
		int32 v;
		Libbson.Bson *weights;
		string default_language;
		string language_override;
		IndexOptStorage *geo_options;
		IndexOptStorage *storage_options;
		void *padding[6];
	}

	[CCode (cname = "mongoc_read_prefs_t", cprefix = "mongoc_read_prefs_", free_function = "mongoc_read_prefs_destroy", has_type_id = "false")]
	[Compact]
	public class ReadPrefs {
		[CCode (cname = "mongoc_read_prefs_new")]
		public ReadPrefs(ReadMode mode);
		public ReadPrefs copy();
		public ReadMode get_mode();
		public void set_mode(ReadMode mode);
		public Libbson.Bson get_tags();
		public void set_tags(Libbson.Bson tags);
		public void add_tag(Libbson.Bson tag);
		public bool is_valid();
	}

	[CCode (cname = "mongoc_uri_t", cprefix = "mongoc_uri_", free_function = "mongoc_uri_destroy", has_type_id = "false")]
	[Compact]
	public class Uri {
		[CCode (cname = "mongoc_uri_new", has_type_id = "false")]
		public Uri(string uri_string);
		public Uri copy();
		public unowned string? get_database();
	}

	[CCode (cname = "mongoc_cursor_t", cprefix = "mongoc_cursor_", free_function = "mongoc_cursor_destroy", has_type_id = "false")]
	[Compact]
	public class Cursor {
		private Cursor() {}
		public Cursor clone();
		public bool more();
		public bool next(out Libbson.Bson bson);
		public bool error(out Libbson.Error error = null);
		public bool is_alive();
		public Libbson.Bson current();
		public void set_batch_size(uint32 batch_size);
		public uint32 get_batch_size();
		public uint32 get_hint();
		public int64 get_id();
	}

	[CCode (cname = "mongoc_write_concern_t", cprefix = "mongoc_write_concern_", free_function = "mongoc_write_concern_destroy", has_type_id = "false")]
	[Compact]
	public class WriteConcern {
		[CCode (cname = "mongoc_write_concern_new")]
		public WriteConcern();
		public WriteConcern copy();
		public bool get_fsync();
		public void set_fsync(bool fsync);
		public bool get_journal();
		public void set_journal(bool journal);
		public int32 get_w();
		public void set_w(int32 w);
		public string get_wtag();
		public void set_wtag(string tag);
		public int32 get_wtimeout();
		public void set_wtimeout(int32 wtimeout_msec);
		public bool get_wmajority();
		public void set_wmajority(int32 wtimeout_msec);
	}

	[CCode (cname = "mongoc_bulk_operation_t", cprefix = "mongoc_bulk_operation_", free_function = "mongoc_bulk_operation_destroy", has_type_id = "false")]
	[Compact]
	public class BulkOperation {
		[CCode (cname = "mongoc_bulk_operation_new")]
		public BulkOperation();
		public void set_write_concern(WriteConcern write_concern);
		public void set_database(string database);
		public void set_collection(string collection);
		public void set_client(void *client);
		public void set_hint(uint32 hint);
		public WriteConcern get_write_concern();
		public uint32 execute(Libbson.Bson reply, out Libbson.Error error = null);
		public void @delete(Libbson.Bson selector);
		public void delete_one(Libbson.Bson selector);
		public void insert(Libbson.Bson document);
		public void remove(Libbson.Bson selector);
		public void remove_one(Libbson.Bson selector);
		public void replace_one(Libbson.Bson selector, Libbson.Bson document, bool upsert);
		public void update(Libbson.Bson selector, Libbson.Bson document, bool upsert);
		public void update_one(Libbson.Bson selector, Libbson.Bson document, bool upsert);
	}
	
	[CCode (cname = "mongoc_client_pool_t", cprefix = "mongoc_client_pool_", free_function = "mongoc_client_pool_destroy", has_type_id = "false")]
	[Compact]
	public class ClientPool {
	    [CCode (cname = "mongoc_client_pool_new", has_type_id = "false")]
	    public ClientPool(Uri uri);
	    public void max_size(uint max_pool_size);
	    public void min_size(uint min_pool_size);
	    public Client pop();
	    public void push(Client client);
	}

	[CCode (cname = "mongoc_database_t", cprefix = "mongoc_database_", free_function = "mongoc_database_destroy", has_type_id = "false")]
	[Compact]
	public class DataBase {
		private DataBase() {}
		public string get_name();
		public bool remove_user(string user_name,  out Libbson.Error error = null);
		public bool remove_all_users(out Libbson.Error error = null);
		public bool add_user(string username, string password, Libbson.Bson roles, Libbson.Bson custom_data, out Libbson.Error error = null);
		public Cursor command(QueryFlag flag, uint32 skip, uint32 limit, uint32 batch_size, Libbson.Bson command, Libbson.Bson? fields = null, ReadPrefs? read_prefs = null);
		public bool command_simple(Libbson.Bson command, ReadPrefs? read_prefs = null, Libbson.Bson? reply = null, out Libbson.Error error = null);
		public bool drop(out Libbson.Error error = null);
		public bool has_collection(string name, out Libbson.Error error = null);
		public ReadPrefs get_read_prefs();
		public void set_read_prefs(ReadPrefs read_prefs);
		public Cursor find_collections(Libbson.Bson filter, out Libbson.Error error = null);
		[CCode (array_null_terminated = true)]
		public string[] get_collection_names(out Libbson.Error error = null);
		public Collection get_collection(string name);
	}

	[CCode (cname = "mongoc_collection_t", cprefix = "mongoc_collection_", free_function = "mongoc_collection_destroy", has_type_id = "false")]
	[Compact]
	public class Collection {
		private Collection() {}
		public Cursor aggregate(QueryFlag flag, Libbson.Bson pipeline, Libbson.Bson? options = null , ReadPrefs? read_prefs = null);
		public Cursor command(QueryFlag flag, uint32 skip, uint32 limit, uint32 batch_size, Libbson.Bson command, Libbson.Bson? fields = null, ReadPrefs? read_prefs = null);
		public bool command_simple(Libbson.Bson command, ReadPrefs? read_prefs = null, Libbson.Bson? reply = null, out Libbson.Error error = null);
		public int64 count(QueryFlag flag, Libbson.Bson query, uint32 skip = 0, uint32 limit = 0, ReadPrefs? read_prefs = null, out Libbson.Error error = null);
		public int64 count_with_opts(QueryFlag flag, Libbson.Bson query, uint32 skip, uint32 limit, Libbson.Bson opts, ReadPrefs? read_prefs = null, out Libbson.Error error = null);
		public bool drop(out Libbson.Error error = null);
		public bool drop_index(string index_name, out Libbson.Error error = null);
		public bool create_index(Libbson.Bson keys, ref IndexOpt opt, out Libbson.Error error = null);
		public Cursor find_indexes(out Libbson.Error error = null);
		public Cursor find(QueryFlag flag, uint32 skip, uint32 limit, uint32 batch_size, Libbson.Bson query, Libbson.Bson? fields = null, ReadPrefs? read_prefs = null);
		public bool insert(InsertFlag flag, Libbson.Bson document, WriteConcern? write_concern = null, out Libbson.Error error = null);
		public bool insert_bulk(InsertFlag flag, Libbson.Bson[] documents, WriteConcern? write_concern = null, out Libbson.Error error = null);
		public bool update(UpdateFlag flag, Libbson.Bson selector, Libbson.Bson update, WriteConcern? write_concern = null, out Libbson.Error error = null);
		public bool @delete(DeleteFlag flag, Libbson.Bson selector, WriteConcern? write_concern = null, out Libbson.Error error = null);
		public bool save(Libbson.Bson document, WriteConcern? write_concern = null, out Libbson.Error error = null);
		public bool remove(RemoveFlag flag, Libbson.Bson selector, WriteConcern? write_concern = null, out Libbson.Error error = null);
		public bool rename(string new_db, string new_name, bool drop_target_before_rename, out Libbson.Error error = null);
		public bool find_and_modify(Libbson.Bson query, Libbson.Bson sort, Libbson.Bson update, Libbson.Bson? fields, bool remove, bool upsert, bool @new, Libbson.Bson reply, out Libbson.Error error = null);
		public bool stats(Libbson.Bson options, Libbson.Bson reply, out Libbson.Error error = null);
		public BulkOperation create_bulk_operation(bool ordered, WriteConcern? write_concern = null);
		public ReadPrefs get_read_prefs();
		public void set_read_prefs(ReadPrefs read_prefs);
		public WriteConcern get_write_concern();
		public void set_write_concern(WriteConcern write_concern);
		public string get_name();
		public Libbson.Bson get_last_error();
		public string keys_to_index_string(Libbson.Bson keys);
		public bool validate(Libbson.Bson opts, Libbson.Bson reply, out Libbson.Error error = null);
	}

	[CCode (cname = "mongoc_client_t", cprefix = "mongoc_client_", free_function = "mongoc_client_destroy", has_type_id = "false")]
	[Compact]
	public class Client {
		[CCode (cname = "mongoc_client_new", has_type_id = "false")]
		public Client(string uri_string);
		[CCode (cname = "mongoc_client_new_from_uri", has_type_id = "false")]
		public Client.from_uri(Uri uri);
		public Cursor command(string db_name, QueryFlag flag, uint32 skip, uint32 limit, uint32 batch_size, Libbson.Bson query, Libbson.Bson? fields = null, ReadPrefs? read_prefs = null);
		public void kill_cursor(int64 cursor_id);
		public bool command_simple(string db_name, Libbson.Bson command, ReadPrefs? read_prefs = null, Libbson.Bson? reply = null, out Libbson.Error error = null);
		public DataBase get_database(string name);
		public DataBase get_default_database();
		public Collection get_collection(string db, string collection);
		[CCode (array_null_terminated = true)]
		public string[] get_database_names(out Libbson.Error error = null);
		public Cursor find_database(out Libbson.Error error = null);
		public bool get_server_status(ReadPrefs? read_prefs = null, Libbson.Bson? reply = null, out Libbson.Error error = null);
		public int32 get_max_message_size();
		public int32 get_max_bson_size();
		public WriteConcern get_write_concern();
		public void set_write_concern(WriteConcern write_concern);
		public ReadPrefs get_read_prefs();
		public void set_read_prefs(ReadPrefs read_prefs);
	#if MONGOC_ENABLE_SSL
		public void set_ssl_opts(SSLOpt opts);			
	#endif
	}

	[CCode (cname = "mongoc_init")]
	public void init();

	[CCode (cname = "mongoc_cleanup")]
	public void cleanup();
}
