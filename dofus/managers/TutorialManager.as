// Action script...

// [Initial MovieClip Action of sprite 20838]
#initclip 103
if (!dofus.managers.TutorialManager)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.managers)
    {
        _global.dofus.managers = new Object();
    } // end if
    var _loc1 = (_global.dofus.managers.TutorialManager = function (oAPI)
    {
        super();
        dofus.managers.TutorialManager._sSelf = this;
        this.initialize(oAPI);
    }).prototype;
    _loc1.__get__isTutorialMode = function ()
    {
        return (this._bInTutorialMode);
    };
    _loc1.__get__vars = function ()
    {
        var _loc2 = new String();
        for (var k in this._oVars)
        {
            _loc2 = _loc2 + (k + ":" + this._oVars[k] + "\n");
        } // end of for...in
        return (_loc2);
    };
    (_global.dofus.managers.TutorialManager = function (oAPI)
    {
        super();
        dofus.managers.TutorialManager._sSelf = this;
        this.initialize(oAPI);
    }).getInstance = function ()
    {
        return (dofus.managers.TutorialManager._sSelf);
    };
    _loc1.initialize = function (oAPI)
    {
        super.initialize(oAPI);
        this._oSequencer = new ank.utils.Sequencer();
    };
    _loc1.clear = function ()
    {
        this._bInTutorialMode = false;
        ank.utils.Timer.removeTimer(this, "tutorial");
        this._oVars = new Object();
    };
    _loc1.start = function (oTutorial)
    {
        this._bInTutorialMode = true;
        this._oVars = new Object();
        this._oTutorial = oTutorial;
        var _loc3 = oTutorial.getRootBloc();
        this.executeBloc(_loc3);
        if (this._oTutorial.canCancel)
        {
            this.api.ui.loadUIComponent("Tutorial", "Tutorial");
        } // end if
    };
    _loc1.cancel = function ()
    {
        var _loc2 = this._oTutorial.getRootExitBloc();
        if (_loc2 == undefined)
        {
            this.terminate(0);
        }
        else
        {
            this.executeBloc(_loc2);
        } // end else if
    };
    _loc1.terminate = function (nActionListID)
    {
        this.clear();
        var _loc3 = this.api.datacenter.Player.data.cellNum;
        var _loc4 = this.api.datacenter.Player.data.direction;
        this.api.network.Tutorial.end(nActionListID, _loc3, _loc4);
        this.api.ui.unloadUIComponent("Tutorial");
    };
    _loc1.executeBloc = function (oBloc)
    {
        ank.utils.Timer.removeTimer(this, "tutorial");
        for (var i in oBloc.params)
        {
            if (typeof(oBloc.params[i]) == "string")
            {
                var _loc3 = String(oBloc.params[i]);
                if (_loc3.substr(0, 16) == "!LOCALIZEDSTRING" && _loc3.substr(_loc3.length - 1, 1) == "!")
                {
                    var _loc4 = Number(_loc3.substring(16, _loc3.length - 1));
                    if (!_global.isNaN(_loc4))
                    {
                        oBloc.params[i] = this.api.lang.getTutorialText(_loc4);
                    } // end if
                } // end if
                continue;
            } // end if
            if (typeof(oBloc.params[i]) == "object")
            {
                for (var s in oBloc.params[i])
                {
                    if (typeof(oBloc.params[i][s]) == "string")
                    {
                        var _loc5 = String(oBloc.params[i][s]);
                        if (_loc5.substr(0, 16) == "!LOCALIZEDSTRING" && _loc5.substr(_loc5.length - 1, 1) == "!")
                        {
                            var _loc6 = Number(_loc5.substring(16, _loc5.length - 1));
                            if (!_global.isNaN(_loc6))
                            {
                                oBloc.params[i][s] = this.api.lang.getTutorialText(_loc6);
                            } // end if
                        } // end if
                    } // end if
                } // end of for...in
            } // end if
        } // end of for...in
        switch (oBloc.type)
        {
            case dofus.datacenter.TutorialBloc.TYPE_ACTION:
            {
                if (!(oBloc instanceof dofus.datacenter.TutorialAction))
                {
                    ank.utils.Logger.err("[executeBloc] le type ne correspond pas");
                    return;
                } // end if
                if (!oBloc.keepLastWaitingBloc)
                {
                    delete this._oCurrentWaitingBloc;
                } // end if
                switch (oBloc.actionCode)
                {
                    case "VAR_ADD":
                    {
                        this._oSequencer.addAction(false, this, this.addToVariable, oBloc.params);
                        break;
                    } 
                    case "VAR_SET":
                    {
                        this._oSequencer.addAction(false, this, this.setToVariable, oBloc.params);
                        break;
                    } 
                    case "CHAT":
                    {
                        this._oSequencer.addAction(false, this.api.kernel, this.api.kernel.showMessage, [undefined, oBloc.params[0], oBloc.params[1]]);
                        break;
                    } 
                    case "GFX_CLEAN_MAP":
                    {
                        this._oSequencer.addAction(false, this.api.gfx, this.api.gfx.cleanMap, [undefined, true]);
                        break;
                    } 
                    case "GFX_SELECT":
                    {
                        this._oSequencer.addAction(false, this.api.gfx, this.api.gfx.select, [oBloc.params[0], oBloc.params[1]]);
                        break;
                    } 
                    case "GFX_UNSELECT":
                    {
                        this._oSequencer.addAction(false, this.api.gfx, this.api.gfx.unSelect, [oBloc.params[0], oBloc.params[1]]);
                        break;
                    } 
                    case "GFX_ALPHA":
                    {
                        this._oSequencer.addAction(false, this.api.gfx, this.api.gfx.setSpriteAlpha, [oBloc.params[0], oBloc.params[1]]);
                        break;
                    } 
                    case "GFX_GRID":
                    {
                        if (oBloc.params[0] == true)
                        {
                            this._oSequencer.addAction(false, this.api.gfx, this.api.gfx.drawGrid, [false]);
                        }
                        else
                        {
                            this._oSequencer.addAction(false, this.api.gfx, this.api.gfx.removeGrid, []);
                        } // end else if
                        break;
                    } 
                    case "GFX_ADD_INDICATOR":
                    {
                        var _loc7 = this.api.gfx.mapHandler.getCellData(oBloc.params[0]).mc;
                        if (_loc7 == undefined)
                        {
                            ank.utils.Logger.err("[GFX_ADD_INDICATOR] la cellule n\'existe pas");
                            break;
                        } // end if
                        var _loc8 = {x: _loc7._x, y: _loc7._y};
                        _loc7._parent.localToGlobal(_loc8);
                        var _loc9 = _loc8.x;
                        var _loc10 = _loc8.y;
                        this._oSequencer.addAction(false, this.api.ui, this.api.ui.unloadUIComponent, ["Indicator"]);
                        this._oSequencer.addAction(false, this.api.ui, this.api.ui.loadUIComponent, ["Indicator", "Indicator", {coordinates: [_loc9, _loc10], offset: oBloc.params[1], rotate: false}, {bAlwaysOnTop: true}]);
                        break;
                    } 
                    case "GFX_ADD_PLAYER_SPRITE":
                    {
                        var _loc11 = this.api.datacenter.Player.data;
                        this._oSequencer.addAction(false, this.api.gfx, this.api.gfx.addSprite, [_loc11.id, _loc11]);
                        break;
                    } 
                    case "GFX_ADD_SPRITE":
                    {
                        var _loc12 = new dofus.datacenter.PlayableCharacter(oBloc.params[0], ank.battlefield.mc.Sprite, dofus.Constants.CLIPS_PERSOS_PATH + oBloc.params[1] + ".swf", oBloc.params[2], oBloc.params[3], oBloc.params[1]);
                        _loc12.name = oBloc.params[4] == undefined ? ("") : (oBloc.params[4]);
                        _loc12.color1 = oBloc.params[5] == undefined ? (-1) : (oBloc.params[5]);
                        _loc12.color2 = oBloc.params[6] == undefined ? (-1) : (oBloc.params[6]);
                        _loc12.color3 = oBloc.params[7] == undefined ? (-1) : (oBloc.params[7]);
                        this._oSequencer.addAction(false, this.api.gfx, this.api.gfx.addSprite, [_loc12.id, _loc12]);
                        break;
                    } 
                    case "GFX_REMOVE_SPRITE":
                    {
                        this._oSequencer.addAction(false, this.api.gfx, this.api.gfx.removeSprite, [oBloc.params[0], false]);
                        break;
                    } 
                    case "GFX_MOVE_SPRITE":
                    {
                        var _loc13 = this.getSpriteIDFromData(oBloc.params[0]);
                        var _loc14 = this.api.datacenter.Sprites.getItemAt(_loc13);
                        var _loc15 = ank.battlefield.utils.Pathfinding.pathFind(this.api.gfx.mapHandler, _loc14.cellNum, oBloc.params[1], {bAllDirections: false, bIgnoreSprites: true, bCellNumOnly: true, bWithBeginCellNum: true});
                        if (_loc15 != null)
                        {
                            this.api.gfx.spriteHandler.moveSprite(_loc14.id, _loc15, this._oSequencer, false, undefined, false, false);
                        } // end if
                        break;
                    } 
                    case "GFX_ADD_SPRITE_BUBBLE":
                    {
                        var _loc16 = this.getSpriteIDFromData(oBloc.params[0]);
                        this._oSequencer.addAction(true, this.api.gfx, this.api.gfx.removeSpriteBubble, [_loc16], 200);
                        this._oSequencer.addAction(false, this.api.gfx, this.api.gfx.addSpriteBubble, [_loc16, oBloc.params[1]]);
                        break;
                    } 
                    case "GFX_CLEAR_SPRITE_BUBBLES":
                    {
                        this._oSequencer.addAction(false, this.api.gfx.textHandler, this.api.gfx.textHandler.clear, []);
                        break;
                    } 
                    case "GFX_SPRITE_DIR":
                    {
                        var _loc17 = this.getSpriteIDFromData(oBloc.params[0]);
                        this._oSequencer.addAction(false, this.api.gfx, this.api.gfx.setSpriteDirection, [_loc17, oBloc.params[1]]);
                        break;
                    } 
                    case "GFX_SPRITE_POS":
                    {
                        var _loc18 = this.getSpriteIDFromData(oBloc.params[0]);
                        this._oSequencer.addAction(false, this.api.gfx, this.api.gfx.setSpritePosition, [_loc18, oBloc.params[1]]);
                        break;
                    } 
                    case "GFX_SPRITE_VISUALEFFECT":
                    {
                        var _loc19 = this.getSpriteIDFromData(oBloc.params[0]);
                        var _loc20 = new ank.battlefield.datacenter.VisualEffect();
                        _loc20.file = dofus.Constants.SPELLS_PATH + oBloc.params[1] + ".swf";
                        _loc20.level = _global.isNaN(Number(oBloc.params[3])) ? (1) : (Number(oBloc.params[3]));
                        _loc20.bInFrontOfSprite = true;
                        this._oSequencer.addAction(false, this.api.gfx, this.api.gfx.addVisualEffectOnSprite, [_loc19, _loc20, oBloc.params[2], oBloc.params[4]]);
                        break;
                    } 
                    case "GFX_SPRITE_ANIM":
                    {
                        var _loc21 = this.getSpriteIDFromData(oBloc.params[0]);
                        this._oSequencer.addAction(false, this.api.gfx, this.api.gfx.setSpriteAnim, [_loc21, oBloc.params[1]]);
                        break;
                    } 
                    case "GFX_SPRITE_EXEC_FUNCTION":
                    {
                        var _loc22 = this.getSpriteIDFromData(oBloc.params[0]);
                        var _loc23 = this.api.datacenter.Sprites.getItemAt(_loc22);
                        var _loc24 = _loc23[oBloc.params[1]];
                        if (typeof(_loc24) != "function")
                        {
                            ank.utils.Logger.err("[GFX_SPRITE_EXEC_FUNCTION] la fonction n\'existe pas");
                            break;
                        } // end if
                        this._oSequencer.addAction(false, _loc23, _loc24, oBloc.params[2]);
                        break;
                    } 
                    case "GFX_SPRITE_SET_PROPERTY":
                    {
                        var _loc25 = this.getSpriteIDFromData(oBloc.params[0]);
                        var _loc26 = this.api.datacenter.Sprites.getItemAt(_loc25);
                        this._oSequencer.addAction(false, this, this.setObjectPropertyValue, [_loc26, oBloc.params[1], oBloc.params[2]]);
                        break;
                    } 
                    case "GFX_DRAW_ZONE":
                    {
                        this._oSequencer.addAction(false, this.api.gfx, this.api.gfx.drawZone, oBloc.params);
                        break;
                    } 
                    case "GFX_CLEAR_ALL_ZONES":
                    {
                        this._oSequencer.addAction(false, this.api.gfx, this.api.gfx.clearAllZones, []);
                        break;
                    } 
                    case "GFX_ADD_POINTER_SHAPE":
                    {
                        this._oSequencer.addAction(false, this.api.gfx, this.api.gfx.addPointerShape, oBloc.params);
                        break;
                    } 
                    case "GFX_CLEAR_POINTER":
                    {
                        this._oSequencer.addAction(false, this.api.gfx, this.api.gfx.clearPointer, []);
                        break;
                    } 
                    case "GFX_HIDE_POINTER":
                    {
                        this._oSequencer.addAction(false, this.api.gfx, this.api.gfx.hidePointer, []);
                        break;
                    } 
                    case "GFX_DRAW_POINTER":
                    {
                        this._oSequencer.addAction(false, this.api.gfx, this.api.gfx.drawPointer, oBloc.params);
                        break;
                    } 
                    case "GFX_OBJECT2_INTERACTIVE":
                    {
                        this._oSequencer.addAction(false, this.api.gfx, this.api.gfx.setObject2Interactive, [oBloc.params[0], oBloc.params[1], 1]);
                        break;
                    } 
                    case "INTERAC_SET":
                    {
                        this._oSequencer.addAction(false, this.api.gfx, this.api.gfx.setInteraction, [ank.battlefield.Constants[oBloc.params[0]]]);
                        break;
                    } 
                    case "INTERAC_SET_ONCELLS":
                    {
                        this._oSequencer.addAction(false, this.api.gfx, this.api.gfx.setInteractionOnCells, [oBloc.params[0], ank.battlefield.Constants[oBloc.params[1]]]);
                        break;
                    } 
                    case "UI_ADD_INDICATOR":
                    {
                        var _loc27 = this.api.ui.getUIComponent(oBloc.params[0]);
                        var _loc28 = eval(_loc27 + "." + oBloc.params[1]);
                        var _loc29 = _loc28.getBounds();
                        var _loc30 = _loc29.xMax - _loc29.xMin;
                        var _loc31 = _loc29.yMax - _loc29.yMin;
                        var _loc32 = _loc30 / 2 + _loc28._x + _loc29.xMin;
                        var _loc33 = _loc31 / 2 + _loc28._y + _loc29.yMin;
                        var _loc34 = {x: _loc32, y: _loc33};
                        _loc28._parent.localToGlobal(_loc34);
                        _loc32 = _loc34.x;
                        _loc33 = _loc34.y;
                        var _loc35 = Math.sqrt(Math.pow(_loc30, 2) + Math.pow(_loc31, 2)) / 2;
                        this._oSequencer.addAction(false, this.api.ui, this.api.ui.unloadUIComponent, ["Indicator"]);
                        this._oSequencer.addAction(false, this.api.ui, this.api.ui.loadUIComponent, ["Indicator", "Indicator", {coordinates: [_loc32, _loc33], offset: _loc35}, {bAlwaysOnTop: true}]);
                        break;
                    } 
                    case "UI_REMOVE_INDICATOR":
                    {
                        this._oSequencer.addAction(false, this.api.ui, this.api.ui.unloadUIComponent, ["Indicator"]);
                        break;
                    } 
                    case "UI_OPEN":
                    {
                        this._oSequencer.addAction(false, this.api.ui, this.api.ui.loadUIComponent, [oBloc.params[0], oBloc.params[0], oBloc.params[1], oBloc.params[2]]);
                        break;
                    } 
                    case "UI_OPEN_AUTOHIDE":
                    {
                        this._oSequencer.addAction(false, this.api.ui, this.api.ui.loadUIAutoHideComponent, [oBloc.params[0], oBloc.params[0], oBloc.params[1], oBloc.params[2]]);
                        break;
                    } 
                    case "UI_CLOSE":
                    {
                        this._oSequencer.addAction(false, this.api.ui, this.api.ui.unloadUIComponent, [oBloc.params[0]]);
                        break;
                    } 
                    case "UI_EXEC_FUNCTION":
                    {
                        var _loc36 = this.api.ui.getUIComponent(oBloc.params[0]);
                        var _loc37 = _loc36[oBloc.params[1]];
                        if (typeof(_loc37) != "function")
                        {
                            ank.utils.Logger.err("[UI_EXEC_FUNCTION] la fonction n\'existe pas");
                            break;
                        } // end if
                        this._oSequencer.addAction(false, _loc36, _loc37, oBloc.params[2]);
                        break;
                    } 
                    case "ADD_SPELL":
                    {
                        var _loc38 = new dofus.datacenter.Spell(oBloc.params[0], oBloc.params[1], oBloc.params[2]);
                        this._oSequencer.addAction(false, this.api.datacenter.Player, this.api.datacenter.Player.updateSpellPosition, [_loc38]);
                        break;
                    } 
                    case "SET_SPELLS":
                    {
                        this._oSequencer.addAction(false, this.api.network.Spells, this.api.network.Spells.onList, [oBloc.params.join(";")]);
                        break;
                    } 
                    case "REMOVE_SPELL":
                    {
                        this._oSequencer.addAction(false, this.api.datacenter.Player, this.api.datacenter.Player.removeSpell, oBloc.params);
                        break;
                    } 
                    case "END":
                    {
                        this._oSequencer.addAction(false, this, this.terminate, oBloc.params);
                        if (!this._oSequencer.isPlaying())
                        {
                            this._oSequencer.execute(true);
                        } // end if
                        return;
                    } 
                    default:
                    {
                        ank.utils.Logger.err("[executeBloc] Code action " + oBloc.actionCode + " inconnu");
                        return;
                    } 
                } // End of switch
                this._oSequencer.addAction(false, this, this.callNextBloc, [oBloc.nextBlocID]);
                if (!this._oSequencer.isPlaying())
                {
                    this._oSequencer.execute(true);
                } // end if
                break;
            } 
            case dofus.datacenter.TutorialBloc.TYPE_WAITING:
            {
                this._oCurrentWaitingBloc = oBloc;
                if (!(oBloc instanceof dofus.datacenter.TutorialWaiting))
                {
                    ank.utils.Logger.log("[executeBloc] le type ne correspond pas");
                    return;
                } // end if
                ank.utils.Timer.removeTimer(this, "tutorial");
                if (oBloc.timeout != 0)
                {
                    ank.utils.Timer.setTimer(this, "tutorial", this, this.onWaitingTimeout, oBloc.timeout, [oBloc]);
                } // end if
                break;
            } 
            case dofus.datacenter.TutorialBloc.TYPE_IF:
            {
                if (!(oBloc instanceof dofus.datacenter.TutorialIf))
                {
                    ank.utils.Logger.log("[executeBloc] le type ne correspond pas");
                    return;
                } // end if
                var _loc39 = this.extractValue(oBloc.left);
                var _loc40 = this.extractValue(oBloc.right);
                var _loc41 = false;
                switch (oBloc.operator)
                {
                    case "=":
                    {
                        _loc41 = _loc39 == _loc40;
                        break;
                    } 
                    case "<":
                    {
                        _loc41 = _loc39 < _loc40;
                        break;
                    } 
                    case ">":
                    {
                        _loc41 = _loc39 > _loc40;
                        break;
                    } 
                } // End of switch
                if (_loc41)
                {
                    this._oSequencer.addAction(false, this, this.callNextBloc, [oBloc.nextBlocTrueID]);
                }
                else
                {
                    this._oSequencer.addAction(false, this, this.callNextBloc, [oBloc.nextBlocFalseID]);
                } // end else if
                if (!this._oSequencer.isPlaying())
                {
                    this._oSequencer.execute(true);
                } // end if
                break;
            } 
            default:
            {
                ank.utils.Logger.log("[executeBloc] mauvais type");
                break;
            } 
        } // End of switch
    };
    _loc1.callNextBloc = function (mNextBlocID)
    {
        ank.utils.Timer.removeTimer(this, "tutorial");
        if (typeof(mNextBlocID) == "object")
        {
            var _loc3 = mNextBlocID[random(mNextBlocID.length)];
        }
        else
        {
            _loc3 = mNextBlocID;
        } // end else if
        this.addToQueue({object: this, method: this.executeBloc, params: [this._oTutorial.getBloc(_loc3)]});
    };
    _loc1.callCurrentBlocDefaultCase = function ()
    {
        var _loc2 = this._oCurrentWaitingBloc.cases[dofus.datacenter.TutorialWaitingCase.CASE_DEFAULT];
        if (_loc2 != undefined)
        {
            this.callNextBloc(_loc2.nextBlocID);
        } // end if
    };
    _loc1.setObjectPropertyValue = function (oObject, sProperty, mValue)
    {
        if (oObject == undefined)
        {
            ank.utils.Logger.err("[setObjectPropertyValue] l\'objet n\'existe pas");
            return;
        } // end if
        oObject[sProperty] = mValue;
    };
    _loc1.getSpriteIDFromData = function (mIDorCellNum)
    {
        if (typeof(mIDorCellNum) == "number")
        {
            return (mIDorCellNum == 0 ? (this.api.datacenter.Player.ID) : (mIDorCellNum));
        }
        else if (typeof(mIDorCellNum) == "string")
        {
            return (this.api.datacenter.Map.data[mIDorCellNum.substr(1)].spriteOnID);
        } // end else if
    };
    _loc1.setToVariable = function (sVarName, nValue)
    {
        sVarName = this.extractVarName(sVarName);
        this._oVars[sVarName] = nValue;
    };
    _loc1.addToVariable = function (sVarName, nValue)
    {
        sVarName = this.extractVarName(sVarName);
        if (this._oVars[sVarName] == undefined)
        {
            this._oVars[sVarName] = nValue;
        }
        else
        {
            this._oVars[sVarName] = this._oVars[sVarName] + nValue;
        } // end else if
    };
    _loc1.extractVarName = function (sVarName)
    {
        var _loc3 = sVarName.split("|");
        if (_loc3.length != 0)
        {
            sVarName = _loc3[0];
            var _loc4 = 1;
            
            while (++_loc4, _loc4 < _loc3.length)
            {
                sVarName = sVarName + ("_" + this._oVars[_loc3[_loc4]]);
            } // end while
        } // end if
        return (sVarName);
    };
    _loc1.extractValue = function (mVarOrValue)
    {
        if (typeof(mVarOrValue) == "string")
        {
            return (this._oVars[this.extractVarName(mVarOrValue)]);
        }
        else
        {
            return (mVarOrValue);
        } // end else if
    };
    _loc1.onWaitingTimeout = function (oBloc)
    {
        this.callNextBloc(oBloc.cases[dofus.datacenter.TutorialWaitingCase.CASE_TIMEOUT].nextBlocID);
    };
    _loc1.onWaitingCase = function (oEvent)
    {
        var _loc3 = oEvent.code;
        var _loc4 = oEvent.params;
        var _loc5 = this._oCurrentWaitingBloc.cases[_loc3];
        if (_loc5 != undefined)
        {
            switch (_loc5.code)
            {
                case "CELL_RELEASE":
                case "CELL_OVER":
                case "CELL_OUT":
                case "SPRITE_RELEASE":
                case "SPELL_CONTAINER_SELECT":
                case "OBJECT_CONTAINER_SELECT":
                {
                    var _loc6 = 0;
                    
                    while (++_loc6, _loc6 < _loc5.params.length)
                    {
                        if (_loc4[0] == _loc5.params[_loc6][0])
                        {
                            this.callNextBloc(_loc5.nextBlocID[_loc6] == undefined ? (_loc5.nextBlocID) : (_loc5.nextBlocID[_loc6]));
                            return;
                        } // end if
                    } // end while
                    break;
                } 
                case "OBJECT_RELEASE":
                {
                    var _loc7 = 0;
                    
                    while (++_loc7, _loc7 < _loc5.params.length)
                    {
                        if (_loc4[0] == _loc5.params[_loc7][0] && _loc4[1] == _loc5.params[_loc7][1])
                        {
                            this.callNextBloc(_loc5.nextBlocID[_loc7] == undefined ? (_loc5.nextBlocID) : (_loc5.nextBlocID[_loc7]));
                            return;
                        } // end if
                    } // end while
                    break;
                } 
                default:
                {
                    this.callNextBloc(_loc5.nextBlocID);
                    return;
                } 
            } // End of switch
            this.callCurrentBlocDefaultCase();
        }
        else
        {
            this.callCurrentBlocDefaultCase();
        } // end else if
    };
    _loc1.addProperty("vars", _loc1.__get__vars, function ()
    {
    });
    _loc1.addProperty("isTutorialMode", _loc1.__get__isTutorialMode, function ()
    {
    });
    ASSetPropFlags(_loc1, null, 1);
    _loc1._bInTutorialMode = false;
    (_global.dofus.managers.TutorialManager = function (oAPI)
    {
        super();
        dofus.managers.TutorialManager._sSelf = this;
        this.initialize(oAPI);
    })._sSelf = null;
} // end if
#endinitclip
