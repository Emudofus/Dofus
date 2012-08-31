// Action script...

// [Initial MovieClip Action of sprite 1056]
#initclip 23
class dofus.graphics.gapi.ui.ServersManagerRetry extends ank.gapi.core.UIAdvancedComponent
{
    var __get__initialized, __get__timer, api, _lblCounter, _lblCounterShadow, addToQueue, __set__timer;
    function ServersManagerRetry()
    {
        super();
    } // End of the function
    function set timer(nTimer)
    {
        _nTimer = Number(nTimer);
        if (this.__get__initialized())
        {
            this.updateLabel();
        } // end if
        //return (this.timer());
        null;
    } // End of the function
    function updateLabel()
    {
        var _loc2 = api.lang.getText("SERVERS_MANAGER_RETRY", [_nTimer]);
        _lblCounter.__set__text(_loc2);
        _lblCounterShadow.__set__text(_loc2);
    } // End of the function
    function init()
    {
        super.init(false, dofus.graphics.gapi.ui.ServersManagerRetry.CLASS_NAME);
    } // End of the function
    function createChildren()
    {
        this.addToQueue({object: this, method: updateLabel});
    } // End of the function
    static var CLASS_NAME = "ServersManagerRetry";
    var _nTimer = 0;
} // End of Class
#endinitclip
