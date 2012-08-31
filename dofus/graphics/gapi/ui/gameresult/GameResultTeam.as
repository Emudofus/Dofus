// Action script...

// [Initial MovieClip Action of sprite 1001]
#initclip 218
class dofus.graphics.gapi.ui.gameresult.GameResultTeam extends ank.gapi.core.UIAdvancedComponent
{
    var _sTitle, __get__title, _eaDataProvider, __get__dataProvider, addToQueue, _lstPlayers, _lblWinLoose, api, _lblName, _lblLevel, _lblKama, _lblXP, _lblItems, __set__dataProvider, __set__title;
    function GameResultTeam()
    {
        super();
    } // End of the function
    function set title(sTitle)
    {
        _sTitle = sTitle;
        //return (this.title());
        null;
    } // End of the function
    function set dataProvider(eaDataProvider)
    {
        _eaDataProvider = eaDataProvider;
        //return (this.dataProvider());
        null;
    } // End of the function
    function init()
    {
        super.init(false, dofus.graphics.gapi.ui.gameresult.GameResultTeam.CLASS_NAME);
    } // End of the function
    function createChildren()
    {
        this.addToQueue({object: this, method: initTexts});
        this.addToQueue({object: this, method: initData});
        _lstPlayers._visible = false;
    } // End of the function
    function initTexts()
    {
        _lblWinLoose.__set__text(_sTitle);
        _lblName.__set__text(api.lang.getText("NAME_BIG"));
        _lblLevel.__set__text(api.lang.getText("LEVEL_SMALL"));
        _lblKama.__set__text(api.lang.getText("KAMAS"));
        _lblXP.__set__text(api.lang.getText("EXPERIMENT"));
        _lblItems.__set__text(api.lang.getText("WIN_ITEMS"));
    } // End of the function
    function initData()
    {
        var _loc2 = _eaDataProvider.length;
        _lstPlayers.__set__dataProvider(_eaDataProvider);
        _lstPlayers.setSize(undefined, Math.min(_loc2, dofus.graphics.gapi.ui.GameResult.MAX_VISIBLE_PLAYERS_IN_TEAM) * _lstPlayers.__get__rowHeight());
        _lstPlayers._visible = true;
    } // End of the function
    static var CLASS_NAME = "GameResultTeam";
} // End of Class
#endinitclip
