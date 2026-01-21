@echo off
setlocal EnableExtensions
chcp 65001 > nul

rem === 설정: 경로만 맞으면 끝 ===
set "REPO=\\nas\Cookapps Project\ON_AIR_UA\PlayableAdPlayer"
set "GIT=\\nas\Cookapps Project\ON_AIR_UA\기타\PortableGit\bin\git.exe"

rem === 기본 체크 ===
if not exist "%GIT%" (
  mshta "javascript:var sh=new ActiveXObject('WScript.Shell');sh.Popup('[오류] git.exe를 찾을 수 없습니다.\n\n%GIT%',0,'실패',16);close();"
  exit /b 1
)

pushd "%REPO%" 2>nul
if errorlevel 1 (
  mshta "javascript:var sh=new ActiveXObject('WScript.Shell');sh.Popup('[오류] 리포지토리 폴더에 접근할 수 없습니다.\n\n%REPO%',0,'실패',16);close();"
  exit /b 1
)

if not exist ".git" (
  popd
  mshta "javascript:var sh=new ActiveXObject('WScript.Shell');sh.Popup('[오류] 이 폴더는 Git 리포지토리가 아닙니다.\n\n%REPO%',0,'실패',16);close();"
  exit /b 1
)

rem === 변경사항 없으면 종료 ===
"%GIT%" status --porcelain > "%TEMP%\__git_status_tmp.txt" 2>nul
for %%A in ("%TEMP%\__git_status_tmp.txt") do if %%~zA==0 (
  del "%TEMP%\__git_status_tmp.txt" >nul 2>nul
  popd
  mshta "javascript:var sh=new ActiveXObject('WScript.Shell');sh.Popup('변경사항이 없습니다.\n\n업로드할 내용이 없어요!',0,'안내',64);close();"
  exit /b 0
)
del "%TEMP%\__git_status_tmp.txt" >nul 2>nul

rem === 업로드 ===
"%GIT%" add -A
if errorlevel 1 goto :FAIL

"%GIT%" commit -m "파일 업로드 %date% %time:~0,5%"
if errorlevel 1 (
  rem 보통은 없지만, 혹시 커밋할 게 없다는 케이스 처리
  rem (status가 변화를 봤는데 commit이 실패하면 다른 이유일 가능성이 큼)
  goto :FAIL
)

"%GIT%" push
if errorlevel 1 goto :FAIL

popd
mshta "javascript:var sh=new ActiveXObject('WScript.Shell');sh.Popup('업로드가 완료되었습니다! ദ്ദി(｡•̀ ᗜ<)\n\n업데이트는 1~2분 정도 소요됩니다.\n잠시만 기다려주세요!',0,'완료',64);close();"
exit /b 0

:FAIL
popd
mshta "javascript:var sh=new ActiveXObject('WScript.Shell');sh.Popup('[오류] 업로드 실패\n\n원인 예시:\n- Git 인증(로그인/토큰)\n- 네트워크/NAS\n- 원격 저장소 권한\n\n자세한 내용은 CMD 창의 출력 내용을 확인해주세요.',0,'실패',16);close();"
exit /b 1
