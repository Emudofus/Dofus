// Action script...

// [Initial MovieClip Action of sprite 1000]
#initclip 217
class dofus.graphics.gapi.ui.GameResult extends ank.gapi.core.UIAdvancedComponent
{
    var _oData, __get__data, unloadThis, addToQueue, gapi, api, _winBackground, _btnClose, attachMovie, __set__data;
    function GameResult()
    {
        super();
    } // End of the function
    function set data(oData)
    {
        _oData = oData;
        //return (this.data());
        null;
    } // End of the function
    function init()
    {
        super.init(false, dofus.graphics.gapi.ui.GameResult.CLASS_NAME);
    } // End of the function
    function callClose()
    {
        this.unloadThis();
        return (true);
    } // End of the function
    function createChildren()
    {
        this.addToQueue({object: this, method: initTexts});
        this.addToQueue({object: this, method: addListeners});
        this.addToQueue({object: this, method: initData});
        gapi.unloadLastUIAutoHideComponent();
    } // End of the function
    function initTexts()
    {
        _winBackground.__set__title(api.lang.getText("GAME_RESULTS"));
        _btnClose.__set__label(api.lang.getText("CLOSE"));
    } // End of the function
    function addListeners()
    {
        _btnClose.addEventListener("click", this);
    } // End of the function
    function initData()
    {
        var _loc2 = _oData.winners.length;
        var _loc4 = _oData.loosers.length;
        var _loc10 = _loc2 + _loc4;
        var _loc8 = Math.min(_loc2, dofus.graphics.gapi.ui.GameResult.MAX_VISIBLE_PLAYERS_IN_TEAM) * 20 + 65 + Math.min(_loc4, dofus.graphics.gapi.ui.GameResult.MAX_VISIBLE_PLAYERS_IN_TEAM) * 20 + 65;
        var _loc3 = _loc8 + 32;
        var _loc7 = ((_loc10 > dofus.graphics.gapi.ui.GameResult.MAX_PLAYERS ? (550) : (gapi.screenHeight)) - _loc3) / 2;
        var _loc6 = _winBackground._x + 10;
        var _loc5 = _loc7 + 32;
        var _loc9 = Math.min(_loc2, dofus.graphics.gapi.ui.GameResult.MAX_VISIBLE_PLAYERS_IN_TEAM) * 20 + 55 + _loc5;
        this.attachMovie("UI_GameResultTeam", "_tWinners", 10, {dataProvider: _oData.winners, title: api.lang.getText("WINNERS"), _x: _loc6, _y: _loc5});
        this.attachMovie("UI_GameResultTeam", "_tLoosers", 20, {dataProvider: _oData.loosers, title: api.lang.getText("LOOSERS"), _x: _loc6, _y: _loc9});
        _winBackground._y = _loc7;
        _winBackground.setSize(undefined, _loc3);
        _btnClose._y = _winBackground._y + _winBackground._height;
    } // End of the function
    function click(oEvent)
    {
        this.callClose();
    } // End of the function
    static var CLASS_NAME = "GameResult";
    static var MAX_PLAYERS = 11;
    static var MAX_VISIBLE_PLAYERS_IN_TEAM = 8;
} // End of Class
#endinitclip
