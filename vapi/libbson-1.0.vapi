/* libbson-1.0 Vala Bindings
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

[CCode (cheader_filename = "bson.h")]
namespace Libbson {
	[CCode (cname = "int", cprefix = "BSON_TYPE_", has_type_id = "false")]
	public enum ValueType {
		EOD,
		DOUBLE,
		UTF8,
		DOCUMENT,
		ARRAY,
		BINARY,
		UNDEFINED,
		OID,
		BOOL,
		DATE_TIME,
		NULL,
		REGEX,
		DBPOINTER,
		CODE,
		SYMBOL,
		CODEWSCOPE,
		INT32,
		TIMESTAMP,
		INT64,
		MAXKEY,
		MINKEY
	}

	[CCode (cname = "int", cprefix = "BSON_SUBTYPE_", has_type_id = "false")]
	public enum SubType {
		BINARY,
		FUNCTION,
		BINARY_DEPRECATED,
		UUID_DEPRECATED,
		UUID,
		MD5,
		USER
	}

	[CCode (cname = "int", cprefix = "BSON_VALIDATE_", has_type_id = "false")]
	public enum ValidateFlag {
		NONE,
		UTF8,
		DOLLER_KEYS,
		DOT_KEYS,
		UTF8_ALLOW_NULL
	}

	[CCode (cname = "bson_error_t", has_type_id = "false")]
	public struct Error {
		uint32 domain;
		uint32 code;
		char message[504];
	}

	[CCode (cname = "bson_oid_t", cprefix = "bson_oid_", has_type_id = "false")]
	public struct Oid {
		uint8 bytes[12];
		public void init(Context? context = null);
		public void init_from_data([CCode (array_length = false)] uint8[] data);
		public void init_from_string(string str);
		public void init_sequence(Context? context = null); 
		public uint32 hash();
		public time_t get_time_t();
		public int compare(Oid other);
		public void copy(Oid dst);
		public bool equal(Oid other);
		public bool is_valid(string str, size_t length);
		[CCode (cname = "bson_oid_to_string")]
		private void _to_string(char *str);
		[CCode (cname = "vala_oid_to_string")]
		public string to_string() {
			char str[25] = {0};
			this._to_string(str);
			return ((string) str).dup();
		}
	}

	[CCode (cname = "v_timestamp", has_type_id = "false")]
	public struct VTimeStamp {
		uint32 timestamp;
		uint32 increment;
	}

	[CCode (cname = "v_utf8", has_type_id = "false")]
	public struct VUtf8 {
		char *str;
		uint32 len;
	}
	
	[CCode (cname = "v_doc", has_type_id = "false")]
	public struct VDoc {
		uint8 *data;
		uint32 data_len;
	}

	[CCode (cname = "v_binary", has_type_id = "false")]
	public struct VBinary {
		uint8 *data;
		uint32 data_len;
		SubType subtype;
	}
	
	[CCode (cname = "v_regex", has_type_id = "false")]
	public struct VRegex {
		char *regex;
		char *options;
	}

	[CCode (cname = "v_dbpointer", has_type_id = "false")]
	public struct VDpointer {
		char *collection;
		uint32 collection_len;
		Oid oid;
	}
	
	[CCode (cname = "v_code", has_type_id = "false")]
	public struct VCode {
		char *code;
		uint32 code_len;
	}
	
	[CCode (cname = "v_codewscope", has_type_id = "false")]
	public struct VCodewScope {
		char *code;
		uint8 *scope_data;
		uint32 code_len;
		uint32 scope_len;
	}

	[CCode (cname = "v_symbol", has_type_id = "false")]
	public struct VSymbol {
		char *symbol;
		uint32 len;
	}

	[CCode (cname = "bson_value_t", has_type_id = "false")]
	public struct Value {
		ValueType value_type;
		int32 padding;
		[CCode (cname = "value.v_oid")]
		Oid value_oid;
		[CCode (cname = "value.v_int64")]
		int64 value_int64;
		[CCode (cname = "value.v_int32")]
		int32 value_int32;
		[CCode (cname = "value.v_int8")]
		int8 value_int8;
		[CCode (cname = "value.v_double")]
		double value_double;
		[CCode (cname = "value.v_bool")]
		bool value_bool;
		[CCode (cname = "value.v_datetime")]
		int64 value_datetime;
		[CCode (cname = "value.v_timestamp")]
		VTimeStamp value_timestamp;
		[CCode (cname = "value.v_utf8")]
		VUtf8 value_utf8;
		[CCode (cname = "value.v_doc")]
		VDoc value_doc;
		[CCode (cname = "value.v_binary")]
		VBinary value_binary;
		[CCode (cname = "value.v_regex")]
		VRegex value_regex;
		[CCode (cname = "value.v_dpointer")]
		VDpointer value_dpointer;
		[CCode (cname = "value.v_code")]
		VCode value_code;
		[CCode (cname = "value.v_codewscope")]
		VCodewScope value_codewscope;
		[CCode (cname = "value.v_symbol")]
		VSymbol value_symbol;
	}

	[CCode (cname = "bson_context_t", cprefix = "bson_context_", free_function = "bson_context_destroy", has_type_id = "false")]
	[Compact]
	public class Context {
		public static Context get_default();
		[CCode (cname = "bson_context_new")]
		public Context();
	}

	[CCode (cname = "bson_t", cprefix = "bson_", free_function = "bson_destroy", has_type_id = "false")]
	[Compact]
	public class Bson {
		public uint32 len;
		public Bson();
		public Bson.from_json(uint8[] data, out Error error = null);
		public Bson.from_data(uint8[] data);
		public Bson.sized_new(size_t size);
		public Bson copy();
		public void copy_to(Bson dst);
		public void copy_to_excluding(Bson dst, ...);
		public void copy_to_excluding_noinit(Bson dst, ...);
		[CCode (cname = "bson_get_data", array_length = false)]
		private unowned uint8[] _get_data();
		[CCode (cname = "vala_bson_get_data")]
		public unowned uint8[] get_data() {
			unowned uint8[] data = this._get_data();
			data.length = (int)this.len;
			return data;
		}
		public uint32 count_keys();
		public bool has_field(string key);
		public int compare(Bson other);
		public bool equal(Bson other);
		public bool validate(ValidateFlag flag, out size_t offset);
		public string as_json(out size_t? length = null);
		public string array_as_json(out size_t? length = null);
		public bool append_value(string key, int key_length, Value @value);
		public bool append_array(string key, int key_length, Bson array);
		public bool append_binary(string key, int key_length, SubType subtype, uint8[] binary);
		public bool append_bool(string key, int key_length, bool @value);
		public bool append_code(string key, int key_length, string javascript);
		public bool append_code_with_scope(string key, int key_length, string javascript, Bson scope);
		public bool append_dpointer(string key, int key_length, string collection, Oid oid);
		public bool append_double(string key, int key_length, double @value);
		public bool append_document(string key, int key_length, Bson @value);
		public bool append_int32(string key, int key_length, int32 @value);
		public bool append_int64(string key, int key_length, int64 @value);
		public bool append_minkey(string key, int key_length);
		public bool append_maxkey(string key, int key_length);
		public bool append_null(string key, int key_length);
		public bool append_oid(string key, int key_length, Oid oid);
		public bool append_regex(string key, int key_length, string regex, string options);
		public bool append_utf8(string key, int key_length, char[] @value);
		public bool append_symbol(string key, int key_length, char[] @value);
		public bool append_time_t(string key, int key_length, time_t @value);
		public bool append_timeval(string key, int key_length, Posix.timeval @value);
		public bool append_date_time(string key, int key_length, int64 @value);
		public bool append_now_utc(string key, int key_length);
		public bool append_timestamp(string key, int key_length, uint32 timestamp, uint32 increment);
		public bool append_undefined(string key, int key_length);
		public bool concat(Bson src);
	}
}
