// Action script...

// [Initial MovieClip Action of sprite 20784]
#initclip 49
if (!dofus.graphics.gapi.controls.QuestionViewer)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.graphics)
    {
        _global.dofus.graphics = new Object();
    } // end if
    if (!dofus.graphics.gapi)
    {
        _global.dofus.graphics.gapi = new Object();
    } // end if
    if (!dofus.graphics.gapi.controls)
    {
        _global.dofus.graphics.gapi.controls = new Object();
    } // end if
    var _loc1 = (_global.dofus.graphics.gapi.controls.QuestionViewer = function ()
    {
        super();
    }).prototype;
    _loc1.__set__question = function (oQuestion)
    {
        this._oQuestion = oQuestion;
        this.addToQueue({object: this, method: this.layoutContent});
        //return (this.question());
    };
    _loc1.__set__isFirstQuestion = function (bFirstQuestion)
    {
        this._bFirstQuestion = bFirstQuestion;
        //return (this.isFirstQuestion());
    };
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.controls.QuestionViewer.CLASS_NAME);
    };
    _loc1.createChildren = function ()
    {
        this._lstResponses._visible = false;
        this.addToQueue({object: this, method: this.addListeners});
    };
    _loc1.draw = function ()
    {
        var _loc2 = this.getStyle();
    };
    _loc1.layoutContent = function ()
    {
        if (this._bFirstQuestion)
        {
            var _loc2 = this._oQuestion.responses;
        }
        else if (this._oQuestion.responses.length == 0)
        {
            var _loc3 = new ank.utils.ExtendedArray();
            _loc3.push({label: this._parent.api.lang.getText("CONTINUE_TO_SPEAK"), id: -1});
            _loc2 = _loc3;
        }
        else
        {
            _loc2 = this._oQuestion.responses;
        } // end else if
        var _loc4 = _loc2.length;
        this._lstResponses.removeAll();
        this._lstResponses.setSize(undefined, dofus.graphics.gapi.controls.QuestionViewer.RESPONSE_HEIGHT * _loc4);
        this.addToQueue({object: this, method: this.addResponses, params: [_loc2]});
        this._txtQuestion.text = this._oQuestion.label;
    };
    _loc1.addListeners = function ()
    {
        this._lstResponses.addEventListener("itemSelected", this);
        this._txtQuestion.addEventListener("change", this);
    };
    _loc1.addResponses = function (eaResp)
    {
        this._lstResponses.dataProvider = eaResp;
    };
    _loc1.change = function (oEvent)
    {
        this._lstResponses._y = this._txtQuestion._y + dofus.graphics.gapi.controls.QuestionViewer.QUESTION_RESPONSE_SPACE + this._txtQuestion.height;
        this._lstResponses._visible = true;
        this.setSize(undefined, this._lstResponses._y + this._lstResponses.height);
        this.dispatchEvent({type: "resize"});
    };
    _loc1.itemSelected = function (oEvent)
    {
        this.dispatchEvent({type: "response", response: oEvent.row.item});
    };
    _loc1.addProperty("isFirstQuestion", function ()
    {
    }, _loc1.__set__isFirstQuestion);
    _loc1.addProperty("question", function ()
    {
    }, _loc1.__set__question);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.controls.QuestionViewer = function ()
    {
        super();
    }).CLASS_NAME = "QuestionViewer";
    (_global.dofus.graphics.gapi.controls.QuestionViewer = function ()
    {
        super();
    }).RESPONSE_HEIGHT = 30;
    (_global.dofus.graphics.gapi.controls.QuestionViewer = function ()
    {
        super();
    }).QUESTION_RESPONSE_SPACE = 20;
} // end if
#endinitclip
