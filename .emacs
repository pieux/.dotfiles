; 启动Emacs，获得窗口焦点。 详细：1 如果打开 emacs，M-x server-start
; 然后再启动 emacsclient，窗口不会在终端后面 ; 而且，2 有这句配置，emacs --daemon会报错
; 当然，emacs --daemon，再启动 emacsclient ; 窗口会闪，不是最优方案
; 选择方案1，注释这条配置
; (x-focus-frame nil)
