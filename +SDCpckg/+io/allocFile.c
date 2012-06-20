#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <string.h>
#include <stdio.h>
#include "mex.h"

/* allocFile(PATHNAME,ARRAYSIZE, ELEMENTSIZE) */
void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[]){
    
    /* Extracting filename and bytesize */
    char* filename   = mxArrayToString(prhs[0]);
    long arraysize   = mxGetScalar(prhs[1]);
    long elementsize = mxGetScalar(prhs[2]);
    off_t filesize   = (off_t)arraysize*(off_t)elementsize;
    
    /* Creating file */
    {
        struct stat buffer;
        char msg[1024] = "deleting ";
        if ( ! stat(filename, &buffer) ) {
            mexWarnMsgTxt(strcat(msg,filename));
            remove(filename);
        }
    }
    int fid = open(filename,
            O_CREAT | O_TRUNC | O_RDWR | O_NOFOLLOW,
            S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
    if( fid < 0 ) {
        mexErrMsgTxt("Unable to open file");
    }
    
    /* Resize file */
    int err = ftruncate( fid, filesize );
    
    close(fid);
    if( err != 0 ) {
        mexErrMsgTxt("Unable to set size of file");
    }
}
