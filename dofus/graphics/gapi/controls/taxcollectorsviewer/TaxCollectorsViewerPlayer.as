// Action script...

// [Initial MovieClip Action of sprite 1079]
#initclip 49
class dofus.graphics.gapi.controls.taxcollectorsviewer.TaxCollectorsViewerPlayer extends ank.gapi.core.UIBasicComponent
{
    var _oData, addToQueue, __get__data, _ldrSprite, __set__data;
    function TaxCollectorsViewerPlayer()
    {
        super();
    } // End of the function
    function set data(oData)
    {
        if (oData != _oData)
        {
            _oData = oData;
            this.addToQueue({object: this, method: setSprite});
        } // end if
        //return (this.data());
        null;
    } // End of the function
    function init()
    {
        super.init(false);
    } // End of the function
    function createChildren()
    {
        this.addToQueue({object: this, method: addListeners});
    } // End of the function
    function addListeners()
    {
        _ldrSprite.addEventListener("initialization", this);
    } // End of the function
    function setSprite()
    {
        _ldrSprite.__set__contentPath(_oData.gfxFile == undefined ? ("") : (_oData.gfxFile));
    } // End of the function
    function initialization(oEvent)
    {
        var _loc3 = oEvent.clip;
        _global.GAC.addSprite(_loc3, _oData);
        _loc3.attachMovie("staticR", "mcAnim", 10);
        _loc3._xscale = -80;
        _loc3._yscale = 80;
    } // End of the function
} // End of Class
#endinitclip
