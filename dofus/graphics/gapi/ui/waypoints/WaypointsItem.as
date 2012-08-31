// Action script...

// [Initial MovieClip Action of sprite 1081]
#initclip 51
class dofus.graphics.gapi.ui.waypoints.WaypointsItem extends ank.gapi.core.UIBasicComponent
{
    var _mcList, __get__list, _oItem, _lblCost, _lblCoords, _lblName, _mcRespawn, _mcCurrent, _btnLocate, addToQueue, __set__list;
    function WaypointsItem()
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
            _lblCost.__set__text(oItem.cost == 0 ? ("-") : (oItem.cost + "k"));
            _lblCoords.__set__text(oItem.coordinates);
            _lblName.__set__text(oItem.name);
            _mcRespawn._visible = oItem.isRespawn;
            _mcCurrent._visible = oItem.isCurrent;
            _btnLocate._visible = true;
        }
        else
        {
            _lblCost.__set__text("");
            _lblCoords.__set__text("");
            _lblName.__set__text("");
            _mcRespawn._visible = false;
            _mcCurrent._visible = false;
            _btnLocate._visible = false;
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
        _btnLocate.addEventListener("click", this);
    } // End of the function
    function click(oEvent)
    {
        _mcList.gapi.loadUIAutoHideComponent("MapExplorer", "MapExplorer", {mapID: _oItem.id});
    } // End of the function
} // End of Class
#endinitclip
