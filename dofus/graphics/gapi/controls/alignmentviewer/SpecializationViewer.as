// Action script...

// [Initial MovieClip Action of sprite 20875]
#initclip 140
if (!dofus.graphics.gapi.controls.alignmentviewer.SpecializationViewer)
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
    var _loc1 = (_global.dofus.graphics.gapi.controls.alignmentviewer.SpecializationViewer = function ()
    {
        super();
    }).prototype;
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.controls.alignmentviewer.SpecializationViewer.CLASS_NAME);
    };
    _loc1.createChildren = function ()
    {
        this.addToQueue({object: this, method: this.initTexts});
        this.addToQueue({object: this, method: this.addListeners});
        this.addToQueue({object: this, method: this.initData});
    };
    _loc1.initTexts = function ()
    {
        this._lblFeats.text = this.api.lang.getText("FEATS");
        this._lblNoSpecialization.text = this.api.lang.getText("NO_SPECIALIZATION");
    };
    _loc1.addListeners = function ()
    {
        this.api.datacenter.Player.addEventListener("specializationChanged", this);
    };
    _loc1.initData = function ()
    {
        this.specializationChanged({specialization: this.api.datacenter.Player.specialization});
    };
    _loc1.setFeatsFromSpecialization = function (oSpec)
    {
        if (oSpec != undefined)
        {
            this._lblFeats.text = this.api.lang.getText("FEATS") + " (" + oSpec.name + ")";
            this._lstFeats.dataProvider = oSpec.feats;
        }
        else
        {
            this._lblFeats.text = this.api.lang.getText("FEATS");
            this._lstFeats.dataProvider = new ank.utils.ExtendedArray();
        } // end else if
    };
    _loc1.specializationChanged = function (oEvent)
    {
        this._mcTree.removeMovieClip();
        this._mcOrder.removeMovieClip();
        var _loc3 = oEvent.specialization;
        if (_loc3 != undefined)
        {
            this._lblNoSpecialization._visible = false;
            this._lblFeats._visible = true;
            this._lstFeats._visible = true;
            this.attachMovie("AlignmentViewerTree", "_mcTree", this.getNextHighestDepth(), {_x: this._mcTreePlacer._x, _y: this._mcTreePlacer._y});
            this._mcTree.addEventListener("specializationSelected", this);
            this._mcTree.addEventListener("orderSelected", this);
            this.specializationSelected();
        }
        else
        {
            this._lblNoSpecialization._visible = true;
            this._lblFeats._visible = false;
            this._lstFeats._visible = false;
        } // end else if
    };
    _loc1.specializationSelected = function (oEvent)
    {
        this._mcOrder.removeMovieClip();
        this.setFeatsFromSpecialization(oEvent.specialization);
    };
    _loc1.orderSelected = function (oEvent)
    {
        this._mcOrder.removeMovieClip();
        this.attachMovie("AlignmentViewerOrder", "_mcOrder", this.getNextHighestDepth(), {_x: this._mcOrderPlacer._x, _y: this._mcOrderPlacer._y, specialization: this.api.datacenter.Player.specialization});
    };
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.controls.alignmentviewer.SpecializationViewer = function ()
    {
        super();
    }).CLASS_NAME = "SpecializationViewer";
} // end if
#endinitclip
