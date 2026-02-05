#inclib "crypto"
#inclib "advapi32"
#inclib "ws2_32"

' declare OpenSSL  SHA256 function
extern "c"
Declare Function SHA256(ByVal d As UByte Ptr, ByVal n As ULong, ByVal md As UByte Ptr) As UByte Ptr
Declare Function OpenSSL_version (ByVal type_ As UInteger) As ZString Ptr
Const OPENSSL_VERSION_ = 0
end Extern

Function BytesToHex(data_ As UByte Ptr, len_ As Integer) As String
    Dim As String hexStr = ""
    For i As Integer = 0 To len_ - 1
        hexStr += Hex(data_[i], 2)
    Next
    Return hexStr
End Function


Dim As String input_ = "Hello, FreeBASIC + OpenSSL!"
Dim As UByte Ptr inputPtr = StrPtr(input_)
Dim As ULong inputLen = Len(input_)
Dim As UByte md(31) ' SHA256 
Print "Version string: "; *OpenSSL_version(OPENSSL_VERSION_)
' call SHA256
If SHA256(inputPtr, inputLen, @md(0)) <> 0 Then
    Print "SHA256: "; BytesToHex(@md(0), 32)
Else
    Print "SHA256 failed!"
End If

Sleep