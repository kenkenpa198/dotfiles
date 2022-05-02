:: 管理者として実行してね
:: 先に Microsoft Store へログインしておいてね

:: 使用許諾契約に同意するオプションを環境変数へ登録
set y="--accept-package-agreements"


::::: winget からインストール :::::
winget install Microsoft.VisualStudioCode %y%
winget install Microsoft.AzureDataStudio %y%
winget install WinSCP.WinSCP %y%
winget install --force Google.Chrome %y%
winget install Lexikos.AutoHotkey %y%
winget install QL-Win.QuickLook %y%
winget install Discord.Discord %y%
winget install LINE.LINE %y%
winget install OBSProject.OBSStudio %y%
winget install Avidemux.Avidemux %y%
winget install Valve.Steam %y%
winget install WinMerge.WinMerge %y%
winget install Apple.iTunes %y%
winget install 7zip.7zip %y%
winget install Docker.DockerDesktop %y%
winget install Atlassian.Sourcetree %y%
winget install Git.Git %y%
winget install -e --id BlenderFoundation.Blender %y%
winget install Logitech.Options %y%
winget install xanderfrangos.twinkletray %y%
winget install File-New-Project.EarTrumpet %y%


::::: Microsoft Store からインストール :::::
winget install devtoys %y%
winget install iCloud %y%
winget install "Python 3.10" %y%

:: Compress
winget install 9N1FHQZ38LHT %y%


::::: 手動インストール :::::
:: TODO: そのうちこの辺も自動化したい

:: dotfiles / https://github.com/kenkenpa198/dotfiles

:: Change Key / https://forest.watch.impress.co.jp/library/software/changekey/
:: alt-ime-ahk / https://github.com/karakaram/alt-ime-ahk/releases
:: サクラエディタ / https://sakura-editor.github.io/
:: Clip Studio Paint / https://www.clipstudio.net/ja/dl/
:: Wacom driver / https://tablet.wacom.co.jp/download/
:: Vroid Studio / https://vroid.com/
:: 3tene / https://3tene.com/

:: RictyDiminished-for-Powerline / https://github.com/mzyy94/RictyDiminished-for-Powerline
:: HackGen / https://github.com/yuru7/HackGen
:: Noto Sans Japanese / https://fonts.google.com/noto/specimen/Noto+Sans+JP

:: Valorant / https://playvalorant.com/ja-jp/download/