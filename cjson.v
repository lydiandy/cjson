module cjson

#flag -I @VROOT/thirdparty/cJSON
#flag @VROOT/thirdparty/cJSON/cJSON.o
#include "cJSON.h"

pub struct C.cJSON {
pub:
	@type int
	valueint    int
	valuedouble f32
	valuestring byteptr	
}

fn C.cJSON_CreateObject() &C.cJSON
fn C.cJSON_CreateArray() &C.cJSON
fn C.cJSON_CreateBool(bool) &C.cJSON 
fn C.cJSON_CreateTrue() &C.cJSON
fn C.cJSON_CreateFalse() &C.cJSON
fn C.cJSON_CreateNull() &C.cJSON
fn C.cJSON_CreateNumber() &C.cJSON 	
fn C.cJSON_CreateString() &C.cJSON 	
fn C.cJSON_CreateRaw(byteptr) &C.cJSON

fn C.cJSON_IsInvalid(voidptr) bool
fn C.cJSON_IsFalse(voidptr) bool
fn C.cJSON_IsTrue(voidptr) bool 	
fn C.cJSON_IsBool(voidptr) bool
fn C.cJSON_IsNull(voidptr) bool
fn C.cJSON_IsNumber(voidptr) bool
fn C.cJSON_IsString(voidptr) bool
fn C.cJSON_IsArray(voidptr) bool
fn C.cJSON_IsObject(voidptr) bool
fn C.cJSON_IsRaw(voidptr) bool

fn C.cJSON_AddItemToObject(voidptr, byteptr, voidptr)
fn C.cJSON_AddItemToArray(voidptr,voidptr)

fn C.cJSON_Delete(voidptr)

fn C.cJSON_Parse() &C.cJSON 	

fn C.cJSON_GetObjectItem(&C.cJSON,byteptr) &C.cJSON
fn C.cJSON_GetArrayItem(&C.cJSON,byteptr) &C.cJSON
fn C.cJSON_GetStringValue(&C.cJSON,byteptr) byteptr

fn C.cJSON_Print() byteptr
fn C.cJSON_PrintUnformatted() byteptr 

// [inline]
pub fn create_object() &C.cJSON {
	return C.cJSON_CreateObject()
}

[inline]
pub fn create_array() &C.cJSON {
	return C.cJSON_CreateArray()
}

[inline]
pub fn create_string(val string) &C.cJSON {
	return C.cJSON_CreateString(val.str)
}

[inline]
pub fn create_number(val f64) &C.cJSON {
	return C.cJSON_CreateNumber(val)
}

[inline]
pub fn create_bool(val bool) &C.cJSON {
	return C.cJSON_CreateBool(val)
}

[inline]
pub fn create_true() &C.cJSON {
	return C.cJSON_CreateTrue()
}

[inline]
pub fn create_false() &C.cJSON {
	return C.cJSON_CreateFalse()
}

[inline]
pub fn create_null() &C.cJSON {
	return C.cJSON_CreateNull()
}

[inline]
pub fn delete(b voidptr) {
	C.cJSON_Delete(b)
}

[inline]
pub fn add_item_to_object(obj &C.cJSON,key string,item &C.cJSON) {
	C.cJSON_AddItemToObject(obj,key.str,item)
}

[inline]
pub fn add_item_to_array(obj &C.cJSON,item &C.cJSON) {
	C.cJSON_AddItemToArray(obj,item)
}

pub fn get_string_value(obj &C.cJSON) string {
	s:=C.cJSON_GetStringValue(obj)
	return tos(s,C.strlen(s))
}

[inline]
pub fn get_object_item(obj &C.cJSON,item string) &C.cJSON {
	return C.cJSON_GetObjectItem(obj,item.str)
}

pub fn get_array_item(obj &C.cJSON,item string) &C.cJSON {
	return C.cJSON_GetArrayItem(obj,item.str)
}

pub fn json_print(json &C.cJSON) string {
	s := C.cJSON_Print(json)
	return tos(s, C.strlen(s))
}

pub fn json_parse(s string) &C.cJSON {
	return C.cJSON_Parse(s.str)
}


// ========= function alias =========

pub fn (obj &C.cJSON) set(key string, item &C.cJSON) {
	add_item_to_object(obj, key, item)
}

pub fn (obj &C.cJSON) add(item &C.cJSON) {
	add_item_to_array(obj, item)
}

pub fn (obj &C.cJSON) dump() string {
	return json_print(obj)
}

pub fn (obj &C.cJSON) get(item string) &C.cJSON {
	return get_object_item(obj, item)
}

pub fn (obj &C.cJSON) get_str(item string) string {
	return get_string_value(obj.get(item))
}

pub fn (obj &C.cJSON) get_int(item string) int {
	return obj.get(item).valueint
}

pub fn (obj &C.cJSON) get_num(item string) f32 {
	return obj.get(item).valuedouble
}

pub fn (obj &C.cJSON) get_boolean(item string) bool {
	value := obj.get(item).valueint
	return value == 1
}

pub fn (obj &C.cJSON) is_null(item string) bool {
	value := obj.get(item)
	return cJSON_IsNull(value)
}

pub fn (obj &C.cJSON) gets(item string) &C.cJSON {
	return get_array_item(obj, item)
}


pub fn obj() &C.cJSON {
	return create_object()
}

pub fn list() &C.cJSON {
	return create_array()
}

pub fn str(val string) &C.cJSON {
	return create_string(val)
}

pub fn num(val f64) &C.cJSON {
	return create_number(val)
}

pub fn boolean(val bool) &C.cJSON {
	return create_bool(val)
}

pub fn null() &C.cJSON {
	return create_null()
}

pub fn load(s string) &C.cJSON {
	return json_parse(s)
}

// ==================================