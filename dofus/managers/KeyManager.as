// Action script...

// [Initial MovieClip Action of sprite 898]
#initclip 110
class dofus.managers.KeyManager extends dofus.utils.ApiElement
{
    var api;
    function KeyManager(oAPI)
    {
        super();
        this.initialize(oAPI);
    } // End of the function
    function initialize(oAPI)
    {
        super.initialize(oAPI);
        Key.addListener(this);
    } // End of the function
    function onKeyUp()
    {
        switch (Key.getCode())
        {
            case 27:
            {
                api.datacenter.Basics.gfx_canLaunch = false;
                if (!api.ui.removeCursor(true))
                {
                    if (api.ui.callCloseOnLastUI() == false)
                    {
                        api.ui.loadUIComponent("AskMainMenu", "AskMainMenu");
                    } // end if
                } // end if
                break;
            } 
            case 222:
            {
                if (Key.isDown(17))
                {
                    if (api.datacenter.Player.isAuthorized)
                    {
                        api.ui.loadUIComponent("Debug", "Debug", undefined, {bAlwaysOnTop: true});
                    } // end if
                } // end if
                break;
            } 
        } // End of switch
        if (Selection.getFocus() != undefined)
        {
            return;
        } // end if
        switch (Key.getCode())
        {
            case 49:
            {
                if (Key.isDown(16))
                {
                    api.kernel.OptionsManager.setOption("Grid");
                } // end if
                break;
            } 
            case 50:
            {
                if (Key.isDown(16))
                {
                    api.kernel.OptionsManager.setOption("Transparency", !api.gfx.bGhostView);
                } // end if
                break;
            } 
            case 51:
            {
                if (Key.isDown(16))
                {
                    api.kernel.OptionsManager.setOption("SpriteInfos");
                } // end if
                break;
            } 
            case 52:
            {
                if (Key.isDown(16))
                {
                    api.kernel.OptionsManager.setOption("MapInfos");
                } // end if
                break;
            } 
            case 53:
            {
                if (Key.isDown(16))
                {
                    api.kernel.OptionsManager.setOption("StringCourse");
                } // end if
                break;
            } 
            case 54:
            {
                if (Key.isDown(16))
                {
                    api.kernel.OptionsManager.setOption("Buff");
                } // end if
                break;
            } 
        } // End of switch
    } // End of the function
} // End of Class
#endinitclip
