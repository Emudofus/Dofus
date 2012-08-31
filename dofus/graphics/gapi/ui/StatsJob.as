// Action script...

// [Initial MovieClip Action of sprite 995]
#initclip 212
class dofus.graphics.gapi.ui.StatsJob extends ank.gapi.core.UIAdvancedComponent
{
    var gapi, unloadThis, addToQueue, _mcViewersPlacer, api, _ctrAlignment, _ctrJob0, _ctrJob1, _ctrJob2, _btn10, _btn11, _btn12, _btn13, _btn14, _btn15, _btnClose, _lblName, _lblEnergy, _lblCharacteristics, _lblMyJobs, _lblXP, _lblLP, _lblAP, _lblMP, _lblInitiative, _lblDiscernment, _lblForce, _lblVitality, _lblWisdom, _lblChance, _lblAgility, _lblIntelligence, _lblCapital, _jvJob, getNextHighestDepth, attachMovie, _nCurrentJobID, _avAlignment, _lblLevel, _pbXP, _mcXP, _parent, _lblLPValue, _lblLPmaxValue, _lblAPValue, _lblMPValue, _lblForceValue, _lblVitalityValue, _lblWisdomValue, _lblChanceValue, _lblAgilityValue, _lblIntelligenceValue, _lblCapitalValue, _mcEnergy, _pbEnergy, _lblInitiativeValue, _lblDiscernmentValue;
    function StatsJob()
    {
        super();
    } // End of the function
    function init()
    {
        super.init(false, dofus.graphics.gapi.ui.StatsJob.CLASS_NAME);
    } // End of the function
    function destroy()
    {
        gapi.hideTooltip();
    } // End of the function
    function callClose()
    {
        this.unloadThis();
        return (true);
    } // End of the function
    function createChildren()
    {
        this.addToQueue({object: this, method: addListeners});
        this.addToQueue({object: this, method: initData});
        this.addToQueue({object: this, method: initTexts});
        _mcViewersPlacer._visible = false;
        api.datacenter.Player.data.addListener(this);
        api.datacenter.Player.addEventListener("levelChanged", this);
        api.datacenter.Player.addEventListener("xpChanged", this);
        api.datacenter.Player.addEventListener("lpChanged", this);
        api.datacenter.Player.addEventListener("lpMaxChanged", this);
        api.datacenter.Player.addEventListener("apChanged", this);
        api.datacenter.Player.addEventListener("mpChanged", this);
        api.datacenter.Player.addEventListener("initiativeChanged", this);
        api.datacenter.Player.addEventListener("discernmentChanged", this);
        api.datacenter.Player.addEventListener("forceXtraChanged", this);
        api.datacenter.Player.addEventListener("vitalityXtraChanged", this);
        api.datacenter.Player.addEventListener("wisdomXtraChanged", this);
        api.datacenter.Player.addEventListener("chanceXtraChanged", this);
        api.datacenter.Player.addEventListener("agilityXtraChanged", this);
        api.datacenter.Player.addEventListener("intelligenceXtraChanged", this);
        api.datacenter.Player.addEventListener("bonusPointsChanged", this);
        api.datacenter.Player.addEventListener("energyChanged", this);
        api.datacenter.Player.addEventListener("energyMaxChanged", this);
        api.datacenter.Player.addEventListener("alignmentChanged", this);
    } // End of the function
    function addListeners()
    {
        _ctrAlignment.addEventListener("click", this);
        _ctrJob0.addEventListener("click", this);
        _ctrJob1.addEventListener("click", this);
        _ctrJob2.addEventListener("click", this);
        _ctrAlignment.addEventListener("over", this);
        _ctrJob0.addEventListener("over", this);
        _ctrJob1.addEventListener("over", this);
        _ctrJob2.addEventListener("over", this);
        _ctrAlignment.addEventListener("out", this);
        _ctrJob0.addEventListener("out", this);
        _ctrJob1.addEventListener("out", this);
        _ctrJob2.addEventListener("out", this);
        _btn10.addEventListener("click", this);
        _btn10.addEventListener("over", this);
        _btn10.addEventListener("out", this);
        _btn11.addEventListener("click", this);
        _btn11.addEventListener("over", this);
        _btn11.addEventListener("out", this);
        _btn12.addEventListener("click", this);
        _btn12.addEventListener("over", this);
        _btn12.addEventListener("out", this);
        _btn13.addEventListener("click", this);
        _btn13.addEventListener("over", this);
        _btn13.addEventListener("out", this);
        _btn14.addEventListener("click", this);
        _btn14.addEventListener("over", this);
        _btn14.addEventListener("out", this);
        _btn15.addEventListener("click", this);
        _btn15.addEventListener("over", this);
        _btn15.addEventListener("out", this);
        _btnClose.addEventListener("click", this);
    } // End of the function
    function initData()
    {
        var _loc2 = api.datacenter.Player;
        this.levelChanged({value: _loc2.Level});
        this.xpChanged({value: _loc2.XP});
        this.lpChanged({value: _loc2.LP});
        this.lpMaxChanged({value: _loc2.LPmax});
        this.apChanged({value: _loc2.AP});
        this.mpChanged({value: _loc2.MP});
        this.initiativeChanged({value: _loc2.Initiative});
        this.discernmentChanged({value: _loc2.Discernment});
        this.forceXtraChanged({value: _loc2.ForceXtra});
        this.vitalityXtraChanged({value: _loc2.VitalityXtra});
        this.wisdomXtraChanged({value: _loc2.WisdomXtra});
        this.chanceXtraChanged({value: _loc2.ChanceXtra});
        this.agilityXtraChanged({value: _loc2.AgilityXtra});
        this.intelligenceXtraChanged({value: _loc2.IntelligenceXtra});
        this.bonusPointsChanged({value: _loc2.BonusPoints});
        this.energyChanged({value: _loc2.Energy});
        this.alignmentChanged({alignment: _loc2.alignment});
        _ctrJob0.__set__contentPath(api.datacenter.Player.Jobs[0].iconFile);
        _ctrJob1.__set__contentPath(api.datacenter.Player.Jobs[1].iconFile);
        _ctrJob2.__set__contentPath(api.datacenter.Player.Jobs[2].iconFile);
        _lblName.__set__text(api.datacenter.Player.data.name);
    } // End of the function
    function initTexts()
    {
        _lblEnergy.__set__text(api.lang.getText("ENERGY"));
        _lblCharacteristics.__set__text(api.lang.getText("CHARACTERISTICS"));
        _lblMyJobs.__set__text(api.lang.getText("MY_JOBS"));
        _lblXP.__set__text(api.lang.getText("EXPERIMENT"));
        _lblLP.__set__text(api.lang.getText("LIFEPOINTS"));
        _lblAP.__set__text(api.lang.getText("ACTIONPOINTS"));
        _lblMP.__set__text(api.lang.getText("MOVEPOINTS"));
        _lblInitiative.__set__text(api.lang.getText("INITIATIVE"));
        _lblDiscernment.__set__text(api.lang.getText("DISCERNMENT"));
        _lblForce.__set__text(api.lang.getText("FORCE"));
        _lblVitality.__set__text(api.lang.getText("VITALITY"));
        _lblWisdom.__set__text(api.lang.getText("WISDOM"));
        _lblChance.__set__text(api.lang.getText("CHANCE"));
        _lblAgility.__set__text(api.lang.getText("AGILITY"));
        _lblIntelligence.__set__text(api.lang.getText("INTELLIGENCE"));
        _lblCapital.__set__text(api.lang.getText("CHARACTERISTICS_POINTS"));
    } // End of the function
    function showJob(nJobID)
    {
        this.hideAlignment();
        if (api.datacenter.Player.Jobs[nJobID] == undefined)
        {
            this.hideJob();
            return;
        } // end if
        if (_jvJob == undefined)
        {
            this.attachMovie("JobViewer", "_jvJob", this.getNextHighestDepth(), {_x: _mcViewersPlacer._x, _y: _mcViewersPlacer._y});
        }
        else if (_nCurrentJobID == nJobID)
        {
            this.hideJob();
            return;
        } // end else if
        _jvJob.__set__job(api.datacenter.Player.Jobs[nJobID]);
        this["_ctrJob" + _nCurrentJobID].selected = false;
        this["_ctrJob" + nJobID].selected = true;
        _nCurrentJobID = nJobID;
    } // End of the function
    function hideJob()
    {
        this["_ctrJob" + _nCurrentJobID].selected = false;
        _jvJob.removeMovieClip();
        delete this._nCurrentJobID;
    } // End of the function
    function showAlignment()
    {
        this.hideJob();
        if (_avAlignment == undefined)
        {
            this.attachMovie("AlignmentViewer", "_avAlignment", this.getNextHighestDepth(), {_x: _mcViewersPlacer._x, _y: _mcViewersPlacer._y});
        }
        else
        {
            this.hideAlignment();
        } // end else if
    } // End of the function
    function hideAlignment()
    {
        _avAlignment.removeMovieClip();
    } // End of the function
    function updateCharacteristicButton(nCharacteristicID)
    {
        var _loc3 = api.datacenter.Player.getBoostCostAndCountForCharacteristic(nCharacteristicID).cost;
        var _loc2 = this["_btn" + nCharacteristicID];
        if (_loc3 <= api.datacenter.Player.BonusPoints)
        {
            _loc2._visible = true;
        }
        else
        {
            _loc2._visible = false;
        } // end else if
    } // End of the function
    function click(oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_ctrAlignment":
            {
                if (api.datacenter.Player.data.alignment.index == 0)
                {
                    api.kernel.showMessage(undefined, api.lang.getText("NEED_ALIGNMENT"), "ERROR_BOX");
                }
                else
                {
                    this.showAlignment();
                } // end else if
                break;
            } 
            case "_ctrJob0":
            {
                this.showJob(0);
                break;
            } 
            case "_ctrJob1":
            {
                this.showJob(1);
                break;
            } 
            case "_ctrJob2":
            {
                this.showJob(2);
                break;
            } 
            case "_btn10":
            case "_btn11":
            case "_btn12":
            case "_btn13":
            case "_btn14":
            case "_btn15":
            {
                var _loc2 = oEvent.target._name.substr(4);
                if (api.datacenter.Player.canBoost(_loc2))
                {
                    api.network.Account.boost(_loc2);
                } // end if
                break;
            } 
            case "_btnClose":
            {
                this.callClose();
                break;
            } 
        } // End of switch
    } // End of the function
    function over(oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_btn10":
            case "_btn11":
            case "_btn12":
            case "_btn13":
            case "_btn14":
            case "_btn15":
            {
                var _loc4 = Number(oEvent.target._name.substr(4));
                var _loc3 = api.datacenter.Player.getBoostCostAndCountForCharacteristic(_loc4);
                gapi.showTooltip(api.lang.getText("COST") + " : " + _loc3.cost + " " + api.lang.getText("FOR") + " " + _loc3.count, oEvent.target, -20);
                break;
            } 
            case "_ctrJob0":
            {
                gapi.showTooltip(api.datacenter.Player.Jobs[0].name, oEvent.target, -20);
                break;
            } 
            case "_ctrJob1":
            {
                gapi.showTooltip(api.datacenter.Player.Jobs[1].name, oEvent.target, -20);
                break;
            } 
            case "_ctrJob2":
            {
                gapi.showTooltip(api.datacenter.Player.Jobs[2].name, oEvent.target, -20);
                break;
            } 
            case "_ctrAlignment":
            {
                gapi.showTooltip(api.datacenter.Player.alignment.name, oEvent.target, oEvent.target.height + 5);
                break;
            } 
        } // End of switch
    } // End of the function
    function out(oEvent)
    {
        gapi.hideTooltip();
    } // End of the function
    function levelChanged(oEvent)
    {
        _lblLevel.__set__text(api.lang.getText("LEVEL") + " " + String(oEvent.value));
    } // End of the function
    function xpChanged(oEvent)
    {
        _pbXP.__set__minimum(api.datacenter.Player.XPlow);
        _pbXP.__set__maximum(api.datacenter.Player.XPhigh);
        _pbXP.__set__value(oEvent.value);
        _mcXP.onRollOver = function ()
        {
            _parent.gapi.showTooltip(String(oEvent.value).addMiddleChar(_parent.api.lang.getConfigText("THOUSAND_SEPARATOR"), 3) + " / " + String(_parent._pbXP.maximum).addMiddleChar(_parent.api.lang.getConfigText("THOUSAND_SEPARATOR"), 3), this, -10);
        };
        _mcXP.onRollOut = function ()
        {
            _parent.gapi.hideTooltip();
        };
    } // End of the function
    function lpChanged(oEvent)
    {
        _lblLPValue.__set__text(String(oEvent.value));
    } // End of the function
    function lpMaxChanged(oEvent)
    {
        _lblLPmaxValue.__set__text(String(oEvent.value));
    } // End of the function
    function apChanged(oEvent)
    {
        _lblAPValue.__set__text(String(Math.max(0, oEvent.value)));
    } // End of the function
    function mpChanged(oEvent)
    {
        _lblMPValue.__set__text(String(Math.max(0, oEvent.value)));
    } // End of the function
    function forceXtraChanged(oEvent)
    {
        _lblForceValue.__set__text(api.datacenter.Player.Force + (oEvent.value != 0 ? ((oEvent.value > 0 ? (" (+") : (" (")) + String(oEvent.value) + ")") : ("")));
        this.updateCharacteristicButton(10);
    } // End of the function
    function vitalityXtraChanged(oEvent)
    {
        _lblVitalityValue.__set__text(api.datacenter.Player.Vitality + (oEvent.value != 0 ? ((oEvent.value > 0 ? (" (+") : (" (")) + String(oEvent.value) + ")") : ("")));
        this.updateCharacteristicButton(11);
    } // End of the function
    function wisdomXtraChanged(oEvent)
    {
        _lblWisdomValue.__set__text(api.datacenter.Player.Wisdom + (oEvent.value != 0 ? ((oEvent.value > 0 ? (" (+") : (" (")) + String(oEvent.value) + ")") : ("")));
        this.updateCharacteristicButton(12);
    } // End of the function
    function chanceXtraChanged(oEvent)
    {
        _lblChanceValue.__set__text(api.datacenter.Player.Chance + (oEvent.value != 0 ? ((oEvent.value > 0 ? (" (+") : (" (")) + String(oEvent.value) + ")") : ("")));
        this.updateCharacteristicButton(13);
    } // End of the function
    function agilityXtraChanged(oEvent)
    {
        _lblAgilityValue.__set__text(api.datacenter.Player.Agility + (oEvent.value != 0 ? ((oEvent.value > 0 ? (" (+") : (" (")) + String(oEvent.value) + ")") : ("")));
        this.updateCharacteristicButton(14);
    } // End of the function
    function intelligenceXtraChanged(oEvent)
    {
        _lblIntelligenceValue.__set__text(api.datacenter.Player.Intelligence + (oEvent.value != 0 ? ((oEvent.value > 0 ? (" (+") : (" (")) + String(oEvent.value) + ")") : ("")));
        this.updateCharacteristicButton(15);
    } // End of the function
    function bonusPointsChanged(oEvent)
    {
        _lblCapitalValue.__set__text(String(oEvent.value));
    } // End of the function
    function energyChanged(oEvent)
    {
        _mcEnergy.onRollOver = function ()
        {
            _parent.gapi.showTooltip(String(oEvent.value).addMiddleChar(_parent.api.lang.getConfigText("THOUSAND_SEPARATOR"), 3) + " / " + String(Math.max(10000, _parent._pbEnergy.maximum)).addMiddleChar(_parent.api.lang.getConfigText("THOUSAND_SEPARATOR"), 3), this, -10);
        };
        _mcEnergy.onRollOut = function ()
        {
            _parent.gapi.hideTooltip();
        };
        _pbEnergy.__set__maximum(api.datacenter.Player.EnergyMax);
        _pbEnergy.__set__value(oEvent.value);
    } // End of the function
    function energyMaxChanged(oEvent)
    {
        _pbEnergy.__set__maximum(oEvent.value);
    } // End of the function
    function alignmentChanged(oEvent)
    {
        _ctrAlignment.__set__contentPath(oEvent.alignment.iconFile);
    } // End of the function
    function initiativeChanged(oEvent)
    {
        _lblInitiativeValue.__set__text(String(oEvent.value));
    } // End of the function
    function discernmentChanged(oEvent)
    {
        _lblDiscernmentValue.__set__text(String(oEvent.value));
    } // End of the function
    static var CLASS_NAME = "StatsJob";
} // End of Class
#endinitclip
