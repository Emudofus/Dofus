// Action script...

// [Initial MovieClip Action of sprite 1051]
#initclip 18
class dofus.graphics.gapi.ui.FightsInfos extends ank.gapi.core.UIAdvancedComponent
{
    var _eaFights, _oSelectedFight, unloadThis, addToQueue, api, _mcSquare1, setMovieClipColor, _mcSquare2, _btnClose2, _btnJoin, _winBg, _dgFights, _lblPlayers, _txtSelectFight, _lblTeam1Level, _lblTeam2Level, _btnClose, _lstTeam1, _lstTeam2, _mcBackTeam, __get__fights;
    function FightsInfos()
    {
        super();
    } // End of the function
    function get fights()
    {
        return (_eaFights);
    } // End of the function
    function addFightTeams(nFightID, eaTeam1, eaTeam2)
    {
        var _loc3;
        var _loc2 = _eaFights.findFirstItem("id", nFightID);
        if (_loc2.index != -1)
        {
            _loc3 = _loc2.item;
        } // end if
        _loc3.addPlayers(1, eaTeam1);
        _loc3.addPlayers(2, eaTeam2);
        this.showTeamInfos(true, _oSelectedFight);
    } // End of the function
    function init()
    {
        super.init(false, dofus.graphics.gapi.ui.FightsInfos.CLASS_NAME);
    } // End of the function
    function callClose()
    {
        this.unloadThis();
        return (true);
    } // End of the function
    function createChildren()
    {
        _eaFights = new ank.utils.ExtendedArray();
        this.showTeamInfos(false);
        this.addToQueue({object: this, method: initTexts});
        this.addToQueue({object: this, method: addListeners});
        this.addToQueue({object: this, method: initData});
        this.addToQueue({object: api.network.Fights, method: api.network.Fights.getList});
        this.setMovieClipColor(_mcSquare1, dofus.Constants.TEAMS_COLOR[0]);
        this.setMovieClipColor(_mcSquare2, dofus.Constants.TEAMS_COLOR[1]);
    } // End of the function
    function initTexts()
    {
        _btnClose2.__set__label(api.lang.getText("CLOSE"));
        _btnJoin.__set__label(api.lang.getText("JOIN_SMALL"));
        _winBg.__set__title(api.lang.getText("CURRENT_FIGTHS"));
        _dgFights.__set__columnsNames([api.lang.getText("FIGHTERS_COUNT"), api.lang.getText("DURATION")]);
        _lblPlayers.__set__text(api.lang.getText("FIGHTERS"));
        _txtSelectFight.__set__text(api.lang.getText("SELECT_FIGHT_FOR_SPECTATOR"));
        _lblTeam1Level.__set__text("");
        _lblTeam2Level.__set__text("");
    } // End of the function
    function addListeners()
    {
        _btnClose.addEventListener("click", this);
        _btnClose2.addEventListener("click", this);
        _btnJoin.addEventListener("click", this);
        _dgFights.addEventListener("itemSelected", this);
    } // End of the function
    function initData()
    {
        _dgFights.__set__dataProvider(_eaFights);
    } // End of the function
    function showTeamInfos(bShow, oFight)
    {
        _lblTeam1Level._visible = bShow;
        _lblTeam2Level._visible = bShow;
        _lstTeam1._visible = bShow;
        _lstTeam2._visible = bShow;
        _mcBackTeam._visible = bShow;
        _mcSquare1._visible = bShow;
        _mcSquare2._visible = bShow;
        _txtSelectFight._visible = !bShow;
        _btnJoin.__set__enabled(bShow);
        if (bShow)
        {
            _lblTeam1Level.__set__text(api.lang.getText("LEVEL") + " " + oFight.__get__team1Level());
            _lblTeam2Level.__set__text(api.lang.getText("LEVEL") + " " + oFight.__get__team2Level());
            _lstTeam1.__set__dataProvider(oFight.team1Players);
            _lstTeam2.__set__dataProvider(oFight.team2Players);
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
            case "_btnJoin":
            {
                api.network.GameActions.joinChallenge(_oSelectedFight.__get__id());
                this.callClose();
                break;
            } 
        } // End of switch
    } // End of the function
    function itemSelected(oEvent)
    {
        _oSelectedFight = oEvent.target.item;
        if (_oSelectedFight.__get__hasTeamPlayers())
        {
            this.showTeamInfos(true, _oSelectedFight);
        }
        else
        {
            api.network.Fights.getDetails(_oSelectedFight.__get__id());
            this.showTeamInfos(false);
        } // end else if
    } // End of the function
    static var CLASS_NAME = "FightsInfos";
} // End of Class
#endinitclip
