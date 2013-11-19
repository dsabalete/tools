@ECHO OFF
FOR /R %%G IN (*.m4a) DO (CALL :SUB_VLC "%%G")
FOR /R %%G IN (*.m4a.mp*) DO (CALL :SUB_RENAME "%%G")
GOTO :eof

:SUB_VLC
 SET VLC_HOME="C:\Archivos de programa\VideoLAN\VLC\vlc"
 SET _firstbit=%1
 SET _qt="
 CALL SET _newnm=%%_firstbit:%_qt%=%%
 SET _commanm=%_newnm:,=_COMMA_%
 REM echo %_commanm%
 CALL %VLC_HOME% -I dummy -vvv %1 --sout=#transcode{acodec="mpga",ab="192","channels=2"}:standard{access="file",mux="raw",dst="%_commanm%.mp3"} vlc://quit
GOTO :eof

:SUB_RENAME
 SET _origfnm=%1
 SET _endbit=%_origfnm:*.m4a=%
 CALL SET _newfilenm=%%_origfnm:.m4a%_endbit%=.mp3%%
 SET _newfilenm=%_newfilenm:_COMMA_=,%
 COPY %1 %_newfilenm%
 DEL %1
GOTO :eof

:eof
