// Action script...

// [Initial MovieClip Action of sprite 997]
#initclip 214
class dofus.graphics.gapi.controls.AlignmentViewer extends ank.gapi.core.UIAdvancedComponent
{
    var _pbAlignment, _lblAlignment, addToQueue, api, _lblTitle, _lblFeats, _btnTabSpecialization, _btnTabTree, _mcTab, _mcTabPlacer, getNextHighestDepth, attachMovie, _lblNoSpecialization, _lstFeats, _mcAlignment, _parent, _ldrIcon;
    function AlignmentViewer()
    {
        super();
    } // End of the function
    function init()
    {
        super.init(false, dofus.graphics.gapi.controls.AlignmentViewer.CLASS_NAME);
    } // End of the function
    function createChildren()
    {
        _pbAlignment._visible = false;
        _lblAlignment._visible = false;
        this.addToQueue({object: this, method: initTexts});
        this.addToQueue({object: this, method: addListeners});
        this.addToQueue({object: this, method: layoutContent});
    } // End of the function
    function initTexts()
    {
        _lblTitle.__set__text(api.lang.getText("ALIGNMENT"));
        _lblAlignment.__set__text(api.lang.getText("LEVEL"));
        _lblFeats.__set__text(api.lang.getText("FEATS"));
        _btnTabSpecialization.__set__label(api.lang.getText("SPECIALIZATION"));
        _btnTabTree.__set__label(api.lang.getText("SPECIALIZATION_TREE"));
    } // End of the function
    function addListeners()
    {
        _btnTabSpecialization.addEventListener("click", this);
        _btnTabTree.addEventListener("click", this);
        api.datacenter.Player.addEventListener("alignmentChanged", this);
        api.datacenter.Player.addEventListener("specializationChanged", this);
    } // End of the function
    function layoutContent()
    {
        if (api.datacenter.Player.alignment.index != 0)
        {
            this.setCurrentTab("Specialization");
        }
        else
        {
            this.setCurrentTab("Tree");
        } // end else if
        this.alignmentChanged({alignment: api.datacenter.Player.alignment});
    } // End of the function
    function updateCurrentTabInformations()
    {
        _mcTab.removeMovieClip();
        switch (_sCurrentTab)
        {
            case "Specialization":
            {
                var _loc2 = api.datacenter.Player.specialization;
                if (_loc2 != undefined)
                {
                    this.attachMovie("AlignmentViewerSpecialization", "_mcTab", this.getNextHighestDepth(), {_x: _mcTabPlacer._x, _y: _mcTabPlacer._y, specialization: _loc2});
                    this.setFeatsFromSpecialization(_loc2);
                }
                else
                {
                    _lblNoSpecialization.__set__text(api.lang.getText("NO_SPECIALIZATION"));
                    this.setFeatsFromSpecialization();
                } // end else if
                break;
            } 
            case "Tree":
            {
                this.attachMovie("AlignmentViewerTree", "_mcTab", this.getNextHighestDepth(), {_x: _mcTabPlacer._x, _y: _mcTabPlacer._y});
                _mcTab.addEventListener("specializationSelected", this);
                break;
            } 
        } // End of switch
    } // End of the function
    function setCurrentTab(sNewTab)
    {
        var _loc2 = this["_btnTab" + _sCurrentTab];
        var _loc3 = this["_btnTab" + sNewTab];
        _loc2.__set__selected(true);
        _loc2.__set__enabled(true);
        _loc3.__set__selected(false);
        _loc3.__set__enabled(false);
        _sCurrentTab = sNewTab;
        this.updateCurrentTabInformations();
    } // End of the function
    function setFeatsFromSpecialization(oSpec)
    {
        if (oSpec != undefined)
        {
            _lblFeats.__set__text(api.lang.getText("FEATS") + " (" + oSpec.__get__name() + ")");
            _lstFeats.__set__dataProvider(oSpec.feats);
        }
        else
        {
            _lblFeats.__set__text(api.lang.getText("FEATS"));
            _lstFeats.__set__dataProvider(new ank.utils.ExtendedArray());
        } // end else if
    } // End of the function
    function click(oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_btnTabSpecialization":
            {
                this.setCurrentTab("Specialization");
                break;
            } 
            case "_btnTabTree":
            {
                this.setCurrentTab("Tree");
                break;
            } 
        } // End of switch
    } // End of the function
    function alignmentChanged(oEvent)
    {
        _pbAlignment.__set__value(oEvent.alignment.value);
        _mcAlignment.onRollOver = function ()
        {
            _parent.gapi.showTooltip(String(oEvent.alignment.value).addMiddleChar(_parent.api.lang.getConfigText("THOUSAND_SEPARATOR"), 3) + " / " + String(_parent._pbAlignment.maximum).addMiddleChar(_parent.api.lang.getConfigText("THOUSAND_SEPARATOR"), 3), this, -10);
        };
        _mcAlignment.onRollOut = function ()
        {
            _parent.gapi.hideTooltip();
        };
        _ldrIcon.__set__contentPath(oEvent.alignment.iconFile);
        _lblTitle.__set__text(api.lang.getText("ALIGNMENT") + " " + oEvent.alignment.name);
        var _loc2 = oEvent.alignment.index == 0;
        _pbAlignment._visible = !_loc2;
        _lblAlignment._visible = !_loc2;
    } // End of the function
    function specializationChanged(oEvent)
    {
        this.setCurrentTab("Specialization");
    } // End of the function
    function specializationSelected(oEvent)
    {
        this.setFeatsFromSpecialization(oEvent.specialization);
    } // End of the function
    static var CLASS_NAME = "AlignmentViewer";
    var _sCurrentTab = "Specialization";
} // End of Class
#endinitclip
