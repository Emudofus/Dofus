// Action script...

// [Initial MovieClip Action of sprite 1033]
#initclip 255
class dofus.graphics.gapi.controls.BannerSpriteInfos extends ank.gapi.core.UIAdvancedComponent
{
    var _oSprite, __get__data, addToQueue, _ldrSprite, api, _lblRes, _lblName, _lblLevel, _lblLP, _lblAP, _lblMP, _lblAverageDamages, _lblNeutral, _lblEarth, _lblFire, _lblWater, _lblAir, _lblDodgeAP, _lblDodgeMP, __set__data;
    function BannerSpriteInfos()
    {
        super();
    } // End of the function
    function set data(oData)
    {
        _oSprite = oData;
        //return (this.data());
        null;
    } // End of the function
    function init()
    {
        super.init(false, dofus.graphics.gapi.controls.BannerSpriteInfos.CLASS_NAME);
    } // End of the function
    function createChildren()
    {
        this.addToQueue({object: this, method: addListeners});
        this.addToQueue({object: this, method: initTexts});
        this.addToQueue({object: this, method: initData});
    } // End of the function
    function addListeners()
    {
        _ldrSprite.addEventListener("initialization", this);
    } // End of the function
    function initTexts()
    {
        _lblRes.__set__text(api.lang.getText("RESISTANCES"));
    } // End of the function
    function initData()
    {
        _lblName.__set__text(_oSprite.name);
        _lblLevel.__set__text(api.lang.getText("LEVEL") + " " + _oSprite.Level);
        _lblLP.__set__text(isNaN(_oSprite.LP) ? ("") : (_oSprite.LP));
        _lblAP.__set__text(isNaN(_oSprite.AP) ? ("") : (String(Math.max(0, _oSprite.AP))));
        _lblMP.__set__text(isNaN(_oSprite.MP) ? ("") : (String(Math.max(0, _oSprite.MP))));
        _lblAverageDamages.__set__text(_oSprite.averageDamages);
        _ldrSprite.__set__contentPath(_oSprite.artworkFile);
        var _loc2 = _oSprite.resistances;
        _lblNeutral.__set__text(_loc2[0] == undefined ? ("0%") : (_loc2[0] + "%"));
        _lblEarth.__set__text(_loc2[1] == undefined ? ("0%") : (_loc2[1] + "%"));
        _lblFire.__set__text(_loc2[2] == undefined ? ("0%") : (_loc2[2] + "%"));
        _lblWater.__set__text(_loc2[3] == undefined ? ("0%") : (_loc2[3] + "%"));
        _lblAir.__set__text(_loc2[4] == undefined ? ("0%") : (_loc2[4] + "%"));
        _lblDodgeAP.__set__text(_loc2[5] == undefined ? ("0%") : (_loc2[5] + "%"));
        _lblDodgeMP.__set__text(_loc2[6] == undefined ? ("0%") : (_loc2[6] + "%"));
    } // End of the function
    function initialization(oEvent)
    {
        var _loc3 = oEvent.target.content;
        var _loc2 = _loc3._mcMask;
        _loc3._x = -_loc2._x;
        _loc3._y = -_loc2._y;
        _ldrSprite._xscale = 10000 / _loc2._xscale;
        _ldrSprite._yscale = 10000 / _loc2._yscale;
    } // End of the function
    static var CLASS_NAME = "BannerSpriteInfos";
} // End of Class
#endinitclip
