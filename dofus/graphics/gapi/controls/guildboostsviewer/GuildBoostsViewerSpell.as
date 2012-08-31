// Action script...

// [Initial MovieClip Action of sprite 1066]
#initclip 36
class dofus.graphics.gapi.controls.guildboostsviewer.GuildBoostsViewerSpell extends ank.gapi.core.UIBasicComponent
{
    var _mcList, __get__list, _oItem, _lblName, _lblLevel, _ldrIcon, _mcBorder, _mcBack, _btnBoost, setMovieClipTransform, _mcCross, addToQueue, __set__list;
    function GuildBoostsViewerSpell()
    {
        super();
    } // End of the function
    function set list(mcList)
    {
        _mcList = mcList;
        //return (this.list());
        null;
    } // End of the function
    function setValue(bUsed, sSuggested, oItem)
    {
        if (bUsed)
        {
            _oItem = oItem;
            _lblName.__set__text(oItem.name);
            _lblLevel.__set__text(oItem.level != 0 ? (oItem.level) : ("-"));
            _ldrIcon.__set__contentPath(oItem.iconFile);
            _mcBorder._visible = true;
            _mcBack._visible = true;
            var _loc3 = _mcList.gapi.api.datacenter.Player.guildInfos;
            _btnBoost._visible = _loc3.playerRights.canManageBoost && _loc3.canBoost("s", oItem.ID);
            if (oItem.level == 0)
            {
                this.setMovieClipTransform(_ldrIcon, dofus.graphics.gapi.controls.guildboostsviewer.GuildBoostsViewerSpell.COLOR_TRANSFORM);
                _mcCross._visible = true;
            }
            else
            {
                this.setMovieClipTransform(_ldrIcon, dofus.graphics.gapi.controls.guildboostsviewer.GuildBoostsViewerSpell.NO_COLOR_TRANSFORM);
                _mcCross._visible = false;
            } // end else if
        }
        else
        {
            _lblName.__set__text("");
            _lblLevel.__set__text("");
            _ldrIcon.__set__contentPath("");
            _mcBorder._visible = false;
            _mcBack._visible = false;
            _mcCross._visible = false;
            _btnBoost._visible = false;
            this.setMovieClipTransform(_ldrIcon, dofus.graphics.gapi.controls.guildboostsviewer.GuildBoostsViewerSpell.NO_COLOR_TRANSFORM);
        } // end else if
    } // End of the function
    function init()
    {
        super.init(false);
    } // End of the function
    function createChildren()
    {
        this.addToQueue({object: this, method: addListeners});
    } // End of the function
    function addListeners()
    {
        _btnBoost.addEventListener("click", this);
        _btnBoost.addEventListener("over", this);
        _btnBoost.addEventListener("out", this);
    } // End of the function
    function click(oEvent)
    {
        _mcList.gapi.api.network.Guild.boostSpell(_oItem.ID);
    } // End of the function
    function over(oEvent)
    {
        var _loc2 = _mcList.gapi.api;
        var _loc3 = _loc2.datacenter.Player.guildInfos.getBoostCostAndCountForCharacteristic("s", _oItem.ID);
        _mcList.gapi.showTooltip(_loc2.lang.getText("COST") + " : " + _loc3.cost, oEvent.target, -20);
    } // End of the function
    function out(oEvent)
    {
        _mcList.gapi.hideTooltip();
    } // End of the function
    static var COLOR_TRANSFORM = {ra: 60, rb: 0, ga: 60, gb: 0, ba: 60, bb: 0};
    static var NO_COLOR_TRANSFORM = {ra: 100, rb: 0, ga: 100, gb: 0, ba: 100, bb: 0};
} // End of Class
#endinitclip
