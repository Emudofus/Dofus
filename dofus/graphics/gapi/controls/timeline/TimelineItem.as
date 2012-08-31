// Action script...

// [Initial MovieClip Action of sprite 1060]
#initclip 29
class dofus.graphics.gapi.controls.timeline.TimelineItem extends ank.gapi.core.UIAdvancedComponent
{
    var _vcChrono, _ldrSprite, data, addToQueue, api, _mcBackRect, gapi, __get__chrono, __get__sprite;
    function TimelineItem()
    {
        super();
    } // End of the function
    function get chrono()
    {
        return (_vcChrono);
    } // End of the function
    function get sprite()
    {
        return (_ldrSprite);
    } // End of the function
    function init()
    {
        super.init(false, dofus.graphics.gapi.controls.timeline.TimelineItem.CLASS_NAME);
    } // End of the function
    function createChildren()
    {
        this.addToQueue({object: this, method: loadSprite, params: [data.gfxFile]});
    } // End of the function
    function loadSprite(sFile)
    {
        _ldrSprite.__set__contentPath(sFile);
        _ldrSprite.addEventListener("initialization", this);
        api.colors.addSprite(_ldrSprite, data);
    } // End of the function
    function onRollOver()
    {
        _mcBackRect._alpha = 50;
        data.mc.onRollOver();
        data.mc.showEffects(true);
    } // End of the function
    function onRollOut()
    {
        _mcBackRect._alpha = 100;
        data.mc.onRollOut();
        data.mc.showEffects(false);
    } // End of the function
    function onRelease()
    {
        var _loc2 = gapi.getUIComponent("PlayerInfos");
        var _loc4 = _loc2 != undefined && data != _loc2.data;
        gapi.loadUIComponent("PlayerInfos", "PlayerInfos", {data: data}, {bForceLoad: _loc4});
    } // End of the function
    function initialization(oEvent)
    {
        var _loc1 = oEvent.target.content;
        _loc1.attachMovie("staticR", "anim", 10);
        _loc1._x = 15;
        _loc1._y = 32;
        _loc1._xscale = -80;
        _loc1._yscale = 80;
    } // End of the function
    static var CLASS_NAME = "Timeline";
} // End of Class
#endinitclip
