
Rules of engagment for out-of-core APIs :)
* all user read/writes are to be done by File* level utilities
* all directories are created/removed by user using ConDir/ConDistDir classes
* all file allocations are done through FileAlloc utilities
* spmd blocks are allowed only at File* level utilities, none in Data* level
* check/set/clean dirty flag only in File* level utilities

