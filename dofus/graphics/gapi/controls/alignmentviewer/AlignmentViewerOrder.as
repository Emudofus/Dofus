// Action script...

// [Initial MovieClip Action of sprite 20954]
#initclip 219
if (!dofus.graphics.gapi.controls.alignmentviewer.AlignmentViewerOrder)
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
    if (!dofus.graphics.gapi.controls.alignmentviewer)
    {
        _global.dofus.graphics.gapi.controls.alignmentviewer = new Object();
    } // end if
    var _loc1 = (_global.dofus.graphics.gapi.controls.alignmentviewer.AlignmentViewerOrder = function ()
    {
        super();
    }).prototype;
    _loc1.__set__specialization = function (oSpec)
    {
        this._oSpec = oSpec;
        if (this.initialized)
        {
            this.initData();
        } // end if
        //return (this.specialization());
    };
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.controls.alignmentviewer.AlignmentViewerOrder.CLASS_NAME);
    };
    _loc1.createChildren = function ()
    {
        this.addToQueue({object: this, method: this.initTexts});
        this.addToQueue({object: this, method: this.initData});
    };
    _loc1.initTexts = function ()
    {
        this._lblInfos.text = this.api.lang.getText("PLAYER_SPECIALIZATION");
    };
    _loc1.initData = function ()
    {
        if (this._oSpec != undefined)
        {
            this._lblSpecializationName.text = this._oSpec.name;
            this._lblOrderName.text = this._oSpec.order.name;
            this._ldrIcon.contentPath = this._oSpec.order.iconFile;
            this._txtSpecializationDescription.text = this._oSpec.description;
        } // end if
    };
    _loc1.addProperty("specialization", function ()
    {
    }, _loc1.__set__specialization);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.controls.alignmentviewer.AlignmentViewerOrder = function ()
    {
        super();
    }).CLASS_NAME = "AlignmentViewerOrder";
} // end if
#endinitclip
