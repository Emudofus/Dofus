// Action script...

// [Initial MovieClip Action of sprite 1016]
#initclip 237
class dofus.graphics.gapi.controls.SpellFullInfosViewer extends ank.gapi.core.UIAdvancedComponent
{
    var _oSpell, __get__initialized, __get__spell, addToQueue, _btnTabCreature, _btnTabGlyph, _btnTabTrap, _btnTabNormal, _btnTabCritical, _btnLevel1, _btnLevel2, _btnLevel3, _btnLevel4, _btnLevel5, _btnLevel6, _btnClose, api, _lblEffectsTitle, _lblOtherTitle, _lblCriticalHit, _lblCriticalMiss, _lblCountByTurn, _lblCountByTurnByPlayer, _lblDelay, _lblRangeBoost, _lblLineOfSight, _lblLineOnly, _lblFreeCell, _ldrIcon, _lblName, _lblLevel, _lblRange, _lblAP, _txtDescription, _lblCriticalHitValue, _lblCriticalMissValue, _lblCountByTurnValue, _lblCountByTurnByPlayerValue, _lblDelayValue, _mcCrossRangeBoost, _mcCheckRangeBoost, _mcCrossLineOfSight, _mcCheckLineOfSight, _mcCrossLineOnly, _mcCheckLineOnly, _mcCrossFreeCell, _mcCheckFreeCell, _lstEffects, __set__spell, dispatchEvent, unloadThis;
    function SpellFullInfosViewer()
    {
        super();
    } // End of the function
    function set spell(oSpell)
    {
        if (oSpell == undefined)
        {
            return;
        } // end if
        if (oSpell == _oSpell)
        {
            return;
        } // end if
        if (!oSpell.isValid)
        {
            _oSpell = new dofus.datacenter.Spell(oSpell.ID, 1);
        }
        else
        {
            _oSpell = oSpell;
        } // end else if
        if (this.__get__initialized())
        {
            this.updateData();
        } // end if
        //return (this.spell());
        null;
    } // End of the function
    function get spell()
    {
        return (_oSpell);
    } // End of the function
    function init()
    {
        super.init(false, dofus.graphics.gapi.controls.SpellFullInfosViewer.CLASS_NAME);
    } // End of the function
    function createChildren()
    {
        this.addToQueue({object: this, method: addListeners});
        this.addToQueue({object: this, method: initData});
        this.addToQueue({object: this, method: initTexts});
        this.hideAllCheck();
        _btnTabCreature._visible = false;
        _btnTabGlyph._visible = false;
        _btnTabTrap._visible = false;
    } // End of the function
    function addListeners()
    {
        _btnTabNormal.addEventListener("click", this);
        _btnTabCritical.addEventListener("click", this);
        _btnTabCreature.addEventListener("click", this);
        _btnTabGlyph.addEventListener("click", this);
        _btnTabTrap.addEventListener("click", this);
        _btnLevel1.addEventListener("click", this);
        _btnLevel2.addEventListener("click", this);
        _btnLevel3.addEventListener("click", this);
        _btnLevel4.addEventListener("click", this);
        _btnLevel5.addEventListener("click", this);
        _btnLevel6.addEventListener("click", this);
        _btnClose.addEventListener("click", this);
    } // End of the function
    function initData()
    {
        this.updateData();
    } // End of the function
    function initTexts()
    {
        _lblEffectsTitle.__set__text(api.lang.getText("EFFECTS"));
        _lblOtherTitle.__set__text(api.lang.getText("OTHER_CHARACTERISTICS"));
        _lblCriticalHit.__set__text(api.lang.getText("CRITICAL_HIT_PROBABILITY"));
        _lblCriticalMiss.__set__text(api.lang.getText("CRITICAL_MISS_PROBABILITY"));
        _lblCountByTurn.__set__text(api.lang.getText("COUNT_BY_TURN"));
        _lblCountByTurnByPlayer.__set__text(api.lang.getText("COUNT_BY_TURN_BY_PLAYER"));
        _lblDelay.__set__text(api.lang.getText("DELAY_RELAUNCH"));
        _lblRangeBoost.__set__text(api.lang.getText("RANGE_BOOST"));
        _lblLineOfSight.__set__text(api.lang.getText("LINE_OF_SIGHT"));
        _lblLineOnly.__set__text(api.lang.getText("LINE_ONLY"));
        _lblFreeCell.__set__text(api.lang.getText("FREE_CELL"));
        _btnTabNormal.__set__label(api.lang.getText("NORMAL_EFFECTS"));
        _btnTabCritical.__set__label(api.lang.getText("CRITICAL_EFECTS"));
        _btnTabCreature.__set__label(api.lang.getText("SUMMONED_CREATURE"));
        _btnTabGlyph.__set__label(api.lang.getText("GLYPH"));
        _btnTabTrap.__set__label(api.lang.getText("TRAP"));
    } // End of the function
    function updateData()
    {
        if (_oSpell != undefined)
        {
            _ldrIcon.__set__contentPath(_oSpell.iconFile);
            _lblName.__set__text(_oSpell.name);
            _lblLevel.__set__text(_oSpell.level != undefined ? (api.lang.getText("LEVEL") + " " + _oSpell.level) : (""));
            _lblRange.__set__text(_oSpell.rangeStr + " " + api.lang.getText("RANGE"));
            _lblAP.__set__text(_oSpell.apCost + " " + api.lang.getText("AP"));
            _txtDescription.__set__text(_oSpell.description);
            _btnTabCreature._visible = _oSpell.summonSpell;
            _btnTabGlyph._visible = _oSpell.glyphSpell;
            _btnTabTrap._visible = _oSpell.trapSpell;
            if (_oSpell.effectsCriticalHit[0] == undefined)
            {
                if (_sCurrentTab == "Critical")
                {
                    this.setCurrentTab("Normal");
                } // end if
                _btnTabCritical._alpha = 70;
                _btnTabCritical.__set__enabled(false);
            }
            else
            {
                _btnTabCritical._alpha = 100;
                _btnTabCritical.__set__enabled(true);
            } // end else if
            if (!_oSpell.summonSpell && _sCurrentTab == "Creature")
            {
                this.setCurrentTab("Normal");
            }
            else if (!_oSpell.glyphSpell && _sCurrentTab == "Glyph")
            {
                this.setCurrentTab("Normal");
            }
            else if (!_oSpell.trapSpell && _sCurrentTab == "Trap")
            {
                this.setCurrentTab("Normal");
            }
            else
            {
                this.updateCurrentTabInformations();
            } // end else if
            _lblCriticalHitValue.__set__text(_oSpell.criticalHit == 0 ? ("-") : ("1/" + _oSpell.criticalHit));
            _lblCriticalMissValue.__set__text(_oSpell.criticalFailure == 0 ? ("-") : ("1/" + _oSpell.criticalFailure));
            _lblCountByTurnValue.__set__text(_oSpell.launchCountByTurn == 0 ? ("-") : (_oSpell.launchCountByTurn));
            _lblCountByTurnByPlayerValue.__set__text(_oSpell.launchCountByPlayerTurn == 0 ? ("-") : (_oSpell.launchCountByPlayerTurn));
            _lblDelayValue.__set__text(_oSpell.delayBetweenLaunch >= 63 ? ("inf.") : (_oSpell.delayBetweenLaunch == 0 ? ("-") : (_oSpell.delayBetweenLaunch)));
            _mcCrossRangeBoost._visible = !_oSpell.canBoostRange;
            _mcCheckRangeBoost._visible = _oSpell.canBoostRange;
            _mcCrossLineOfSight._visible = !_oSpell.lineOfSight;
            _mcCheckLineOfSight._visible = _oSpell.lineOfSight;
            _mcCrossLineOnly._visible = !_oSpell.lineOnly;
            _mcCheckLineOnly._visible = _oSpell.lineOnly;
            _mcCrossFreeCell._visible = !_oSpell.freeCell;
            _mcCheckFreeCell._visible = _oSpell.freeCell;
            if (_oSpell.level != undefined)
            {
                for (var _loc3 = 1; _loc3 <= 6; ++_loc3)
                {
                    var _loc2 = this["_btnLevel" + _loc3];
                    var _loc4 = _loc3 == _oSpell.level;
                    _loc2.__set__selected(_loc4);
                    _loc2.__set__enabled(!_loc4);
                    if (_loc3 <= _oSpell.maxLevel)
                    {
                        _loc2._alpha = 100;
                        continue;
                    } // end if
                    _loc2.__set__enabled(false);
                    _loc2._alpha = 20;
                } // end of for
            }
            else
            {
                for (var _loc3 = 1; _loc3 <= 6; ++_loc3)
                {
                    _loc2 = this["_btnLevel" + _loc3];
                    _loc2.__set__selected(false);
                    _loc2.__set__enabled(false);
                    _loc2._alpha = 20;
                } // end of for
            } // end else if
        }
        else
        {
            _ldrIcon.__set__contentPath("");
            _lblName.__set__text("");
            _lblLevel.__set__text("");
            _lblRange.__set__text("");
            _lblAP.__set__text("");
            _txtDescription.__set__text("");
            _lblCriticalHitValue.__set__text("");
            _lblCriticalMissValue.__set__text("");
            _lblCountByTurnValue.__set__text("");
            _lblCountByTurnByPlayerValue.__set__text("");
            _lblDelayValue.__set__text("");
            this.hideAllCheck();
        } // end else if
    } // End of the function
    function updateCurrentTabInformations()
    {
        switch (_sCurrentTab)
        {
            case "Normal":
            {
                _lstEffects.__set__dataProvider(_oSpell.effectsNormalHit);
                break;
            } 
            case "Critical":
            {
                _lstEffects.__set__dataProvider(_oSpell.effectsCriticalHit);
                break;
            } 
            case "Creature":
            {
                var _loc5 = _oSpell.effectsNormalHit;
                var _loc4;
                for (var _loc3 = 0; _loc3 < _loc5.length; ++_loc3)
                {
                    _loc4 = _loc5[_loc3];
                    if (_loc4.type == 181)
                    {
                        break;
                    } // end if
                    if (_loc4.type = 180)
                    {
                        var _loc7 = new ank.utils.ExtendedArray();
                        var _loc2 = api.datacenter.Player.data;
                        _loc7.push(_loc2.Name + " (" + api.lang.getText("LEVEL") + " " + _loc2.Level + ")");
                        _loc7.push(api.lang.getText("LP") + " : " + _loc2.LP);
                        _loc7.push(api.lang.getText("AP") + " : " + _loc2.AP);
                        _loc7.push(api.lang.getText("MP") + " : " + _loc2.MP);
                        _lstEffects.__set__dataProvider(_loc7);
                        return;
                    } // end if
                } // end of for
                _loc7 = new ank.utils.ExtendedArray();
                if (_loc4 != undefined)
                {
                    var _loc12 = _loc4.param1;
                    var _loc15 = _loc4.param2;
                    var _loc9 = api.lang.getMonstersText(_loc12);
                    var _loc8 = _loc9["g" + _loc15];
                    _loc7.push(_loc9.n + " (" + api.lang.getText("LEVEL") + " " + _loc8.l + ")");
                    _loc7.push(api.lang.getText("LP") + " : " + _loc8.lp);
                    _loc7.push(api.lang.getText("AP") + " : " + _loc8.ap);
                    _loc7.push(api.lang.getText("MP") + " : " + _loc8.mp);
                } // end if
                _lstEffects.__set__dataProvider(_loc7);
                break;
            } 
            case "Glyph":
            case "Trap":
            {
                var _loc6 = 400;
                if (_sCurrentTab == "Glyph")
                {
                    _loc6 = 401;
                } // end if
                _loc5 = _oSpell.effectsNormalHit;
                for (var _loc3 = 0; _loc3 < _loc5.length; ++_loc3)
                {
                    _loc4 = _loc5[_loc3];
                    if (_loc4.type == _loc6)
                    {
                        break;
                    } // end if
                } // end of for
                var _loc10 = new ank.utils.ExtendedArray();
                if (_loc4 != undefined)
                {
                    var _loc13 = _loc4.param1;
                    var _loc14 = _loc4.param2;
                    var _loc11 = api.kernel.CharactersManager.getSpellObjectFromData(_loc13 + "~" + _loc14 + "~");
                    _loc10 = _loc11.effectsNormalHit;
                } // end if
                _lstEffects.__set__dataProvider(_loc10);
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
    function hideAllCheck()
    {
        _mcCrossRangeBoost._visible = true;
        _mcCheckRangeBoost._visible = false;
        _mcCrossLineOfSight._visible = true;
        _mcCheckLineOfSight._visible = false;
        _mcCrossLineOnly._visible = true;
        _mcCheckLineOnly._visible = false;
        _mcCrossFreeCell._visible = true;
        _mcCheckFreeCell._visible = false;
    } // End of the function
    function click(oEvent)
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
                var _loc4 = oEvent.target._name.substr(9);
                var _loc2 = api.kernel.CharactersManager.getSpellObjectFromData(_oSpell.ID + "~" + _loc4);
                if (_loc2.isValid)
                {
                    this.__set__spell(_loc2);
                }
                else
                {
                    oEvent.target.selected = false;
                } // end else if
                break;
            } 
            case "_btnClose":
            {
                this.dispatchEvent({type: "close"});
                this.unloadThis();
                break;
            } 
        } // End of switch
    } // End of the function
    static var CLASS_NAME = "SpellFullInfosViewer";
    var _sCurrentTab = "Normal";
} // End of Class
#endinitclip
