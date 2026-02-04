#include once "Newton.bi"
#inclib "dgCore"
#inclib "dgPhysics"
#inclib "stdc++"
#inclib "pthread"
Dim As NewtonWorld Ptr world = NewtonCreate()

NewtonDestroy(world)
sleep