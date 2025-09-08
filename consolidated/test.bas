DIM a AS LONG
a = URLScreenShot("https://qb64.com", "1920x1080", "720")
SCREEN a
FUNCTION URLScreenShot& (website AS STRING, viewport AS STRING, imagewidth AS STRING)
    DIM URL AS STRING
    DIM URLFile AS STRING
    DIM URLshot AS STRING
    DIM a%
    URLFile = "urlshot.jpg"
    SHELL _HIDE "curl " + CHR$(34) + "http://api.screenshotlayer.com/api/capture?access_key=7f260b96e88dcf103ebba9c452e31b80&url=" + website + "&viewport=" + viewport + "&width=" + imagewidth + CHR$(34) + " -o " + URLFile
    OPEN URLFile FOR BINARY AS #1
    IF LOF(1) <> 0 THEN
        URLScreenShot = _LOADIMAGE(URLFile, 32)
        CLOSE #1
        KILL URLFile
    ELSE
        CLOSE #1
        KILL URLFile
    END IF
END FUNCTION