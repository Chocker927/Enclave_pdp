#include<stdio.h>
#include<stdlib.h>
#include<unistd.h>
#include<sys/time.h>
#include<string.h>

int main(){
  //生成测试文件
  int choice=0;
  printf("You should generate the testfile firstly.\n0:generate testfile\n1:benchmark the speed of tag\n2:benchmark the speed of verify\n");
  scanf("%d",&choice);
  if(choice==0){
    system("mkdir -p testfile");
    for(int i=10;i<=20;i++){
      char s[100];
      sprintf(s,"dd if=/dev/urandom of=testfile/test.%d count=1024 bs=%d",i,1<<i);
      system(s);
    }
  }
  else if(choice==1){
    FILE *f=NULL;
    f=fopen("speed-tag.log","w");
    struct timeval t1,t2;
    for(int i=10;i<=20;i++){
      char s[100],a[100];
      sprintf(s,"./TestApp -t testfile/test.%d",i);
      gettimeofday(&t1,NULL);
      system(s);
      gettimeofday(&t2,NULL);
      double runtime=(t2.tv_sec-t1.tv_sec)*1e6+t2.tv_usec-t1.tv_usec;
      sprintf(a,"tag %dMB size file need %f sec(s).\n",1<<(i-10),runtime/1000000.0);
      fputs(a,f);
    }
    fclose(f);
  }
  else if(choice==2){
    FILE *f=NULL;
    f=fopen("speed-verify.log","w");
    struct timeval t1,t2;
    for(int i=10;i<=20;i++){
      char s[100],a[100];
      sprintf(s,"./TestApp -v testfile/test.%d",i);
      gettimeofday(&t1,NULL);
      system(s);
      gettimeofday(&t2,NULL);
      double runtime=(t2.tv_sec-t1.tv_sec)*1e6+t2.tv_usec-t1.tv_usec;
      sprintf(a,"verify %dMB size file need %f sec(s).\n",1<<(i-10),runtime/1000000.0);
      fputs(a,f);
    }
    fclose(f);
  }
  else{
    printf("Wrong choice.\n");
  }
}