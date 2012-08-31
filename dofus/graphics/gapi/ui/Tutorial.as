// Action script...

// [Initial MovieClip Action of sprite 1005]
#initclip 222
class dofus.graphics.gapi.ui.Tutorial extends ank.gapi.core.UIAdvancedComponent
{
    var addToQueue, _btnCancel, api, gapi;
    function Tutorial()
    {
        super();
    } // End of the function
    function init()
    {
        super.init(false, dofus.graphics.gapi.ui.Tutorial.CLASS_NAME);
    } // End of the function
    function createChildren()
    {
        this.addToQueue({object: this, method: addListeners});
    } // End of the function
    function addListeners()
    {
        _btnCancel.addEventListener("click", this);
        _btnCancel.addEventListener("over", this);
        _btnCancel.addEventListener("out", this);
    } // End of the function
    function click(oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_btnCancel":
            {
                api.kernel.showMessage(undefined, api.lang.getText("LEAVE_TUTORIAL"), "CAUTION_YESNO", {name: "Tutorial", listener: this});
                break;
            } 
        } // End of switch
    } // End of the function
    function over(oEvent)
    {
        gapi.showTooltip(api.lang.getText("CANCEL_TUTORIAL"), oEvent.target, -20);
    } // End of the function
    function out(oEvent)
    {
        gapi.hideTooltip();
    } // End of the function
    function yes(oEvent)
    {
        api.kernel.TutorialManager.cancel();
    } // End of the function
    static var CLASS_NAME = "Tutorial";
} // End of Class
#endinitclip
