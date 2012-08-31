// Action script...

// [Initial MovieClip Action of sprite 979]
#initclip 193
class dofus.graphics.gapi.ui.ChallengeMenu extends ank.gapi.core.UIAdvancedComponent
{
    var _sLabelReady, __get__labelReady, _sLabelCancel, __get__labelCancel, _bCancelButton, _btnCancel, _lblCancel, _mcBackground, _btnReady, _lblReady, _mcTick, __get__cancelButton, _bReady, __get__ready, addToQueue, api, __set__ready, __set__cancelButton, __set__labelCancel, __set__labelReady;
    function ChallengeMenu()
    {
        super();
    } // End of the function
    function set labelReady(sLabelReady)
    {
        _sLabelReady = sLabelReady;
        //return (this.labelReady());
        null;
    } // End of the function
    function set labelCancel(sLabelCancel)
    {
        _sLabelCancel = sLabelCancel;
        //return (this.labelCancel());
        null;
    } // End of the function
    function set cancelButton(bCancelButton)
    {
        _bCancelButton = bCancelButton;
        _btnCancel._visible = bCancelButton;
        _lblCancel._visible = bCancelButton;
        if (!bCancelButton)
        {
            _mcBackground._x = _mcBackground._x + dofus.graphics.gapi.ui.ChallengeMenu.X_OFFSET;
            _btnReady._x = _btnReady._x + dofus.graphics.gapi.ui.ChallengeMenu.X_OFFSET;
            _lblReady._x = _lblReady._x + dofus.graphics.gapi.ui.ChallengeMenu.X_OFFSET;
            _mcTick._x = _mcTick._x + dofus.graphics.gapi.ui.ChallengeMenu.X_OFFSET;
        } // end if
        //return (this.cancelButton());
        null;
    } // End of the function
    function set ready(bReady)
    {
        _bReady = bReady;
        _mcTick._visible = bReady;
        //return (this.ready());
        null;
    } // End of the function
    function init()
    {
        super.init(false, dofus.graphics.gapi.ui.ChallengeMenu.CLASS_NAME);
    } // End of the function
    function createChildren()
    {
        this.addToQueue({object: this, method: setLabels});
    } // End of the function
    function setLabels()
    {
        _lblReady.__set__text(_sLabelReady);
        if (_bCancelButton)
        {
            _lblCancel.__set__text(_sLabelCancel);
        } // end if
    } // End of the function
    function sendReadyState()
    {
        api.network.Game.ready(!_bReady);
        this.__set__ready(!_bReady);
    } // End of the function
    function sendCancel()
    {
        api.network.Game.leave();
    } // End of the function
    static var CLASS_NAME = "ChallengeMenu";
    static var X_OFFSET = 90;
} // End of Class
#endinitclip
