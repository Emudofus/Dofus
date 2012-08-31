// Action script...

// [Initial MovieClip Action of sprite 996]
#initclip 213
class dofus.graphics.gapi.controls.JobViewer extends ank.gapi.core.UIAdvancedComponent
{
    var _oJob, addToQueue, __get__job, _lblNoTool, _mcCraftViewerPlacer, api, _lblXP, _lblSkill, _lblTool, _btnTabCharacteristics, _btnTabCrafts, _lstSkills, _ldrIcon, _lblName, _lblLevel, _pbXP, _mcXP, _parent, _itvItemViewer, attachMovie, _cvCraftViewer, __set__job;
    function JobViewer()
    {
        super();
    } // End of the function
    function set job(oJob)
    {
        _oJob = oJob;
        this.addToQueue({object: this, method: layoutContent});
        //return (this.job());
        null;
    } // End of the function
    function init()
    {
        super.init(false, dofus.graphics.gapi.controls.JobViewer.CLASS_NAME);
    } // End of the function
    function createChildren()
    {
        _lblNoTool._visible = false;
        _mcCraftViewerPlacer._visible = false;
        this.addToQueue({object: this, method: initTexts});
        this.addToQueue({object: this, method: addListeners});
    } // End of the function
    function initTexts()
    {
        _lblXP.__set__text(api.lang.getText("EXPERIMENT"));
        _lblSkill.__set__text(api.lang.getText("SKILLS"));
        _lblTool.__set__text(api.lang.getText("TOOL"));
        _lblNoTool.__set__text(api.lang.getText("NO_TOOL_JOB"));
        _btnTabCharacteristics.__set__label(api.lang.getText("CHARACTERISTICS"));
        _btnTabCrafts.__set__label(api.lang.getText("RECEIPTS"));
    } // End of the function
    function addListeners()
    {
        _btnTabCharacteristics.addEventListener("click", this);
        _btnTabCrafts.addEventListener("click", this);
    } // End of the function
    function layoutContent()
    {
        if (_oJob == undefined)
        {
            return;
        } // end if
        this.setCurrentTab(_sCurrentTab);
        _lstSkills.removeMovieClip();
        var _loc3 = api.datacenter.Player.currentJobID == _oJob.id;
        _ldrIcon.__set__contentPath(_oJob.iconFile);
        _lblName.__set__text(_oJob.name);
        _lblLevel.__set__text(api.lang.getText("LEVEL") + " " + _oJob.level);
        _pbXP.__set__minimum(_oJob.xpMin);
        _pbXP.__set__maximum(_oJob.xpMax);
        _pbXP.__set__value(_oJob.xp);
        _mcXP.onRollOver = function ()
        {
            _parent._parent.gapi.showTooltip(String(_parent._oJob.xp).addMiddleChar(_parent.api.lang.getConfigText("THOUSAND_SEPARATOR"), 3) + " / " + String(_parent._oJob.xpMax).addMiddleChar(_parent.api.lang.getConfigText("THOUSAND_SEPARATOR"), 3), this, -10);
        };
        _mcXP.onRollOut = function ()
        {
            _parent._parent.gapi.hideTooltip();
        };
        var _loc2 = _oJob.skills;
        if (_loc2.length != 0)
        {
            _lstSkills.__set__dataProvider(_loc2);
        } // end if
        if (_loc3)
        {
            _lblNoTool._visible = false;
            _itvItemViewer._visible = true;
            var _loc4 = api.datacenter.Player.Inventory.findFirstItem("position", 1).item;
            _itvItemViewer.__set__itemData(_loc4);
        }
        else
        {
            _lblNoTool._visible = true;
            _itvItemViewer._visible = false;
        } // end else if
    } // End of the function
    function showCraftViewer(bShow)
    {
        if (bShow)
        {
            var _loc2 = this.attachMovie("CraftViewer", "_cvCraftViewer", 20);
            _loc2._x = _mcCraftViewerPlacer._x;
            _loc2._y = _mcCraftViewerPlacer._y;
            _loc2.job = _oJob;
        }
        else
        {
            _cvCraftViewer.removeMovieClip();
        } // end else if
    } // End of the function
    function updateCurrentTabInformations()
    {
        switch (_sCurrentTab)
        {
            case "Characteristics":
            {
                this.showCraftViewer(false);
                break;
            } 
            case "Crafts":
            {
                this.showCraftViewer(true);
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
    function click(oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_btnTabCharacteristics":
            {
                this.setCurrentTab("Characteristics");
                break;
            } 
            case "_btnTabCrafts":
            {
                this.setCurrentTab("Crafts");
                break;
            } 
        } // End of switch
    } // End of the function
    static var CLASS_NAME = "JobViewer";
    var _sCurrentTab = "Characteristics";
} // End of Class
#endinitclip
