// Action script...

// [Initial MovieClip Action of sprite 20732]
#initclip 253
if (!dofus.graphics.gapi.ui.NpcDialog)
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
    if (!dofus.graphics.gapi.ui)
    {
        _global.dofus.graphics.gapi.ui = new Object();
    } // end if
    var _loc1 = (_global.dofus.graphics.gapi.ui.NpcDialog = function ()
    {
        super();
    }).prototype;
    _loc1.__set__id = function (nNpcID)
    {
        this._nNpcID = nNpcID;
        //return (this.id());
    };
    _loc1.__set__name = function (sName)
    {
        this._sName = sName;
        //return (this.name());
    };
    _loc1.__set__gfx = function (sGfx)
    {
        this._sGfx = sGfx;
        //return (this.gfx());
    };
    _loc1.__set__customArtwork = function (nGfx)
    {
        this._nCustomArtwork = nGfx;
        //return (this.customArtwork());
    };
    _loc1.__set__colors = function (aColors)
    {
        this._aColors = aColors;
        //return (this.colors());
    };
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.ui.NpcDialog.CLASS_NAME);
    };
    _loc1.callClose = function ()
    {
        this.api.network.Dialog.leave();
        return (true);
    };
    _loc1.createChildren = function ()
    {
        this.addToQueue({object: this, method: this.setNpcCharacteristics});
        this.gapi.unloadLastUIAutoHideComponent();
    };
    _loc1.draw = function ()
    {
        var _loc2 = this.getStyle();
    };
    _loc1.setNpcCharacteristics = function ()
    {
        this._mcPic._visible = false;
        this._ldrArtwork.addEventListener("initialization", this);
        this._ldrArtwork.addEventListener("complete", this);
        if (this._nCustomArtwork != undefined && (!_global.isNaN(this._nCustomArtwork) && this._nCustomArtwork > 0))
        {
            this._ldrArtwork.contentPath = dofus.Constants.ARTWORKS_BIG_PATH + this._nCustomArtwork + ".swf";
        }
        else
        {
            this._ldrArtwork.contentPath = dofus.Constants.ARTWORKS_BIG_PATH + this._sGfx + ".swf";
        } // end else if
        this._winBackgroundUp.title = this._sName;
    };
    _loc1.setPause = function ()
    {
        this.showElements(false);
    };
    _loc1.showElements = function (bShow)
    {
        this._ldrArtwork._visible = bShow;
        this._mcPic._visible = bShow;
        this._winBackground._visible = bShow;
        this._winBackgroundUp._visible = bShow;
        this._qvQuestionViewer._visible = bShow;
    };
    _loc1.setQuestion = function (oQuestion)
    {
        this._oQuestion = oQuestion;
        if (this._qvQuestionViewer == undefined)
        {
            this.attachMovie("QuestionViewer", "_qvQuestionViewer", 10, {_x: this._mcQuestionViewer._x, _y: this._mcQuestionViewer._y, question: oQuestion, isFirstQuestion: this._bFirstQuestion});
            this._qvQuestionViewer.addEventListener("response", this);
            this._qvQuestionViewer.addEventListener("resize", this);
        }
        else
        {
            this._qvQuestionViewer.isFirstQuestion = this._bFirstQuestion;
            this._qvQuestionViewer.question = oQuestion;
        } // end else if
        this.showElements(true);
    };
    _loc1.applyColor = function (mc, zone)
    {
        var _loc4 = this._aColors[zone];
        if (_loc4 == -1 || _loc4 == undefined)
        {
            return;
        } // end if
        var _loc5 = (_loc4 & 16711680) >> 16;
        var _loc6 = (_loc4 & 65280) >> 8;
        var _loc7 = _loc4 & 255;
        var _loc8 = new Color(mc);
        var _loc9 = new Object();
        _loc9 = {ra: 0, ga: 0, ba: 0, rb: _loc5, gb: _loc6, bb: _loc7};
        _loc8.setTransform(_loc9);
    };
    _loc1.closeDialog = function ()
    {
        this.callClose();
    };
    _loc1.response = function (oEvent)
    {
        if (oEvent.response.id == -1)
        {
            this.api.network.Dialog.leave();
        }
        else
        {
            this.api.network.Dialog.response(this._oQuestion.id, oEvent.response.id);
            this._bFirstQuestion = false;
        } // end else if
    };
    _loc1.complete = function (oEvent)
    {
        var ref = this;
        this._ldrArtwork.content.stringCourseColor = function (mc, z)
        {
            ref.applyColor(mc, z);
        };
    };
    _loc1.resize = function (oEvent)
    {
        this._winBackground.setSize(undefined, oEvent.target.height + (oEvent.target._y - this._winBackground._y) + 12);
        this._winBackgroundUp.setSize(undefined, oEvent.target.height + (oEvent.target._y - this._winBackground._y) + 10);
    };
    _loc1.initialization = function (oEvent)
    {
        this._mcPic._visible = true;
    };
    _loc1.addProperty("colors", function ()
    {
    }, _loc1.__set__colors);
    _loc1.addProperty("customArtwork", function ()
    {
    }, _loc1.__set__customArtwork);
    _loc1.addProperty("gfx", function ()
    {
    }, _loc1.__set__gfx);
    _loc1.addProperty("id", function ()
    {
    }, _loc1.__set__id);
    _loc1.addProperty("name", function ()
    {
    }, _loc1.__set__name);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.ui.NpcDialog = function ()
    {
        super();
    }).CLASS_NAME = "NpcDialog";
    _loc1._bFirstQuestion = true;
} // end if
#endinitclip
