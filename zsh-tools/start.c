/*
 * vim をパイプから利用するためのモジュール
 * refs: http://lamanotrama.hateblo.jp/entry/20080605/1212679464
 *
 * - 必要な作業
 *
 * ```
 * $ gcc start.c -o start
 * $ ln -s start /usr/local/bin/start
 * ```
 *
 * - 利用例
 *
 * ```cmd
 * ls | xargs start vi
 * ```
 */
#include <unistd.h>
#include <stdio.h>

int main(argc, argv)
    int    argc;
    char   **argv;
{
    close(0);     /* close stdin */
    dup(2);       /* duplicate stdin from stderr */
    execvp(argv[1], argv + 1);
    perror("could not execute program");
}
