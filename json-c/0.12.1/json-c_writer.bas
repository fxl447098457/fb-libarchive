#include once "json-c/json.bi"
#include once "json-c/printbuf.bi"
#inclib "json-c"
#inclib "advapi32"
Dim jOuter As json_object Ptr = json_object_new_object()
Dim jBody As json_object Ptr = json_object_new_object()

' add jBody to jOuter，key:"argument"
json_object_object_add(jOuter, "argument", jBody)

' create JSON string
Dim jString1 As json_object Ptr = json_object_new_string("#XXXX.IMS.Compliance.ValidateSimulatedOrdersArgument")
Dim jString2 As json_object Ptr = json_object_new_string("#Collection(String)")

' Add key-value pair to jBody
json_object_object_add(jBody, "@odata.type", jString1)
json_object_object_add(jBody, "OrderIds@odata.type", jString2)

' create  JSON array
Dim jOrdersID As json_object Ptr = json_object_new_array()
json_object_array_add(jOrdersID, json_object_new_string("Order_1"))
json_object_array_add(jOrdersID, json_object_new_string("Order_2"))

' Add array to jBody
json_object_object_add(jBody, "OrderIds", jOrdersID)

' print formatted  JSON string
Print *json_object_to_json_string_ext(jBody, JSON_C_TO_STRING_PRETTY)

Sleep