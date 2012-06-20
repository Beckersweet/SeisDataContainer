
Rules of engagment for out-of-core APIs :)
* all file allocations are done through FileAlloc utilities
* al directories are created outside of File*/Data* level utilities
* spmd blocks are allowed only at File* level utilities, none in Data* level

