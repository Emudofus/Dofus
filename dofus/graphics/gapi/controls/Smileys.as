// Action script...

// [Initial MovieClip Action of sprite 1013]
#initclip 234
class dofus.graphics.gapi.controls.Smileys extends ank.gapi.core.UIAdvancedComponent
{
    var addToQueue, _cgSmileys, _cgEmotes, api, dispatchEvent, gapi;
    function Smileys()
    {
        super();
    } // End of the function
    function update()
    {
        this.initData();
    } // End of the function
    function init()
    {
        super.init(false, dofus.graphics.gapi.controls.Smileys.CLASS_NAME);
    } // End of the function
    function createChildren()
    {
        this.addToQueue({object: this, method: addListeners});
        this.addToQueue({object: this, method: initData});
    } // End of the function
    function addListeners()
    {
        _cgSmileys.addEventListener("selectItem", this);
        _cgEmotes.addEventListener("selectItem", this);
        _cgEmotes.addEventListener("overItem", this);
        _cgEmotes.addEventListener("outItem", this);
    } // End of the function
    function initData()
    {
        var _loc7 = new ank.utils.ExtendedArray();
        for (var _loc2 = 1; _loc2 <= 8; ++_loc2)
        {
            var _loc4 = new Object();
            _loc4.iconFile = dofus.Constants.SMILEYS_ICONS_PATH + _loc2 + ".swf";
            _loc4.index = _loc2;
            _loc7.push(_loc4);
        } // end of for
        _cgSmileys.__set__dataProvider(_loc7);
        var _loc6 = new ank.utils.ExtendedArray();
        var _loc8 = api.datacenter.Player.Emotes.getItems();
        for (var _loc9 in _loc8)
        {
            var _loc3 = new Object();
            var _loc5 = Number(_loc9);
            _loc3.iconFile = dofus.Constants.EMOTES_ICONS_PATH + _loc5 + ".swf";
            _loc3.index = _loc5;
            _loc6.push(_loc3);
            _loc6.sortOn("index", Array.NUMERIC);
        } // end of for...in
        _cgEmotes.__set__dataProvider(_loc6);
    } // End of the function
    function selectItem(oEvent)
    {
        var _loc2 = oEvent.target.contentData;
        if (_loc2 == undefined)
        {
            return;
        } // end if
        switch (oEvent.owner._name)
        {
            case "_cgSmileys":
            {
                this.dispatchEvent({type: "selectSmiley", index: _loc2.index});
                break;
            } 
            case "_cgEmotes":
            {
                this.dispatchEvent({type: "selectEmote", index: _loc2.index});
                break;
            } 
        } // End of switch
    } // End of the function
    function overItem(oEvent)
    {
        var _loc3 = oEvent.target.contentData;
        if (_loc3 != undefined)
        {
            var _loc2 = api.lang.getEmoteText(_loc3.index);
            var _loc4 = _loc2.n;
            var _loc5 = _loc2.s != undefined ? (" (/" + _loc2.s + ")") : ("");
            gapi.showTooltip(_loc4 + _loc5, oEvent.target, -20);
        } // end if
    } // End of the function
    function outItem(oEvent)
    {
        gapi.hideTooltip();
    } // End of the function
    static var CLASS_NAME = "Smileys";
} // End of Class
#endinitclip
