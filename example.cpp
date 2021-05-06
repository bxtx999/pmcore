#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <unistd.h>
#include "Arachne/Arachne.h"

void numberPrinter(int i) {
    printf("NumberPrinter says %d\n", i);
    usleep(2e7);
}

// This is where user code should start running.
void AppMain(int i) {
    printf("Arachne says hello world and creates a thread.\n");
    Arachne::ThreadId tid = Arachne::createThread(numberPrinter, i);
    Arachne::join(tid);
}



// The following bootstrapping code should be copied verbatim into most Arachne
// applications.
void AppMainWrapper(int i) {
    AppMain(i);
    Arachne::shutDown();
}

int main(int argc, const char** argv){
    Arachne::init(&argc, argv);
    // Arachne::createThread(&AppMainWrapper, argc, argv);
    for (int i=1; i< 5; i++) {
        Arachne::createThread(&AppMainWrapper, i);
    }
    Arachne::waitForTermination();
    return 0;
}
