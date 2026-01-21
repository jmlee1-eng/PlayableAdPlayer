@echo off
setlocal EnableExtensions
chcp 65001 > nul

set "REPO=\\nas\Cookapps Project\ON_AIR_UA\PlayableAdPlayer"
set "GIT=\\nas\Cookapps Project\ON_AIR_UA\기타\PortableGit\bin\git.exe"
set "LOG=%TEMP%\uploadbutton_last.log"

del "%LOG%" >nul 2>nul

rem git.exe 존재 확인
if not exist "%GIT%" (
  mshta "javascript:var sh=new ActiveXObject('WScript.Shell');sh.Popup('[오류] git.exe를 찾을 수 없습니다.\n\n%GIT%',0,'실패',16);close();"
  exit /b 1
)

rem UNC는 pushd로 드라이브 매핑해서 들어감
pushd "%REPO%" >>"%LOG%" 2>&1
if errorlevel 1 (
  mshta "javascript:var sh=new ActiveXObject('WScript.Shell');sh.Popup('[오류] 리포지토리 폴더 접근 실패',0,'실패',16);close();"
  start "" notepad "%LOG%"
  exit /b 1
)

if not exist ".git" (
  echo Not a git repository: %CD%>>"%LOG%"
  popd
  mshta "javascript:var sh=new ActiveXObject('WScript.Shell');sh.Popup('[오류] Git 리포지토리가 아닙니다.\n\n%REPO%',0,'실패',16);close();"
  start "" notepad "%LOG%"
  exit /b 1
)

rem 변경 없으면 종료
"%GIT%" status --porcelain > "%TEMP%\__st.txt" 2>>"%LOG%"
for %%A in ("%TEMP%\__st.txt") do if %%~zA==0 (
  del "%TEMP%\__st.txt" >nul 2>nul
  popd
  mshta "javascript:var sh=new ActiveXObject('WScript.Shell');sh.Popup('변경사항이 없습니다.\n\n업로드할 내용이 없어요!',0,'안내',64);close();"
  exit /b 0
)
del "%TEMP%\__st.txt" >nul 2>nul

echo ==== %DATE% %TIME% ====>>"%LOG%"
echo [ADD]>>"%LOG%"
"%GIT%" add -A >>"%LOG%" 2>&1
if errorlevel 1 goto :FAIL

echo [COMMIT]>>"%LOG%"
"%GIT%" commit -m "파일 업로드 %date% %time:~0,5%" >>"%LOG%" 2>&1
if errorlevel 1 goto :FAIL

echo [PUSH]>>"%LOG%"
"%GIT%" push >>"%LOG%" 2>&1
if errorlevel 1 goto :FAIL

popd
mshta "javascript:var sh=new ActiveXObject('WScript.Shell');sh.Popup('업로드가 완료되었습니다! द्दि(｡•̀ ᗜ<)\n\n업데이트는 1~2분 정도 소요됩니다.\n잠시만 기다려주세요!',0,'완료',64);close();"
exit /b 0

:FAIL
popd
mshta "javascript:var sh=new ActiveXObject('WScript.Shell');sh.Popup('[오류] 업로드 실패\n\n로그 파일을 열어드릴게요.',0,'실패',16);close();"
start "" notepad "%LOG%"
exit /b 1
