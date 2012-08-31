// Action script...

// [Initial MovieClip Action of sprite 998]
#initclip 215
class dofus.graphics.gapi.ui.NpcDialog extends ank.gapi.core.UIAdvancedComponent
{
    var _nNpcID, __get__id, _sName, __get__name, _sGfx, __get__gfx, api, addToQueue, gapi, getStyle, _ldrArtwork, _winBackgroundUp, _oQuestion, _qvQuestionViewer, _mcQuestionViewer, attachMovie, _winBackground, __set__gfx, __set__id, __set__name;
    function NpcDialog()
    {
        super();
    } // End of the function
    function set id(nNpcID)
    {
        _nNpcID = nNpcID;
        //return (this.id());
        null;
    } // End of the function
    function set name(sName)
    {
        _sName = sName;
        //return (this.name());
        null;
    } // End of the function
    function set gfx(sGfx)
    {
        _sGfx = sGfx;
        //return (this.gfx());
        null;
    } // End of the function
    function init()
    {
        super.init(false, dofus.graphics.gapi.ui.NpcDialog.CLASS_NAME);
    } // End of the function
    function callClose()
    {
        api.network.Dialog.leave();
        return (true);
    } // End of the function
    function createChildren()
    {
        this.addToQueue({object: this, method: setNpcCharacteristics});
        gapi.unloadLastUIAutoHideComponent();
    } // End of the function
    function draw()
    {
        var _loc2 = this.getStyle();
    } // End of the function
    function setNpcCharacteristics()
    {
        _ldrArtwork.__set__contentPath(dofus.Constants.ARTWORKS_BIG_PATH + _sGfx + ".swf");
        _winBackgroundUp.__set__title(_sName);
    } // End of the function
    function setQuestion(oQuestion)
    {
        _oQuestion = oQuestion;
        if (_qvQuestionViewer == undefined)
        {
            this.attachMovie("QuestionViewer", "_qvQuestionViewer", 10, {_x: _mcQuestionViewer._x, _y: _mcQuestionViewer._y, question: oQuestion, isFirstQuestion: _bFirstQuestion});
            _qvQuestionViewer.addEventListener("response", this);
            _qvQuestionViewer.addEventListener("resize", this);
        }
        else
        {
            _qvQuestionViewer.__set__isFirstQuestion(_bFirstQuestion);
            _qvQuestionViewer.__set__question(oQuestion);
        } // end else if
    } // End of the function
    function closeDialog()
    {
        this.callClose();
    } // End of the function
    function response(oEvent)
    {
        if (oEvent.response.id == -1)
        {
            api.network.Dialog.begining(_nNpcID);
            _bFirstQuestion = true;
        }
        else
        {
            api.network.Dialog.response(_oQuestion.__get__id(), oEvent.response.id);
            _bFirstQuestion = false;
        } // end else if
    } // End of the function
    function resize(oEvent)
    {
        _winBackground.setSize(undefined, oEvent.target.height + (oEvent.target._y - _winBackground._y) + 12);
        _winBackgroundUp.setSize(undefined, oEvent.target.height + (oEvent.target._y - _winBackground._y) + 10);
    } // End of the function
    static var CLASS_NAME = "NpcDialog";
    var _bFirstQuestion = true;
} // End of Class
#endinitclip
