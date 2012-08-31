// Action script...

// [Initial MovieClip Action of sprite 1050]
#initclip 17
class dofus.graphics.gapi.ui.DocumentRoadSign extends ank.gapi.core.UIAdvancedComponent
{
    var _oDoc, __get__document, api, _txtCore, addToQueue, _mcSmall, _btnClose, _bgHidder, _lblTitle, owner, __set__document;
    function DocumentRoadSign()
    {
        super();
    } // End of the function
    function set document(oDoc)
    {
        _oDoc = oDoc;
        //return (this.document());
        null;
    } // End of the function
    function init()
    {
        super.init(false, dofus.graphics.gapi.ui.DocumentRoadSign.CLASS_NAME);
    } // End of the function
    function callClose()
    {
        api.network.Documents.leave();
        return (true);
    } // End of the function
    function createChildren()
    {
        _txtCore.wordWrap = true;
        _txtCore.multiline = true;
        _txtCore.embedFonts = true;
        this.addToQueue({object: this, method: addListeners});
        this.addToQueue({object: this, method: updateData});
        _mcSmall._visible = false;
    } // End of the function
    function addListeners()
    {
        _btnClose.addEventListener("click", this);
        _bgHidder.addEventListener("click", this);
    } // End of the function
    function updateData()
    {
        this.setCssStyle(_oDoc.getPage(0).cssFile);
        if (_oDoc.title.substr(0, 2) == "//")
        {
            _mcSmall._visible = false;
            _lblTitle.__set__text("");
        }
        else
        {
            _mcSmall._visible = true;
            _lblTitle.__set__text(_oDoc.title);
        } // end else if
    } // End of the function
    function setCssStyle(sCssFile)
    {
        var _loc2 = new TextField.StyleSheet();
        _loc2.owner = this;
        _loc2.onLoad = function ()
        {
            owner.layoutContent(this);
        };
        _loc2.load(sCssFile);
    } // End of the function
    function layoutContent(ssStyle)
    {
        _txtCore.styleSheet = ssStyle;
        _txtCore.htmlText = _oDoc.getPage(0).text;
    } // End of the function
    function click(oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_bgHidder":
            case "_btnClose":
            {
                this.callClose();
                break;
            } 
        } // End of switch
    } // End of the function
    static var CLASS_NAME = "DocumentRoadSign";
} // End of Class
#endinitclip
