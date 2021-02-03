##### $PATH #####
export PATH="/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:$HOME/.pyenv/shims"
# 基本（ls コマンドなど）：/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin
# pyenv                  ：$HOME/.pyenv/shims

##### Homebrew #####
alias brew="PATH=/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin brew"
# brew doctor 実行時の警告「 Homebrew 管理外の config ファイルがあると衝突するかも？」の回避
# 参考：https://qiita.com/yutoman027/items/ae11bf22bdbcd645c92a

##### .zsh.d ディレクトリ内ファイルの読み込み #####
ZSHHOME="${HOME}/dotfiles/.zsh.d"
if [ -d $ZSHHOME -a -r $ZSHHOME -a \
     -x $ZSHHOME ]; then
    for i in $ZSHHOME/*; do
        [[ ${i##*/} = *.zsh ]] &&
            [ \( -f $i -o -h $i \) -a -r $i ] && . $i
    done
fi
# .zsh.d ディレクトリ内の *.zsh を読み込む
# BOT_TOKEN などセキュアな環境変数などをそこで管理
# 参考：http://fnwiya.hatenablog.com/entry/2015/11/03/191902