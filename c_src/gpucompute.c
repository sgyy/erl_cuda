/* gpucompute.c */
#include "erl_nif.h"
#include <stdio.h>
#include <string.h>

static ERL_NIF_TERM gpu_compute(ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[])
{

  int a = 0;
  enif_get_int(env, argv[0], &a);

  int b = 0;
  enif_get_int(env, argv[1], &b);

  char astr[15];
  sprintf(astr, "%d", a);

  char bstr[15];
  sprintf(bstr, "%d", b);

  //concat strings
  char bin_name[15] = "./priv/simadd";

  char * appstr = (char *) malloc(1 + strlen(bin_name) + strlen(astr)+ strlen(bstr) );

  strcpy(appstr, bin_name);
  strcat(appstr, " ");
  strcat(appstr, astr);
  strcat(appstr, " ");
  strcat(appstr, bstr);

  FILE *fp;
  fp = popen(appstr, "r");

  if (fp == NULL) {
    printf("Failed to run command\n" );
    exit(1);
  }

  char ret[15] = "0";
  while (fgets(ret, sizeof(ret)-1, fp) != NULL) {
    //printf("%s", ret);
  }

  return enif_make_string(env, ret, ERL_NIF_LATIN1);
}
static ErlNifFunc nif_funcs[] =
{
    {"gpu_compute", 2, gpu_compute}
};

ERL_NIF_INIT(gpucompute,nif_funcs,NULL,NULL,NULL,NULL)
