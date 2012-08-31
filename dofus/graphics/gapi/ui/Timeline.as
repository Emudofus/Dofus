// Action script...

// [Initial MovieClip Action of sprite 978]
#initclip 192
class dofus.graphics.gapi.ui.Timeline extends ank.gapi.core.UIAdvancedComponent
{
    var _tl;
    function Timeline()
    {
        super();
    } // End of the function
    function update()
    {
        _tl.update();
    } // End of the function
    function nextTurn(id, bWithoutTween)
    {
        _tl.nextTurn(id, bWithoutTween);
    } // End of the function
    function hideItem(id)
    {
        _tl.hideItem(id);
    } // End of the function
    function startChrono(nDuration)
    {
        _tl.startChrono(nDuration);
    } // End of the function
    function stopChrono()
    {
        _tl.stopChrono();
    } // End of the function
    function init()
    {
        super.init(false, dofus.graphics.gapi.ui.Timeline.CLASS_NAME);
    } // End of the function
    function createChildren()
    {
    } // End of the function
    static var CLASS_NAME = "Timeline";
} // End of Class
#endinitclip
