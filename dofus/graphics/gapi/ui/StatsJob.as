// Action script...

// [Initial MovieClip Action of sprite 20762]
#initclip 27
if (!dofus.graphics.gapi.ui.StatsJob)
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
    var _loc1 = (_global.dofus.graphics.gapi.ui.StatsJob = function ()
    {
        super();
    }).prototype;
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.ui.StatsJob.CLASS_NAME);
    };
    _loc1.destroy = function ()
    {
        this.gapi.hideTooltip();
    };
    _loc1.callClose = function ()
    {
        this.unloadThis();
        return (true);
    };
    _loc1.createChildren = function ()
    {
        this.addToQueue({object: this, method: this.addListeners});
        this.addToQueue({object: this, method: this.initData});
        this.addToQueue({object: this, method: this.initTexts});
        this._mcViewersPlacer._visible = false;
        this._btnClosePanel._visible = false;
        this.api.datacenter.Player.data.addListener(this);
        this.api.datacenter.Player.addEventListener("levelChanged", this);
        this.api.datacenter.Player.addEventListener("xpChanged", this);
        this.api.datacenter.Player.addEventListener("lpChanged", this);
        this.api.datacenter.Player.addEventListener("lpMaxChanged", this);
        this.api.datacenter.Player.addEventListener("apChanged", this);
        this.api.datacenter.Player.addEventListener("mpChanged", this);
        this.api.datacenter.Player.addEventListener("initiativeChanged", this);
        this.api.datacenter.Player.addEventListener("discernmentChanged", this);
        this.api.datacenter.Player.addEventListener("forceXtraChanged", this);
        this.api.datacenter.Player.addEventListener("vitalityXtraChanged", this);
        this.api.datacenter.Player.addEventListener("wisdomXtraChanged", this);
        this.api.datacenter.Player.addEventListener("chanceXtraChanged", this);
        this.api.datacenter.Player.addEventListener("agilityXtraChanged", this);
        this.api.datacenter.Player.addEventListener("intelligenceXtraChanged", this);
        this.api.datacenter.Player.addEventListener("bonusPointsChanged", this);
        this.api.datacenter.Player.addEventListener("energyChanged", this);
        this.api.datacenter.Player.addEventListener("energyMaxChanged", this);
        this.api.datacenter.Player.addEventListener("alignmentChanged", this);
    };
    _loc1.addListeners = function ()
    {
        this._ctrAlignment.addEventListener("click", this);
        this._ctrJob0.addEventListener("click", this);
        this._ctrJob1.addEventListener("click", this);
        this._ctrJob2.addEventListener("click", this);
        this._ctrSpe0.addEventListener("click", this);
        this._ctrSpe1.addEventListener("click", this);
        this._ctrSpe2.addEventListener("click", this);
        this._ctrAlignment.addEventListener("over", this);
        this._ctrJob0.addEventListener("over", this);
        this._ctrJob1.addEventListener("over", this);
        this._ctrJob2.addEventListener("over", this);
        this._ctrSpe0.addEventListener("over", this);
        this._ctrSpe1.addEventListener("over", this);
        this._ctrSpe2.addEventListener("over", this);
        this._ctrAlignment.addEventListener("out", this);
        this._ctrJob0.addEventListener("out", this);
        this._ctrJob1.addEventListener("out", this);
        this._ctrJob2.addEventListener("out", this);
        this._ctrSpe0.addEventListener("out", this);
        this._ctrSpe1.addEventListener("out", this);
        this._ctrSpe2.addEventListener("out", this);
        this._btn10.addEventListener("click", this);
        this._btn10.addEventListener("over", this);
        this._btn10.addEventListener("out", this);
        this._btn11.addEventListener("click", this);
        this._btn11.addEventListener("over", this);
        this._btn11.addEventListener("out", this);
        this._btn12.addEventListener("click", this);
        this._btn12.addEventListener("over", this);
        this._btn12.addEventListener("out", this);
        this._btn13.addEventListener("click", this);
        this._btn13.addEventListener("over", this);
        this._btn13.addEventListener("out", this);
        this._btn14.addEventListener("click", this);
        this._btn14.addEventListener("over", this);
        this._btn14.addEventListener("out", this);
        this._btn15.addEventListener("click", this);
        this._btn15.addEventListener("over", this);
        this._btn15.addEventListener("out", this);
        this.api.datacenter.Game.addEventListener("stateChanged", this);
        this._btnClose.addEventListener("click", this);
        this._btnClosePanel.addEventListener("click", this);
        this._mcMoreStats.onRelease = function ()
        {
            this._parent.click({target: this});
        };
    };
    _loc1.initData = function ()
    {
        var _loc2 = this.api.datacenter.Player;
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
        var _loc3 = this.api.datacenter.Player.Jobs;
        var _loc4 = 0;
        
        while (++_loc4, _loc4 < _loc3.length)
        {
            var _loc5 = _loc3[_loc4];
            var _loc6 = _loc5.specializationOf;
            if (_loc6 != 0)
            {
                var _loc7 = 0;
                
                while (++_loc7, _loc7 < 3)
                {
                    var _loc8 = this["_ctrSpe" + _loc7];
                    if (_loc8.contentData == undefined)
                    {
                        _loc8.contentData = _loc5;
                        break;
                    } // end if
                } // end while
                continue;
            } // end if
            var _loc9 = 0;
            
            while (++_loc9, _loc9 < 3)
            {
                var _loc10 = this["_ctrJob" + _loc9];
                if (_loc10.contentData == undefined)
                {
                    _loc10.contentData = _loc5;
                    break;
                } // end if
            } // end while
        } // end while
        this._lblName.text = this.api.datacenter.Player.data.name;
        this.activateBoostButtons(!this.api.datacenter.Game.isFight);
    };
    _loc1.initTexts = function ()
    {
        this._lblEnergy.text = this.api.lang.getText("ENERGY");
        if (this.api.datacenter.Basics.aks_current_server.typeNum == dofus.datacenter.Server.SERVER_HARDCORE)
        {
            this._lblEnergy._alpha = 50;
            this._mcOverEnergy._visible = false;
        } // end if
        this._lblCharacteristics.text = this.api.lang.getText("CHARACTERISTICS");
        this._lblMyJobs.text = this.api.lang.getText("MY_JOBS");
        this._lblXP.text = this.api.lang.getText("EXPERIMENT");
        this._lblLP.text = this.api.lang.getText("LIFEPOINTS");
        this._lblAP.text = this.api.lang.getText("ACTIONPOINTS");
        this._lblMP.text = this.api.lang.getText("MOVEPOINTS");
        this._lblInitiative.text = this.api.lang.getText("INITIATIVE");
        this._lblDiscernment.text = this.api.lang.getText("DISCERNMENT");
        this._lblForce.text = this.api.lang.getText("FORCE");
        this._lblVitality.text = this.api.lang.getText("VITALITY");
        this._lblWisdom.text = this.api.lang.getText("WISDOM");
        this._lblChance.text = this.api.lang.getText("CHANCE");
        this._lblAgility.text = this.api.lang.getText("AGILITY");
        this._lblIntelligence.text = this.api.lang.getText("INTELLIGENCE");
        this._lblCapital.text = this.api.lang.getText("CHARACTERISTICS_POINTS");
        this._lblSpecialization.text = this.api.lang.getText("SPECIALIZATIONS");
        this._mcMoreStats.onRollOver = function ()
        {
            this._parent.gapi.showTooltip(this._parent.api.lang.getText("MORE_STATS"), this, -20);
        };
        this._mcMoreStats.onRollOut = function ()
        {
            this._parent.gapi.hideTooltip();
        };
    };
    _loc1.showStats = function ()
    {
        this.hideAlignment();
        this.hideJob();
        if (this._svStats == undefined)
        {
            this.attachMovie("StatsViewer", "_svStats", this.getNextHighestDepth(), {_x: this._mcViewersPlacer._x, _y: this._mcViewersPlacer._y});
            this._btnClosePanel._visible = true;
            this._btnClosePanel.swapDepths(this.getNextHighestDepth());
            this._btnClosePanel._x = this._btnClosePanel._x + 35;
        }
        else
        {
            this.hideStats();
        } // end else if
    };
    _loc1.hideStats = function ()
    {
        if (this._svStats != undefined)
        {
            this._btnClosePanel._x = this._btnClosePanel._x - 35;
        } // end if
        this._svStats.removeMovieClip();
        this._btnClosePanel._visible = false;
    };
    _loc1.showJob = function (oJob)
    {
        this.hideAlignment();
        this.hideStats();
        if (oJob == undefined)
        {
            this.hideJob();
            return;
        } // end if
        if (this._jvJob == undefined)
        {
            this.attachMovie("JobViewer", "_jvJob", this.getNextHighestDepth(), {_x: this._mcViewersPlacer._x, _y: this._mcViewersPlacer._y});
            this._btnClosePanel._visible = true;
            this._btnClosePanel.swapDepths(this.getNextHighestDepth());
        }
        else if (this._oCurrentJob.id == oJob.id)
        {
            this.hideJob();
            return;
        } // end else if
        this._jvJob.job = oJob;
        this["_ctr" + (this._oCurrentJob.specializationOf == 0 ? ("Job") : ("Spe")) + this._oCurrentJob.id].selected = false;
        this["_ctr" + (oJob.specializationOf == 0 ? ("Job") : ("Spe")) + oJob.id].selected = true;
        this._oCurrentJob = oJob;
    };
    _loc1.hideJob = function ()
    {
        this["_ctr" + (this._oCurrentJob.specializationOf == 0 ? ("Job") : ("Spe")) + this._oCurrentJob.id].selected = false;
        this._jvJob.removeMovieClip();
        delete this._oCurrentJob;
        this._btnClosePanel._visible = false;
    };
    _loc1.showAlignment = function ()
    {
        this.hideJob();
        this.hideStats();
        if (this._avAlignment == undefined)
        {
            this.attachMovie("AlignmentViewer", "_avAlignment", this.getNextHighestDepth(), {_x: this._mcViewersPlacer._x, _y: this._mcViewersPlacer._y});
            this._btnClosePanel._visible = true;
            this._btnClosePanel.swapDepths(this.getNextHighestDepth());
        }
        else
        {
            this.hideAlignment();
        } // end else if
    };
    _loc1.hideAlignment = function ()
    {
        this._avAlignment.removeMovieClip();
        this._btnClosePanel._visible = false;
    };
    _loc1.activateBoostButtons = function (bActivated)
    {
        var _loc3 = 10;
        
        while (++_loc3, _loc3 < 16)
        {
            this["_btn" + _loc3].enabled = bActivated;
        } // end while
    };
    _loc1.updateCharacteristicButton = function (nCharacteristicID)
    {
        var _loc3 = this.api.datacenter.Player.getBoostCostAndCountForCharacteristic(nCharacteristicID).cost;
        var _loc4 = this["_btn" + nCharacteristicID];
        if (_loc3 <= this.api.datacenter.Player.BonusPoints)
        {
            _loc4._visible = true;
        }
        else
        {
            _loc4._visible = false;
        } // end else if
    };
    _loc1.click = function (oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_btnClosePanel":
            {
                this.hideJob();
                this.hideAlignment();
                this.hideStats();
                break;
            } 
            case "_ctrAlignment":
            {
                if (this.api.datacenter.Player.data.alignment.index == 0)
                {
                    this.api.kernel.showMessage(undefined, this.api.lang.getText("NEED_ALIGNMENT"), "ERROR_BOX");
                }
                else
                {
                    this.showAlignment();
                } // end else if
                break;
            } 
            case "_btn10":
            case "_btn11":
            case "_btn12":
            case "_btn13":
            case "_btn14":
            case "_btn15":
            {
                this.api.sounds.events.onStatsJobBoostButtonClick();
                var _loc3 = oEvent.target._name.substr(4);
                if (this.api.datacenter.Player.canBoost(_loc3))
                {
                    this.api.network.Account.boost(_loc3);
                } // end if
                break;
            } 
            case "_btnClose":
            {
                this.callClose();
                break;
            } 
            case "_mcMoreStats":
            {
                this.showStats();
                break;
            } 
            default:
            {
                this.showJob(oEvent.target.contentData);
                break;
            } 
        } // End of switch
    };
    _loc1.over = function (oEvent)
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
                var _loc3 = Number(oEvent.target._name.substr(4));
                var _loc4 = this.api.datacenter.Player.getBoostCostAndCountForCharacteristic(_loc3);
                this.gapi.showTooltip(this.api.lang.getText("COST") + " : " + _loc4.cost + " " + this.api.lang.getText("POUR") + " " + _loc4.count, oEvent.target, -20);
                break;
            } 
            case "_ctrAlignment":
            {
                this.gapi.showTooltip(this.api.datacenter.Player.alignment.name, oEvent.target, oEvent.target.height + 5);
                break;
            } 
            default:
            {
                this.gapi.showTooltip(oEvent.target.contentData.name, oEvent.target, -20);
                break;
            } 
        } // End of switch
    };
    _loc1.out = function (oEvent)
    {
        this.gapi.hideTooltip();
    };
    _loc1.levelChanged = function (oEvent)
    {
        this._lblLevel.text = this.api.lang.getText("LEVEL") + " " + String(oEvent.value);
    };
    _loc1.xpChanged = function (oEvent)
    {
        this._pbXP.minimum = this.api.datacenter.Player.XPlow;
        this._pbXP.maximum = this.api.datacenter.Player.XPhigh;
        this._pbXP.value = oEvent.value;
        this._mcXP.onRollOver = function ()
        {
            this._parent.gapi.showTooltip(new ank.utils.ExtendedString(oEvent.value).addMiddleChar(this._parent.api.lang.getConfigText("THOUSAND_SEPARATOR"), 3) + " / " + new ank.utils.ExtendedString(this._parent._pbXP.maximum).addMiddleChar(this._parent.api.lang.getConfigText("THOUSAND_SEPARATOR"), 3), this, -10);
        };
        this._mcXP.onRollOut = function ()
        {
            this._parent.gapi.hideTooltip();
        };
    };
    _loc1.lpChanged = function (oEvent)
    {
        this._lblLPValue.text = String(oEvent.value);
    };
    _loc1.lpMaxChanged = function (oEvent)
    {
        this._lblLPmaxValue.text = String(oEvent.value);
    };
    _loc1.apChanged = function (oEvent)
    {
        this._lblAPValue.text = String(Math.max(0, oEvent.value));
    };
    _loc1.mpChanged = function (oEvent)
    {
        this._lblMPValue.text = String(Math.max(0, oEvent.value));
    };
    _loc1.forceXtraChanged = function (oEvent)
    {
        this._lblForceValue.text = this.api.datacenter.Player.Force + (oEvent.value != 0 ? ((oEvent.value > 0 ? (" (+") : (" (")) + String(oEvent.value) + ")") : (""));
        this.updateCharacteristicButton(10);
    };
    _loc1.vitalityXtraChanged = function (oEvent)
    {
        this._lblVitalityValue.text = this.api.datacenter.Player.Vitality + (oEvent.value != 0 ? ((oEvent.value > 0 ? (" (+") : (" (")) + String(oEvent.value) + ")") : (""));
        this.updateCharacteristicButton(11);
    };
    _loc1.wisdomXtraChanged = function (oEvent)
    {
        this._lblWisdomValue.text = this.api.datacenter.Player.Wisdom + (oEvent.value != 0 ? ((oEvent.value > 0 ? (" (+") : (" (")) + String(oEvent.value) + ")") : (""));
        this.updateCharacteristicButton(12);
    };
    _loc1.chanceXtraChanged = function (oEvent)
    {
        this._lblChanceValue.text = this.api.datacenter.Player.Chance + (oEvent.value != 0 ? ((oEvent.value > 0 ? (" (+") : (" (")) + String(oEvent.value) + ")") : (""));
        this.updateCharacteristicButton(13);
    };
    _loc1.agilityXtraChanged = function (oEvent)
    {
        this._lblAgilityValue.text = this.api.datacenter.Player.Agility + (oEvent.value != 0 ? ((oEvent.value > 0 ? (" (+") : (" (")) + String(oEvent.value) + ")") : (""));
        this.updateCharacteristicButton(14);
    };
    _loc1.intelligenceXtraChanged = function (oEvent)
    {
        this._lblIntelligenceValue.text = this.api.datacenter.Player.Intelligence + (oEvent.value != 0 ? ((oEvent.value > 0 ? (" (+") : (" (")) + String(oEvent.value) + ")") : (""));
        this.updateCharacteristicButton(15);
    };
    _loc1.bonusPointsChanged = function (oEvent)
    {
        this._lblCapitalValue.text = String(oEvent.value);
    };
    _loc1.energyChanged = function (oEvent)
    {
        if (this.api.datacenter.Basics.aks_current_server.typeNum != dofus.datacenter.Server.SERVER_HARDCORE)
        {
            this._mcEnergy.onRollOver = function ()
            {
                this._parent.gapi.showTooltip(new ank.utils.ExtendedString(oEvent.value).addMiddleChar(this._parent.api.lang.getConfigText("THOUSAND_SEPARATOR"), 3) + " / " + new ank.utils.ExtendedString(Math.max(10000, this._parent._pbEnergy.maximum)).addMiddleChar(this._parent.api.lang.getConfigText("THOUSAND_SEPARATOR"), 3), this, -10);
            };
            this._mcEnergy.onRollOut = function ()
            {
                this._parent.gapi.hideTooltip();
            };
            this._pbEnergy.maximum = this.api.datacenter.Player.EnergyMax;
            this._pbEnergy.value = oEvent.value;
        }
        else
        {
            this._pbEnergy._alpha = 50;
            this._pbEnergy.enabled = false;
        } // end else if
    };
    _loc1.energyMaxChanged = function (oEvent)
    {
        this._pbEnergy.maximum = oEvent.value;
    };
    _loc1.alignmentChanged = function (oEvent)
    {
        this._ctrAlignment.contentPath = oEvent.alignment.iconFile;
    };
    _loc1.initiativeChanged = function (oEvent)
    {
        this._lblInitiativeValue.text = String(oEvent.value);
    };
    _loc1.discernmentChanged = function (oEvent)
    {
        this._lblDiscernmentValue.text = String(oEvent.value);
    };
    _loc1.stateChanged = function (oEvent)
    {
        this.activateBoostButtons(!(oEvent.value > 1 && oEvent.value != undefined));
    };
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.ui.StatsJob = function ()
    {
        super();
    }).CLASS_NAME = "StatsJob";
} // end if
#endinitclip
