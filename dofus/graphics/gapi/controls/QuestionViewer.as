// Action script...

// [Initial MovieClip Action of sprite 999]
#initclip 216
class dofus.graphics.gapi.controls.QuestionViewer extends ank.gapi.core.UIBasicComponent
{
    var _oQuestion, addToQueue, __get__question, _bFirstQuestion, __get__isFirstQuestion, _lstResponses, getStyle, _parent, _txtQuestion, setSize, dispatchEvent, __set__isFirstQuestion, __set__question;
    function QuestionViewer()
    {
        super();
    } // End of the function
    function set question(oQuestion)
    {
        _oQuestion = oQuestion;
        this.addToQueue({object: this, method: layoutContent});
        //return (this.question());
        null;
    } // End of the function
    function set isFirstQuestion(bFirstQuestion)
    {
        _bFirstQuestion = bFirstQuestion;
        //return (this.isFirstQuestion());
        null;
    } // End of the function
    function init()
    {
        super.init(false, dofus.graphics.gapi.controls.QuestionViewer.CLASS_NAME);
    } // End of the function
    function createChildren()
    {
        _lstResponses._visible = false;
        this.addToQueue({object: this, method: addListeners});
    } // End of the function
    function draw()
    {
        var _loc2 = this.getStyle();
    } // End of the function
    function layoutContent()
    {
        var _loc2;
        if (_bFirstQuestion)
        {
            _loc2 = _oQuestion.responses;
        }
        else if (_oQuestion.responses.length == 0)
        {
            var _loc3 = new ank.utils.ExtendedArray();
            _loc3.push({label: _parent.api.lang.getText("CONTINUE_TO_SPEAK"), id: -1});
            _loc2 = _loc3;
        }
        else
        {
            _loc2 = _oQuestion.responses;
        } // end else if
        var _loc4 = _loc2.length;
        _lstResponses.removeAll();
        _lstResponses.setSize(undefined, dofus.graphics.gapi.controls.QuestionViewer.RESPONSE_HEIGHT * _loc4);
        this.addToQueue({object: this, method: addResponses, params: [_loc2]});
        _txtQuestion.__set__text(_oQuestion.label);
    } // End of the function
    function addListeners()
    {
        _lstResponses.addEventListener("itemSelected", this);
        _txtQuestion.addEventListener("change", this);
    } // End of the function
    function addResponses(eaResp)
    {
        _lstResponses.__set__dataProvider(eaResp);
    } // End of the function
    function change(oEvent)
    {
        _lstResponses._y = _txtQuestion._y + dofus.graphics.gapi.controls.QuestionViewer.QUESTION_RESPONSE_SPACE + _txtQuestion.__get__height();
        _lstResponses._visible = true;
        this.setSize(undefined, _lstResponses._y + _lstResponses.__get__height());
        this.dispatchEvent({type: "resize"});
    } // End of the function
    function itemSelected(oEvent)
    {
        this.dispatchEvent({type: "response", response: oEvent.target.item});
    } // End of the function
    static var CLASS_NAME = "QuestionViewer";
    static var RESPONSE_HEIGHT = 30;
    static var QUESTION_RESPONSE_SPACE = 20;
} // End of Class
#endinitclip
