#include <stdio.h>
#include "Arachne/Arachne.h"

void numberPrinter(int n) {
    printf("NumberPrinter says %d\n", n);
}

// This is where user code should start running.
void AppMain(int argc, const char** argv) {
    printf("Arachne says hello world and creates a thread.\n");
    Arachne::ThreadId tid1 = Arachne::createThread(numberPrinter, 5);
    Arachne::ThreadId tid2 = Arachne::createThread(numberPrinter, 6);
    Arachne::ThreadId tid3 = Arachne::createThread(numberPrinter, 7);
    Arachne::ThreadId tid4 = Arachne::createThread(numberPrinter, 8);
    Arachne::join(tid1);
    Arachne::join(tid2);
    Arachne::join(tid3);
    Arachne::join(tid4);
}

// The following bootstrapping code should be copied verbatim into most Arachne
// applications.
void AppMainWrapper(int argc, const char** argv) {
    AppMain(argc, argv);
    Arachne::shutDown();
}

int main(int argc, const char** argv){
    Arachne::init(&argc, argv);
    Arachne::createThread(&AppMainWrapper, argc, argv);
    Arachne::waitForTermination();
    return 0;
}
