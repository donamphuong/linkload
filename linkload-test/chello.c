extern void writeA(int, char [], int );
extern void exitA(int);

char message [] = "Hello World!\n";
#define MESSAGELENGTH 13
int main(void){
  writeA(1, message, MESSAGELENGTH);
  exitA(0);
}
