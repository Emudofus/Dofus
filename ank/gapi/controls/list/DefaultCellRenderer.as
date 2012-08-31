// Action script...

// [Initial MovieClip Action of sprite 177]
#initclip 14
class ank.gapi.controls.list.DefaultCellRenderer extends ank.gapi.core.UIBasicComponent
{
    var _lblText, getStyle, attachMovie, __height, __width;
    function DefaultCellRenderer()
    {
        super();
    } // End of the function
    function setState(sState)
    {
    } // End of the function
    function setValue(bUsed, sSuggested, oItem)
    {
        _lblText.__set__text(bUsed ? (sSuggested) : (""));
    } // End of the function
    function init()
    {
        super.init(false);
    } // End of the function
    function createChildren()
    {
        this.attachMovie("Label", "_lblText", 10, {styleName: this.getStyle().defaultstyle});
    } // End of the function
    function size()
    {
        super.size();
        _lblText.setSize(__width, __height);
    } // End of the function
    function draw()
    {
        var _loc2 = this.getStyle();
        _lblText.__set__styleName(_loc2.defaultstyle);
    } // End of the function
} // End of Class
#endinitclip
