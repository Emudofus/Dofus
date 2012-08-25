// Action script...

// [Initial MovieClip Action of sprite 20779]
#initclip 44
if (!dofus.graphics.gapi.controls.SpellFullInfosViewer)
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
    var _loc1 = (_global.dofus.graphics.gapi.controls.SpellFullInfosViewer = function ()
    {
        super();
    }).prototype;
    _loc1.__set__spell = function (oSpell)
    {
        if (oSpell == undefined)
        {
            return;
        } // end if
        if (oSpell == this._oSpell)
        {
            return;
        } // end if
        if (!oSpell.isValid)
        {
            this._oSpell = new dofus.datacenter.Spell(oSpell.ID, 1);
        }
        else
        {
            this._oSpell = oSpell;
        } // end else if
        if (this.initialized)
        {
            this.updateData();
        } // end if
        //return (this.spell());
    };
    _loc1.__get__spell = function ()
    {
        return (this._oSpell);
    };
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.controls.SpellFullInfosViewer.CLASS_NAME);
    };
    _loc1.createChildren = function ()
    {
        this.addToQueue({object: this, method: this.addListeners});
        this.addToQueue({object: this, method: this.initData});
        this.addToQueue({object: this, method: this.initTexts});
        this.hideAllCheck();
        this._btnTabCreature._visible = false;
        this._btnTabGlyph._visible = false;
        this._btnTabTrap._visible = false;
    };
    _loc1.addListeners = function ()
    {
        this._btnTabNormal.addEventListener("click", this);
        this._btnTabCritical.addEventListener("click", this);
        this._btnTabCreature.addEventListener("click", this);
        this._btnTabGlyph.addEventListener("click", this);
        this._btnTabTrap.addEventListener("click", this);
        this._btnLevel1.addEventListener("click", this);
        this._btnLevel2.addEventListener("click", this);
        this._btnLevel3.addEventListener("click", this);
        this._btnLevel4.addEventListener("click", this);
        this._btnLevel5.addEventListener("click", this);
        this._btnLevel6.addEventListener("click", this);
        this._btnClose.addEventListener("click", this);
    };
    _loc1.initData = function ()
    {
        this.updateData();
    };
    _loc1.initTexts = function ()
    {
        this._lblEffectsTitle.text = this.api.lang.getText("EFFECTS");
        this._lblOtherTitle.text = this.api.lang.getText("OTHER_CHARACTERISTICS");
        this._lblCriticalHit.text = this.api.lang.getText("CRITICAL_HIT_PROBABILITY");
        this._lblCriticalMiss.text = this.api.lang.getText("CRITICAL_MISS_PROBABILITY");
        this._lblCountByTurn.text = this.api.lang.getText("COUNT_BY_TURN");
        this._lblCountByTurnByPlayer.text = this.api.lang.getText("COUNT_BY_TURN_BY_PLAYER");
        this._lblDelay.text = this.api.lang.getText("DELAY_RELAUNCH");
        this._lblRangeBoost.text = this.api.lang.getText("RANGE_BOOST");
        this._lblLineOfSight.text = this.api.lang.getText("LINE_OF_SIGHT");
        this._lblLineOnly.text = this.api.lang.getText("LINE_ONLY");
        this._lblFreeCell.text = this.api.lang.getText("FREE_CELL");
        this._lblRealCrit.text = this.api.lang.getText("ACTUAL_CRITICAL_CHANCE");
        this._lblFailureEndsTheTurn.text = this.api.lang.getText("FAILURE_ENDS_THE_TURN");
        this._btnTabNormal.label = this.api.lang.getText("NORMAL_EFFECTS");
        this._btnTabCritical.label = this.api.lang.getText("CRITICAL_EFECTS");
        this._btnTabCreature.label = this.api.lang.getText("SUMMONED_CREATURE");
        this._btnTabGlyph.label = this.api.lang.getText("GLYPH");
        this._btnTabTrap.label = this.api.lang.getText("TRAP");
    };
    _loc1.updateData = function ()
    {
        if (this._oSpell != undefined && this._txtDescription.text != undefined)
        {
            this._ldrIcon.contentPath = this._oSpell.iconFile;
            this._lblName.text = this._oSpell.name;
            this._lblLevel.text = this.api.lang.getText("ACTUAL_SPELL_LEVEL") + ":";
            this._lblReqLevel.text = this._oSpell.minPlayerLevel != undefined ? (this.api.lang.getText("REQUIRED_SPELL_LEVEL") + ": " + this._oSpell.minPlayerLevel) : ("");
            this._lblRange.text = this._oSpell.rangeStr + " " + this.api.lang.getText("RANGE");
            this._lblAP.text = this._oSpell.apCost + " " + this.api.lang.getText("AP");
            this._txtDescription.text = this._oSpell.description;
            this._btnTabCreature._visible = this._oSpell.summonSpell;
            this._btnTabGlyph._visible = this._oSpell.glyphSpell;
            this._btnTabTrap._visible = this._oSpell.trapSpell;
            if (this._oSpell.effectsCriticalHit[0] == undefined)
            {
                if (this._sCurrentTab == "Critical")
                {
                    this.setCurrentTab("Normal");
                } // end if
                this._btnTabCritical._alpha = 70;
                this._btnTabCritical.enabled = false;
            }
            else
            {
                this._btnTabCritical._alpha = 100;
                this._btnTabCritical.enabled = true;
            } // end else if
            if (!this._oSpell.summonSpell && this._sCurrentTab == "Creature")
            {
                this.setCurrentTab("Normal");
            }
            else if (!this._oSpell.glyphSpell && this._sCurrentTab == "Glyph")
            {
                this.setCurrentTab("Normal");
            }
            else if (!this._oSpell.trapSpell && this._sCurrentTab == "Trap")
            {
                this.setCurrentTab("Normal");
            }
            else
            {
                this.updateCurrentTabInformations();
            } // end else if
            var _loc2 = this.api.kernel.GameManager.getCriticalHitChance(this._oSpell.criticalHit);
            this._lblRealCritValue.text = _loc2 == 0 ? ("-") : ("1/" + _loc2);
            this._lblCriticalHitValue.text = this._oSpell.criticalHit == 0 ? ("-") : ("1/" + this._oSpell.criticalHit);
            this._lblCriticalMissValue.text = this._oSpell.criticalFailure == 0 ? ("-") : ("1/" + this._oSpell.criticalFailure);
            this._lblCountByTurnValue.text = this._oSpell.launchCountByTurn == 0 ? ("-") : (String(this._oSpell.launchCountByTurn));
            this._lblCountByTurnByPlayerValue.text = this._oSpell.launchCountByPlayerTurn == 0 ? ("-") : (String(this._oSpell.launchCountByPlayerTurn));
            this._lblDelayValue.text = this._oSpell.delayBetweenLaunch >= 63 ? ("inf.") : (this._oSpell.delayBetweenLaunch == 0 ? ("-") : (String(this._oSpell.delayBetweenLaunch)));
            this._mcCrossRangeBoost._visible = !this._oSpell.canBoostRange;
            this._mcCheckRangeBoost._visible = this._oSpell.canBoostRange;
            this._mcCrossLineOfSight._visible = !this._oSpell.lineOfSight;
            this._mcCheckLineOfSight._visible = this._oSpell.lineOfSight;
            this._mcCrossLineOnly._visible = !this._oSpell.lineOnly;
            this._mcCheckLineOnly._visible = this._oSpell.lineOnly;
            this._mcCrossFreeCell._visible = !this._oSpell.freeCell;
            this._mcCheckFreeCell._visible = this._oSpell.freeCell;
            this._mcCrossFailureEndsTheTurn._visible = !this._oSpell.criticalFailureEndsTheTurn;
            this._mcCheckFailureEndsTheTurn._visible = this._oSpell.criticalFailureEndsTheTurn;
            if (this._oSpell.level != undefined)
            {
                var _loc3 = 1;
                
                while (++_loc3, _loc3 <= 6)
                {
                    var _loc4 = this["_btnLevel" + _loc3];
                    var _loc5 = _loc3 == this._oSpell.level;
                    _loc4.selected = _loc5;
                    _loc4.enabled = !_loc5;
                    if (_loc3 <= this._oSpell.maxLevel)
                    {
                        _loc4._alpha = 100;
                        continue;
                    } // end if
                    _loc4.enabled = false;
                    _loc4._alpha = 20;
                } // end while
            }
            else
            {
                var _loc6 = 1;
                
                while (++_loc6, _loc6 <= 6)
                {
                    var _loc7 = this["_btnLevel" + _loc6];
                    _loc7.selected = false;
                    _loc7.enabled = false;
                    _loc7._alpha = 20;
                } // end while
            } // end else if
        }
        else if (this._lblName.text != undefined)
        {
            this._ldrIcon.contentPath = "";
            this._lblName.text = "";
            this._lblLevel.text = "";
            this._lblRange.text = "";
            this._lblAP.text = "";
            this._txtDescription.text = "";
            this._lblCriticalHitValue.text = "";
            this._lblCriticalMissValue.text = "";
            this._lblCountByTurnValue.text = "";
            this._lblCountByTurnByPlayerValue.text = "";
            this._lblDelayValue.text = "";
            this.hideAllCheck();
            this._lstEffects.dataProvider = null;
        } // end else if
    };
    _loc1.updateCurrentTabInformations = function ()
    {
        switch (this._sCurrentTab)
        {
            case "Normal":
            {
                this._lstEffects.dataProvider = this._oSpell.effectsNormalHitWithArea;
                break;
            } 
            case "Critical":
            {
                this._lstEffects.dataProvider = this._oSpell.effectsCriticalHitWithArea;
                break;
            } 
            case "Creature":
            {
                var _loc2 = this._oSpell.effectsNormalHit;
                var _loc4 = 0;
                
                while (++_loc4, _loc4 < _loc2.length)
                {
                    var _loc3 = _loc2[_loc4];
                    if (_loc3.type == 181)
                    {
                        break;
                    } // end if
                    if (_loc3.type = 180)
                    {
                        var _loc5 = new ank.utils.ExtendedArray();
                        var _loc6 = this.api.datacenter.Player.data;
                        _loc5.push(_loc6.name + " (" + this.api.lang.getText("LEVEL") + " " + this.api.datacenter.Player.Level + ")");
                        _loc5.push(this.api.lang.getText("LP") + " : " + this.api.datacenter.Player.LP);
                        _loc5.push(this.api.lang.getText("AP") + " : " + _loc6.AP);
                        _loc5.push(this.api.lang.getText("MP") + " : " + _loc6.MP);
                        this._lstEffects.dataProvider = _loc5;
                        return;
                    } // end if
                } // end while
                var _loc7 = new ank.utils.ExtendedArray();
                if (_loc3 != undefined)
                {
                    var _loc8 = _loc3.param1;
                    var _loc9 = _loc3.param2;
                    var _loc10 = this.api.lang.getMonstersText(_loc8);
                    var _loc11 = _loc10["g" + _loc9];
                    _loc7.push(_loc10.n + " (" + this.api.lang.getText("LEVEL") + " " + _loc11.l + ")");
                    _loc7.push(this.api.lang.getText("LP") + " : " + _loc11.lp);
                    _loc7.push(this.api.lang.getText("AP") + " : " + _loc11.ap);
                    _loc7.push(this.api.lang.getText("MP") + " : " + _loc11.mp);
                } // end if
                this._lstEffects.dataProvider = _loc7;
                break;
            } 
            case "Glyph":
            case "Trap":
            {
                var _loc12 = 400;
                if (this._sCurrentTab == "Glyph")
                {
                    _loc12 = 401;
                } // end if
                var _loc13 = this._oSpell.effectsNormalHit;
                var _loc15 = 0;
                
                while (++_loc15, _loc15 < _loc13.length)
                {
                    var _loc14 = _loc13[_loc15];
                    if (_loc14.type == _loc12)
                    {
                        break;
                    } // end if
                } // end while
                var _loc16 = new ank.utils.ExtendedArray();
                if (_loc14 != undefined)
                {
                    var _loc17 = _loc14.param1;
                    var _loc18 = _loc14.param2;
                    var _loc19 = this.api.kernel.CharactersManager.getSpellObjectFromData(_loc17 + "~" + _loc18 + "~");
                    _loc16 = _loc19.effectsNormalHit;
                } // end if
                this._lstEffects.dataProvider = _loc16;
                break;
            } 
        } // End of switch
    };
    _loc1.setCurrentTab = function (sNewTab)
    {
        var _loc3 = this["_btnTab" + this._sCurrentTab];
        var _loc4 = this["_btnTab" + sNewTab];
        _loc3.selected = true;
        _loc3.enabled = true;
        _loc4.selected = false;
        _loc4.enabled = false;
        this._sCurrentTab = sNewTab;
        this.updateCurrentTabInformations();
    };
    _loc1.hideAllCheck = function ()
    {
        this._mcCrossRangeBoost._visible = true;
        this._mcCheckRangeBoost._visible = false;
        this._mcCrossLineOfSight._visible = true;
        this._mcCheckLineOfSight._visible = false;
        this._mcCrossLineOnly._visible = true;
        this._mcCheckLineOnly._visible = false;
        this._mcCrossFreeCell._visible = true;
        this._mcCheckFreeCell._visible = false;
    };
    _loc1.setLevel = function (nLevel)
    {
        var _loc3 = this.api.kernel.CharactersManager.getSpellObjectFromData(this._oSpell.ID + "~" + nLevel);
        if (_loc3.isValid)
        {
            this.spell = _loc3;
        }
        else
        {
            this["_btnLevel" + nLevel].selected = false;
        } // end else if
    };
    _loc1.click = function (oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_btnTabNormal":
            {
                this.setCurrentTab("Normal");
                break;
            } 
            case "_btnTabCritical":
            {
                this.setCurrentTab("Critical");
                break;
            } 
            case "_btnTabCreature":
            {
                this.setCurrentTab("Creature");
                break;
            } 
            case "_btnTabGlyph":
            {
                this.setCurrentTab("Glyph");
                break;
            } 
            case "_btnTabTrap":
            {
                this.setCurrentTab("Trap");
                break;
            } 
            case "_btnLevel1":
            case "_btnLevel2":
            case "_btnLevel3":
            case "_btnLevel4":
            case "_btnLevel5":
            case "_btnLevel6":
            {
                var _loc3 = oEvent.target._name.substr(9);
                this.setLevel(Number(_loc3));
                break;
            } 
            case "_btnClose":
            {
                this.dispatchEvent({type: "close"});
                this.unloadThis();
                break;
            } 
        } // End of switch
    };
    _loc1.addProperty("spell", _loc1.__get__spell, _loc1.__set__spell);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.controls.SpellFullInfosViewer = function ()
    {
        super();
    }).CLASS_NAME = "SpellFullInfosViewer";
    _loc1._sCurrentTab = "Normal";
} // end if
#endinitclip
