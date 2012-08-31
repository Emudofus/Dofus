// Action script...

// [Initial MovieClip Action of sprite 1086]
#initclip 56
class dofus.graphics.gapi.ui.fightsinfos.FightsInfosFightItem extends ank.gapi.core.UIBasicComponent
{
    var _mcList, __get__list, _ldrIconTeam1, _lblTeam1Count, _ldrIconTeam2, _lblTeam2Count, _lblTime, _mcArrows, __set__list;
    function FightsInfosFightItem()
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
            _ldrIconTeam1.__set__contentPath(oItem.team1IconFile);
            _lblTeam1Count.__set__text(oItem.team1Count);
            _ldrIconTeam2.__set__contentPath(oItem.team2IconFile);
            _lblTeam2Count.__set__text(oItem.team2Count);
            _lblTime.__set__text(oItem.durationString);
            _mcArrows._visible = true;
        }
        else
        {
            _ldrIconTeam1.__set__contentPath("");
            _lblTeam1Count.__set__text("");
            _ldrIconTeam2.__set__contentPath("");
            _lblTeam2Count.__set__text("");
            _lblTime.__set__text("");
            _mcArrows._visible = false;
        } // end else if
    } // End of the function
    function init()
    {
        super.init(false);
        _mcList.gapi.api.colors.addSprite(_ldrIconTeam1, {color1: dofus.Constants.TEAMS_COLOR[0]});
        _mcList.gapi.api.colors.addSprite(_ldrIconTeam2, {color1: dofus.Constants.TEAMS_COLOR[1]});
    } // End of the function
} // End of Class
#endinitclip
