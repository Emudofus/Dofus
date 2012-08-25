// Action script...

// [Initial MovieClip Action of sprite 20733]
#initclip 254
if (!dofus.graphics.gapi.ui.fightsinfos.FightsInfosFightItem)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.graphics)
    {
        _global.dofus.graphics = new Object();
    } // end if
    if (!dofus.graphics.gapi)
    {
        _global.dofus.graphics.gapi = new Object();
    } // end if
    if (!dofus.graphics.gapi.ui)
    {
        _global.dofus.graphics.gapi.ui = new Object();
    } // end if
    if (!dofus.graphics.gapi.ui.fightsinfos)
    {
        _global.dofus.graphics.gapi.ui.fightsinfos = new Object();
    } // end if
    var _loc1 = (_global.dofus.graphics.gapi.ui.fightsinfos.FightsInfosFightItem = function ()
    {
        super();
    }).prototype;
    _loc1.__set__list = function (mcList)
    {
        this._mcList = mcList;
        //return (this.list());
    };
    _loc1.setValue = function (bUsed, sSuggested, oItem)
    {
        if (bUsed)
        {
            this._ldrIconTeam1.contentPath = oItem.team1IconFile;
            this._lblTeam1Count.text = oItem.team1Count;
            this._ldrIconTeam2.contentPath = oItem.team2IconFile;
            this._lblTeam2Count.text = oItem.team2Count;
            this._lblTime.text = oItem.durationString;
            this._mcArrows._visible = true;
        }
        else if (this._lblTeam1Count.text != undefined)
        {
            this._ldrIconTeam1.contentPath = "";
            this._lblTeam1Count.text = "";
            this._ldrIconTeam2.contentPath = "";
            this._lblTeam2Count.text = "";
            this._lblTime.text = "";
            this._mcArrows._visible = false;
        } // end else if
    };
    _loc1.init = function ()
    {
        super.init(false);
        this._mcArrows._visible = false;
        this._mcList.gapi.api.colors.addSprite(this._ldrIconTeam1, {color1: dofus.Constants.TEAMS_COLOR[0]});
        this._mcList.gapi.api.colors.addSprite(this._ldrIconTeam2, {color1: dofus.Constants.TEAMS_COLOR[1]});
    };
    _loc1.addProperty("list", function ()
    {
    }, _loc1.__set__list);
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
