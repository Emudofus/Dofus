// Action script...

// [Initial MovieClip Action of sprite 1022]
#initclip 243
class dofus.graphics.gapi.controls.ClassInfosViewer extends ank.gapi.core.UIAdvancedComponent
{
    var _nClassID, addToQueue, __get__classID, api, _lblClassSpells, _txtDescription, _lblSpellName, _lblSpellRange, _lblSpellAP, _txtSpellDescription, _ldrSpellIcon, __set__classID;
    function ClassInfosViewer()
    {
        super();
    } // End of the function
    function set classID(nClassID)
    {
        _nClassID = nClassID;
        this.addToQueue({object: this, method: layoutContent});
        //return (this.classID());
        null;
    } // End of the function
    function init()
    {
        super.init(false, dofus.graphics.gapi.controls.ClassInfosViewer.CLASS_NAME);
    } // End of the function
    function createChildren()
    {
        this.addToQueue({object: this, method: initTexts});
        this.addToQueue({object: this, method: addListeners});
    } // End of the function
    function initTexts()
    {
        _lblClassSpells.__set__text(api.lang.getText("CLASS_SPELLS"));
    } // End of the function
    function addListeners()
    {
        for (var _loc2 = 0; _loc2 < 20; ++_loc2)
        {
            this["_ctr" + _loc2].addEventListener("over", this);
            this["_ctr" + _loc2].addEventListener("out", this);
        } // end of for
    } // End of the function
    function layoutContent()
    {
        var _loc6 = dofus.Constants.SPELLS_ICONS_PATH;
        var _loc4 = api.lang.getClassText(_nClassID).s;
        for (var _loc2 = 0; _loc2 < 20; ++_loc2)
        {
            var _loc3 = this["_ctr" + _loc2];
            _loc3.__set__contentPath(_loc6 + _loc4[_loc2] + ".swf");
            _loc3.__set__params({spellID: _loc4[_loc2]});
        } // end of for
        _txtDescription.__set__text(api.lang.getClassText(_nClassID).d);
        this.showSpellInfos(_loc4[0]);
    } // End of the function
    function showSpellInfos(nSpellID)
    {
        var _loc2 = api.kernel.CharactersManager.getSpellObjectFromData(nSpellID + "~1~");
        if (_loc2.name == undefined)
        {
            _lblSpellName.__set__text("");
            _lblSpellRange.__set__text("");
            _lblSpellAP.__set__text("");
            _txtSpellDescription.__set__text("");
            _ldrSpellIcon.__set__contentPath("");
        }
        else
        {
            _lblSpellName.__set__text(_loc2.name);
            _lblSpellRange.__set__text(api.lang.getText("RANGEFULL") + " : " + _loc2.rangeStr);
            _lblSpellAP.__set__text(api.lang.getText("ACTIONPOINTS") + " : " + _loc2.apCost);
            _txtSpellDescription.__set__text(_loc2.description + "\n" + _loc2.descriptionNormalHit);
            _ldrSpellIcon.__set__contentPath(_loc2.iconFile);
        } // end else if
    } // End of the function
    function over(oEvent)
    {
        this.showSpellInfos(oEvent.target.params.spellID);
    } // End of the function
    function out(oEvent)
    {
        this.showSpellInfos(api.lang.getClassText(_nClassID).s[0]);
    } // End of the function
    static var CLASS_NAME = "ClassInfosViewer";
} // End of Class
#endinitclip
