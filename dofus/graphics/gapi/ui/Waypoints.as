// Action script...

// [Initial MovieClip Action of sprite 1046]
#initclip 13
class dofus.graphics.gapi.ui.Waypoints extends ank.gapi.core.UIAdvancedComponent
{
    var _eaData, __get__initialized, __get__data, api, addToQueue, _winBg, _lblCoords, _lblName, _lblCost, _lblRespawn, _lblDescription, _btnClose2, _btnClose, _lstWaypoints, __set__data;
    function Waypoints()
    {
        super();
    } // End of the function
    function set data(eaData)
    {
        _eaData = eaData;
        if (this.__get__initialized())
        {
            this.initData();
        } // end if
        //return (this.data());
        null;
    } // End of the function
    function init()
    {
        super.init(false, dofus.graphics.gapi.ui.Waypoints.CLASS_NAME);
    } // End of the function
    function callClose()
    {
        api.network.Waypoints.leave();
        return (true);
    } // End of the function
    function createChildren()
    {
        this.addToQueue({object: this, method: initTexts});
        this.addToQueue({object: this, method: addListeners});
        this.addToQueue({object: this, method: initData});
    } // End of the function
    function initTexts()
    {
        _winBg.__set__title(api.lang.getText("WAYPOINT_LIST"));
        _lblCoords.__set__text(api.lang.getText("COORDINATES_SMALL"));
        _lblName.__set__text(api.lang.getText("AREA") + " (" + api.lang.getText("SUBAREA") + ")");
        _lblCost.__set__text(api.lang.getText("COST"));
        _lblRespawn.__set__text(api.lang.getText("RESPAWN_SMALL"));
        _lblDescription.__set__text(api.lang.getText("CLICK_ON_WAYPOINT"));
        _btnClose2.__set__label(api.lang.getText("CLOSE"));
    } // End of the function
    function addListeners()
    {
        _btnClose.addEventListener("click", this);
        _btnClose2.addEventListener("click", this);
        _lstWaypoints.addEventListener("itemSelected", this);
    } // End of the function
    function initData()
    {
        if (_eaData != undefined)
        {
            _eaData.sortOn("fieldToSort", Array.CASEINSENSITIVE);
            _lstWaypoints.__set__dataProvider(_eaData);
        } // end if
    } // End of the function
    function click(oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_btnClose":
            case "_btnClose2":
            {
                this.callClose();
                break;
            } 
        } // End of switch
    } // End of the function
    function itemSelected(oEvent)
    {
        var _loc2 = oEvent.target.item;
        if (_loc2.isCurrent)
        {
            return;
        } // end if
        var _loc3 = _loc2.cost;
        if (api.datacenter.Player.Kama >= _loc3)
        {
            api.kernel.showMessage(undefined, api.lang.getText("DO_U_USE_WAYPOINT", [_loc2.name, _loc2.coordinates, _loc3]), "CAUTION_YESNO", {name: "Waypoint", listener: this, params: {waypointID: _loc2.id}});
        }
        else
        {
            api.kernel.showMessage(undefined, api.lang.getText("NOT_ENOUGH_RICH"), "ERROR_BOX");
        } // end else if
    } // End of the function
    function yes(oEvent)
    {
        api.network.Waypoints.use(oEvent.target.params.waypointID);
    } // End of the function
    static var CLASS_NAME = "Waypoints";
} // End of Class
#endinitclip
