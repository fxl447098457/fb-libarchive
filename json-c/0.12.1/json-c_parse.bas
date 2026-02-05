#include once "json-c/json.bi"
#inclib "Json-c"
#inclib "advapi32"
' parse JSON string
Print "json-c version:";*json_c_version()
Dim json_str As ZString Ptr = @"{""name"":""John"",""age"":30}"
Dim obj As json_object Ptr = json_tokener_parse(json_str)

' Get value bia key
Dim name_obj As json_object Ptr = json_object_object_get(obj, "name")
Dim age_obj As json_object Ptr = json_object_object_get(obj, "age")

Print "Name: "; *json_object_get_string(name_obj)
Print "Age: "; json_object_get_int(age_obj)

' free object
json_object_put(obj)

Sleep