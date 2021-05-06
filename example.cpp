#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include "Arachne/Arachne.h"

void numberPrinter() {
    srand (time(NULL));
    printf("NumberPrinter says %d\n", rand() % 10 + 1);
}

// This is where user code should start running.
void AppMain(int argc, const char** argv) {
    printf("Arachne says hello world and creates a thread.\n");
    Arachne::ThreadId tid = Arachne::createThread(numberPrinter);
    Arachne::join(tid);
}



// The following bootstrapping code should be copied verbatim into most Arachne
// applications.
void AppMainWrapper(int argc, const char** argv) {
    for(int i=0; i<5; i++) {
        AppMain(argc, argv);
    }
    Arachne::shutDown();
}

int main(int argc, const char** argv){
    Arachne::init(&argc, argv);
    Arachne::createThread(&AppMainWrapper, argc, argv);
    Arachne::waitForTermination();
    return 0;
}
