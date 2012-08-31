// Action script...

// [Initial MovieClip Action of sprite 983]
#initclip 200
class dofus.graphics.gapi.controls.SpouseViewer extends ank.gapi.core.UIAdvancedComponent
{
    var _oSpouse, __get__initialized, __get__spouse, addToQueue, _mcInFight, _btnJoin, api, _lblPosition, _winBg, _lblSpouse, _lblName, _ldrArtwork, _lblLevel, _lblArea, _lblCoordinates, __set__spouse;
    function SpouseViewer()
    {
        super();
    } // End of the function
    function set spouse(oSpouse)
    {
        _oSpouse = oSpouse;
        if (this.__get__initialized())
        {
            this.updateData();
        } // end if
        //return (this.spouse());
        null;
    } // End of the function
    function init()
    {
        super.init(false, dofus.graphics.gapi.controls.SpouseViewer.CLASS_NAME);
    } // End of the function
    function createChildren()
    {
        this.addToQueue({object: this, method: addListeners});
        this.addToQueue({object: this, method: initData});
        this.addToQueue({object: this, method: initTexts});
        _mcInFight._visible = false;
    } // End of the function
    function addListeners()
    {
        _btnJoin.addEventListener("click", this);
    } // End of the function
    function initData()
    {
        this.updateData();
    } // End of the function
    function initTexts()
    {
        _btnJoin.__set__label(api.lang.getText("JOIN_SMALL"));
        _lblPosition.__set__text(api.lang.getText("LOCALISATION"));
    } // End of the function
    function updateData()
    {
        if (_oSpouse != undefined)
        {
            _winBg.__set__title(ank.utils.PatternDecoder.combine(api.lang.getText("SPOUSE"), _oSpouse.sex, true) + " - " + api.lang.getText("FRIENDS"));
            _lblSpouse.__set__text(ank.utils.PatternDecoder.combine(api.lang.getText("SPOUSE"), _oSpouse.sex, true));
            _lblName.__set__text(_oSpouse.name);
            api.colors.addSprite(_ldrArtwork, _oSpouse);
            _ldrArtwork.__set__contentPath(dofus.Constants.GUILDS_FACES_PATH + _oSpouse.gfx + ".swf");
            if (_oSpouse.isConnected)
            {
                _mcInFight._visible = _oSpouse.isInFight;
                _lblLevel.__set__text(isNaN(_oSpouse.level) ? ("") : (api.lang.getText("LEVEL") + " " + _oSpouse.level));
                _lblArea.__set__text(api.kernel.MapsServersManager.getMapName(_oSpouse.mapID));
                _lblCoordinates.__set__text("");
                _btnJoin.__set__enabled(!api.datacenter.Game.isFight);
            }
            else
            {
                _mcInFight._visible = false;
                _lblLevel.__set__text("");
                _lblArea.__set__text(ank.utils.PatternDecoder.combine(api.lang.getText("SPOUSE_NOT_CONNECTED"), _oSpouse.sex, true));
                _lblCoordinates.__set__text("");
                _btnJoin.__set__enabled(false);
            } // end if
        } // end else if
    } // End of the function
    function click(oEvent)
    {
        if (!api.datacenter.Game.isFight)
        {
            api.network.Friends.join("S");
        } // end if
    } // End of the function
    static var CLASS_NAME = "SpouseViewer";
} // End of Class
#endinitclip
