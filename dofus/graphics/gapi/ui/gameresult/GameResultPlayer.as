// Action script...

// [Initial MovieClip Action of sprite 1070]
#initclip 40
class dofus.graphics.gapi.ui.gameresult.GameResultPlayer extends ank.gapi.core.UIBasicComponent
{
    var _mcList, __get__list, _lblName, _pbXP, _lblWinXP, _lblKama, _lblLevel, _mcDeadHead, createEmptyMovieClip, _mcItemPlacer, _mcItems, __set__list;
    function GameResultPlayer()
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
            switch (oItem.type)
            {
                case "monster":
                case "taxcollector":
                case "player":
                {
                    _lblName.__set__text(oItem.name);
                    if (isNaN(oItem.xp))
                    {
                        _pbXP._visible = false;
                    }
                    else
                    {
                        _pbXP._visible = true;
                        _pbXP.__set__minimum(oItem.minxp);
                        _pbXP.__set__maximum(oItem.maxxp);
                        _pbXP.__set__value(oItem.xp);
                    } // end else if
                    _lblWinXP.__set__text(isNaN(oItem.winxp) ? ("") : (oItem.winxp));
                    _lblKama.__set__text(isNaN(oItem.kama) ? ("") : (oItem.kama));
                    _lblLevel.__set__text(oItem.level);
                    _mcDeadHead._visible = oItem.bDead;
                    this.createEmptyMovieClip("_mcItems", 10);
                    var _loc3 = oItem.items.length;
                    while (--_loc3 >= 0)
                    {
                        var _loc5 = oItem.items[_loc3];
                        var _loc2 = _mcItems.attachMovie("Container", "_ctrItem" + _loc3, _loc3, {_x: _mcItemPlacer._x + 25 * _loc3, _y: _mcItemPlacer._y + 1});
                        _loc2.setSize(18, 18);
                        _loc2.addEventListener("over", this);
                        _loc2.addEventListener("out", this);
                        _loc2.enabled = true;
                        _loc2.margin = 0;
                        _loc2.contentData = _loc5;
                    } // end while
                    break;
                } 
            } // End of switch
        }
        else
        {
            _pbXP._visible = false;
            _lblName.__set__text("");
            _pbXP.__set__minimum(0);
            _pbXP.__set__maximum(100);
            _pbXP.__set__value(random(99));
            _lblWinXP.__set__text("");
            _lblKama.__set__text("");
            _mcDeadHead._visible = false;
            _mcItems.removeMovieClip();
        } // end else if
    } // End of the function
    function init()
    {
        super.init(false);
        _mcItemPlacer._visible = false;
    } // End of the function
    function size()
    {
        super.size();
    } // End of the function
    function over(oEvent)
    {
        var _loc2 = oEvent.target.contentData;
        var _loc3 = _loc2.style + "ToolTip";
        _mcList.gapi.showTooltip("x" + _loc2.Quantity + " " + _loc2.name, oEvent.target, -20, undefined, _loc3);
    } // End of the function
    function out(oEvent)
    {
        _mcList.gapi.hideTooltip();
    } // End of the function
} // End of Class
#endinitclip
