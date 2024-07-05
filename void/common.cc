#include "common.hh"

/** \brief Opens a file and checks the operation was successful.
 *
 * Opens a file, and checks the return value to ensure that the operation
 * was successful.
 * \param[in] filename the file to open.
 * \param[in] mode the cstdio fopen mode to use.
 * \return The file handle. */
FILE* safe_fopen(const char* filename,const char* mode) {
    FILE *temp=fopen(filename,mode);
    if(temp==NULL) fprintf(stderr,"Error opening file \"%s\"",filename);
    return temp;
}
