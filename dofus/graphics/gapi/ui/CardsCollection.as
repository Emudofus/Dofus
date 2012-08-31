// Action script...

// [Initial MovieClip Action of sprite 1053]
#initclip 20
class dofus.graphics.gapi.ui.CardsCollection extends ank.gapi.core.UIAdvancedComponent
{
    var gapi, unloadThis, addToQueue, _btnClose, _ctr1, _ctr2, _ctr3, _ctr4, _ctr5, _ctr6, _ctrMain;
    function CardsCollection()
    {
        super();
    } // End of the function
    function init()
    {
        super.init(false, dofus.graphics.gapi.ui.CardsCollection.CLASS_NAME);
    } // End of the function
    function destroy()
    {
        gapi.hideTooltip();
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
    } // End of the function
    function initTexts()
    {
    } // End of the function
    function addListeners()
    {
        _btnClose.addEventListener("click", this);
        for (var _loc3 = 1; _loc3 <= 9; ++_loc3)
        {
            var _loc2 = this["_ctr" + _loc3];
            _loc2.addEventListener("click", this);
            _loc2.addEventListener("over", this);
            _loc2.addEventListener("out", this);
        } // end of for
    } // End of the function
    function initData()
    {
        _ctr1.__set__contentData({iconFile: "Card", params: {name: "La carte", background: 0, gfxFile: dofus.Constants.ARTWORKS_BIG_PATH + (random(150) + 1000) + ".swf"}});
        _ctr2.__set__contentData({iconFile: "Card", params: {name: "Une autre carte", background: 1, gfxFile: dofus.Constants.ARTWORKS_BIG_PATH + (random(150) + 1000) + ".swf"}});
        _ctr3.__set__contentData({iconFile: "Card", params: {name: "Le monstre", background: 2, gfxFile: dofus.Constants.ARTWORKS_BIG_PATH + (random(150) + 1000) + ".swf"}});
        _ctr4.__set__contentData({iconFile: "Card", params: {name: "Lee", background: 3, gfxFile: dofus.Constants.ARTWORKS_BIG_PATH + (random(150) + 1000) + ".swf"}});
        _ctr5.__set__contentData({iconFile: "Card", params: {name: "Gross", background: 4, gfxFile: dofus.Constants.ARTWORKS_BIG_PATH + (random(150) + 1000) + ".swf"}});
        _ctr6.__set__contentData({iconFile: "Card", params: {name: "Monster", background: 5, gfxFile: dofus.Constants.ARTWORKS_BIG_PATH + (random(150) + 1000) + ".swf"}});
    } // End of the function
    function click(oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_btnClose":
            {
                this.callClose();
                break;
            } 
            case "_ctr1":
            case "_ctr2":
            case "_ctr3":
            case "_ctr4":
            case "_ctr5":
            case "_ctr6":
            case "_ctr7":
            case "_ctr8":
            case "_ctr9":
            {
                var _loc2 = oEvent.target.contentData;
                if (_loc2 != undefined)
                {
                    _ctrMain.forceNextLoad();
                    _ctrMain.__set__contentData(_loc2);
                } // end if
                break;
            } 
        } // End of switch
    } // End of the function
    static var CLASS_NAME = "CardsCollection";
} // End of Class
#endinitclip
