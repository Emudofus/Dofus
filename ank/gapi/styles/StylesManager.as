// Action script...

// [Initial MovieClip Action of sprite 20682]
#initclip 203
if (!ank.gapi.styles.StylesManager)
{
    if (!ank)
    {
        _global.ank = new Object();
    } // end if
    if (!ank.gapi)
    {
        _global.ank.gapi = new Object();
    } // end if
    if (!ank.gapi.styles)
    {
        _global.ank.gapi.styles = new Object();
    } // end if
    var _loc1 = (_global.ank.gapi.styles.StylesManager = function ()
    {
        super();
    }).prototype;
    (_global.ank.gapi.styles.StylesManager = function ()
    {
        super();
    }).setStyle = function (sStyleName, oStyle)
    {
        if (!(oStyle instanceof Object))
        {
            return;
        } // end if
        if (sStyleName == undefined)
        {
            return;
        } // end if
        if (oStyle == undefined)
        {
            return;
        } // end if
        ank.gapi.styles.StylesManager._styles[sStyleName] = oStyle;
    };
    (_global.ank.gapi.styles.StylesManager = function ()
    {
        super();
    }).getStyle = function (sStyleName)
    {
        return (ank.gapi.styles.StylesManager._styles[sStyleName]);
    };
    (_global.ank.gapi.styles.StylesManager = function ()
    {
        super();
    }).loadStylePackage = function (oPackage)
    {
        for (var k in oPackage)
        {
            ank.gapi.styles.StylesManager.setStyle(k, oPackage[k]);
        } // end of for...in
    };
    ASSetPropFlags(_loc1, null, 1);
    (_global.ank.gapi.styles.StylesManager = function ()
    {
        super();
    })._styles = new Object();
} // end if
#endinitclip
