// Action script...

// [Initial MovieClip Action of sprite 987]
#initclip 204
class ank.gapi.ui.FlyWindow extends ank.gapi.core.UIAdvancedComponent
{
    var _winBackground, addToQueue, __get__title, __get__contentPath, initWindowContent, __set__contentPath, __set__title;
    function FlyWindow()
    {
        super();
    } // End of the function
    function set title(sTitle)
    {
        this.addToQueue({object: this, method: function ()
        {
            _winBackground.title = sTitle;
        }});
        //return (this.title());
        null;
    } // End of the function
    function get title()
    {
        //return (_winBackground.title());
    } // End of the function
    function set contentPath(sContentPath)
    {
        this.addToQueue({object: this, method: function ()
        {
            _winBackground.contentPath = sContentPath;
        }});
        //return (this.contentPath());
        null;
    } // End of the function
    function get contentPath()
    {
        //return (_winBackground.contentPath());
    } // End of the function
    function init()
    {
        super.init(false, ank.gapi.ui.FlyWindow.CLASS_NAME);
    } // End of the function
    function createChildren()
    {
        this.addToQueue({object: this, method: addListeners});
    } // End of the function
    function addListeners()
    {
        _winBackground.addEventListener("complete", this);
    } // End of the function
    function complete(oEvent)
    {
        this.addToQueue({object: this, method: initWindowContent});
    } // End of the function
    static var CLASS_NAME = "FlyWindow";
} // End of Class
#endinitclip
