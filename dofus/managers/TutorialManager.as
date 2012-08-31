// Action script...

// [Initial MovieClip Action of sprite 903]
#initclip 115
class dofus.managers.TutorialManager extends dofus.utils.ApiElement
{
    var _oVars, _oSequencer, _oTutorial, api, _oCurrentWaitingBloc, addToQueue, __get__isTutorialMode, __get__vars;
    function TutorialManager(oAPI)
    {
        super();
        this.initialize(oAPI);
    } // End of the function
    function get isTutorialMode()
    {
        return (_bInTutorialMode);
    } // End of the function
    function get vars()
    {
        var _loc2 = new String();
        for (var _loc3 in _oVars)
        {
            _loc2 = _loc2 + (_loc3 + ":" + _oVars[_loc3] + "\n");
        } // end of for...in
        return (_loc2);
    } // End of the function
    function initialize(oAPI)
    {
        super.initialize(oAPI);
        _oSequencer = new ank.utils.Sequencer();
    } // End of the function
    function clear()
    {
        _bInTutorialMode = false;
        ank.utils.Timer.removeTimer(this, "tutorial");
        _oVars = new Object();
    } // End of the function
    function start(oTutorial)
    {
        _bInTutorialMode = true;
        _oVars = new Object();
        _oTutorial = oTutorial;
        var _loc2 = oTutorial.getRootBloc();
        this.executeBloc(_loc2);
        if (_oTutorial.__get__canCancel())
        {
            api.ui.loadUIComponent("Tutorial", "Tutorial");
        } // end if
    } // End of the function
    function cancel()
    {
        var _loc2 = _oTutorial.getRootExitBloc();
        if (_loc2 == undefined)
        {
            this.terminate(0);
        }
        else
        {
            this.executeBloc(_loc2);
        } // end else if
    } // End of the function
    function terminate(nActionListID)
    {
        this.clear();
        var _loc2 = api.datacenter.Player.data.cellNum;
        var _loc3 = api.datacenter.Player.data.direction;
        api.network.Tutorial.end(nActionListID, _loc2, _loc3);
        api.ui.unloadUIComponent("Tutorial");
    } // End of the function
    function executeBloc(oBloc)
    {
        ank.utils.Timer.removeTimer(this, "tutorial");
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
                        _oSequencer.addAction(false, this, addToVariable, oBloc.params);
                        break;
                    } 
                    case "VAR_SET":
                    {
                        _oSequencer.addAction(false, this, setToVariable, oBloc.params);
                        break;
                    } 
                    case "GFX_CLEAN_MAP":
                    {
                        _oSequencer.addAction(false, api.gfx, api.gfx.cleanMap, [undefined, true]);
                        break;
                    } 
                    case "GFX_SELECT":
                    {
                        _oSequencer.addAction(false, api.gfx, api.gfx.select, [oBloc.params[0], oBloc.params[1]]);
                        break;
                    } 
                    case "GFX_UNSELECT":
                    {
                        _oSequencer.addAction(false, api.gfx, api.gfx.unSelect, [oBloc.params[0], oBloc.params[1]]);
                        break;
                    } 
                    case "GFX_GRID":
                    {
                        if (oBloc.params[0] == true)
                        {
                            _oSequencer.addAction(false, api.gfx, api.gfx.drawGrid, [false]);
                        }
                        else
                        {
                            _oSequencer.addAction(false, api.gfx, api.gfx.removeGrid, []);
                        } // end else if
                        break;
                    } 
                    case "GFX_ADD_INDICATOR":
                    {
                        var _loc6 = api.gfx.mapHandler.getCellData(oBloc.params[0]).mc;
                        if (_loc6 == undefined)
                        {
                            ank.utils.Logger.err("[GFX_ADD_INDICATOR] la cellule n\'existe pas");
                            break;
                        } // end if
                        var _loc9 = {x: _loc6._x, y: _loc6._y};
                        _loc6._parent.localToGlobal(_loc9);
                        var _loc19 = _loc9.x;
                        var _loc17 = _loc9.y;
                        _oSequencer.addAction(false, api.ui, api.ui.unloadUIComponent, ["Indicator"]);
                        _oSequencer.addAction(false, api.ui, api.ui.loadUIComponent, ["Indicator", "Indicator", {coordinates: [_loc19, _loc17], offset: oBloc.params[1], rotate: false}, {bAlwaysOnTop: true}]);
                        break;
                    } 
                    case "GFX_ADD_PLAYER_SPRITE":
                    {
                        var _loc20 = api.datacenter.Player.data;
                        _oSequencer.addAction(false, api.gfx, api.gfx.addSprite, [_loc20.id, _loc20]);
                        break;
                    } 
                    case "GFX_ADD_SPRITE":
                    {
                        _loc20 = new dofus.datacenter.PlayableCharacter(oBloc.params[0], ank.battlefield.mc.Sprite, dofus.Constants.CLIPS_PERSOS_PATH + oBloc.params[1] + ".swf", oBloc.params[2], oBloc.params[3], oBloc.params[1]);
                        _loc20.name = oBloc.params[4] == undefined ? ("") : (oBloc.params[4]);
                        _loc20.color1 = oBloc.params[5] == undefined ? (-1) : (oBloc.params[5]);
                        _loc20.color2 = oBloc.params[6] == undefined ? (-1) : (oBloc.params[6]);
                        _loc20.color3 = oBloc.params[7] == undefined ? (-1) : (oBloc.params[7]);
                        _oSequencer.addAction(false, api.gfx, api.gfx.addSprite, [_loc20.id, _loc20]);
                        break;
                    } 
                    case "GFX_REMOVE_SPRITE":
                    {
                        _oSequencer.addAction(false, api.gfx, api.gfx.removeSprite, [oBloc.params[0], false]);
                        break;
                    } 
                    case "GFX_MOVE_SPRITE":
                    {
                        var _loc18 = this.getSpriteIDFromData(oBloc.params[0]);
                        _loc20 = api.datacenter.Sprites.getItemAt(_loc18);
                        var _loc13 = ank.battlefield.utils.Pathfinding.pathFind(api.gfx.mapHandler, _loc20.cellNum, oBloc.params[1], {bAllDirections: false, bIgnoreSprites: true, bCellNumOnly: true, bWithBeginCellNum: true});
                        if (_loc13 != null)
                        {
                            api.gfx.spriteHandler.moveSprite(_loc20.id, _loc13, _oSequencer, false, undefined, false, false);
                        } // end if
                        break;
                    } 
                    case "GFX_ADD_SPRITE_BUBBLE":
                    {
                        _loc18 = this.getSpriteIDFromData(oBloc.params[0]);
                        _oSequencer.addAction(true, api.gfx, api.gfx.removeSpriteBubble, [_loc18], 200);
                        _oSequencer.addAction(false, api.gfx, api.gfx.addSpriteBubble, [_loc18, oBloc.params[1]]);
                        break;
                    } 
                    case "GFX_CLEAR_SPRITE_BUBBLES":
                    {
                        _oSequencer.addAction(false, api.gfx.textHandler, api.gfx.textHandler.clear, []);
                        break;
                    } 
                    case "GFX_SPRITE_DIR":
                    {
                        _loc18 = this.getSpriteIDFromData(oBloc.params[0]);
                        _oSequencer.addAction(false, api.gfx, api.gfx.setSpriteDirection, [_loc18, oBloc.params[1]]);
                        break;
                    } 
                    case "GFX_SPRITE_POS":
                    {
                        _loc18 = this.getSpriteIDFromData(oBloc.params[0]);
                        _oSequencer.addAction(false, api.gfx, api.gfx.setSpritePosition, [_loc18, oBloc.params[1]]);
                        break;
                    } 
                    case "GFX_SPRITE_VISUALEFFECT":
                    {
                        _loc18 = this.getSpriteIDFromData(oBloc.params[0]);
                        var _loc4 = new ank.battlefield.datacenter.VisualEffect();
                        _loc4.file = dofus.Constants.SPELLS_PATH + oBloc.params[1] + ".swf";
                        _loc4.level = isNaN(Number(oBloc.params[3])) ? (1) : (Number(oBloc.params[3]));
                        _loc4.bInFrontOfSprite = true;
                        _oSequencer.addAction(false, api.gfx, api.gfx.addVisualEffectOnSprite, [_loc18, _loc4, oBloc.params[2], oBloc.params[4]]);
                        break;
                    } 
                    case "GFX_SPRITE_ANIM":
                    {
                        _loc18 = this.getSpriteIDFromData(oBloc.params[0]);
                        _oSequencer.addAction(false, api.gfx, api.gfx.setSpriteAnim, [_loc18, oBloc.params[1]]);
                        break;
                    } 
                    case "GFX_SPRITE_EXEC_FUNCTION":
                    {
                        _loc18 = this.getSpriteIDFromData(oBloc.params[0]);
                        _loc20 = api.datacenter.Sprites.getItemAt(_loc18);
                        var _loc11 = _loc20[oBloc.params[1]];
                        if (typeof(_loc11) != "function")
                        {
                            ank.utils.Logger.err("[GFX_SPRITE_EXEC_FUNCTION] la fonction n\'existe pas");
                            break;
                        } // end if
                        _oSequencer.addAction(false, _loc20, _loc11, oBloc.params[2]);
                        break;
                    } 
                    case "GFX_SPRITE_SET_PROPERTY":
                    {
                        _loc18 = this.getSpriteIDFromData(oBloc.params[0]);
                        _loc20 = api.datacenter.Sprites.getItemAt(_loc18);
                        _oSequencer.addAction(false, this, setObjectPropertyValue, [_loc20, oBloc.params[1], oBloc.params[2]]);
                        break;
                    } 
                    case "GFX_DRAW_ZONE":
                    {
                        _oSequencer.addAction(false, api.gfx, api.gfx.drawZone, oBloc.params);
                        break;
                    } 
                    case "GFX_CLEAR_ALL_ZONES":
                    {
                        _oSequencer.addAction(false, api.gfx, api.gfx.clearAllZones, []);
                        break;
                    } 
                    case "GFX_ADD_POINTER_SHAPE":
                    {
                        _oSequencer.addAction(false, api.gfx, api.gfx.addPointerShape, oBloc.params);
                        break;
                    } 
                    case "GFX_CLEAR_POINTER":
                    {
                        _oSequencer.addAction(false, api.gfx, api.gfx.clearPointer, []);
                        break;
                    } 
                    case "GFX_HIDE_POINTER":
                    {
                        _oSequencer.addAction(false, api.gfx, api.gfx.hidePointer, []);
                        break;
                    } 
                    case "GFX_DRAW_POINTER":
                    {
                        _oSequencer.addAction(false, api.gfx, api.gfx.drawPointer, oBloc.params);
                        break;
                    } 
                    case "INTERAC_SET":
                    {
                        _oSequencer.addAction(false, api.gfx, api.gfx.setInteraction, [ank.battlefield.Constants[oBloc.params[0]]]);
                        break;
                    } 
                    case "INTERAC_SET_ONCELLS":
                    {
                        _oSequencer.addAction(false, api.gfx, api.gfx.setInteractionOnCells, [oBloc.params[0], ank.battlefield.Constants[oBloc.params[1]]]);
                        break;
                    } 
                    case "UI_ADD_INDICATOR":
                    {
                        var _loc8 = api.ui.getUIComponent(oBloc.params[0])[oBloc.params[1]];
                        var _loc3 = _loc8.getBounds();
                        var _loc15 = _loc3.xMax - _loc3.xMin;
                        var _loc14 = _loc3.yMax - _loc3.yMin;
                        _loc19 = _loc15 / 2 + _loc8._x + _loc3.xMin;
                        _loc17 = _loc14 / 2 + _loc8._y + _loc3.yMin;
                        var _loc21 = Math.sqrt(Math.pow(_loc15, 2) + Math.pow(_loc14, 2)) / 2;
                        _oSequencer.addAction(false, api.ui, api.ui.unloadUIComponent, ["Indicator"]);
                        _oSequencer.addAction(false, api.ui, api.ui.loadUIComponent, ["Indicator", "Indicator", {coordinates: [_loc19, _loc17], offset: _loc21}, {bAlwaysOnTop: true}]);
                        break;
                    } 
                    case "UI_REMOVE_INDICATOR":
                    {
                        _oSequencer.addAction(false, api.ui, api.ui.unloadUIComponent, ["Indicator"]);
                        break;
                    } 
                    case "UI_OPEN":
                    {
                        _oSequencer.addAction(false, api.ui, api.ui.loadUIComponent, [oBloc.params[0], oBloc.params[0], oBloc.params[1], oBloc.params[2]]);
                        break;
                    } 
                    case "UI_OPEN_AUTOHIDE":
                    {
                        _oSequencer.addAction(false, api.ui, api.ui.loadUIAutoHideComponent, [oBloc.params[0], oBloc.params[0], oBloc.params[1], oBloc.params[2]]);
                        break;
                    } 
                    case "UI_CLOSE":
                    {
                        _oSequencer.addAction(false, api.ui, api.ui.unloadUIComponent, [oBloc.params[0]]);
                        break;
                    } 
                    case "UI_EXEC_FUNCTION":
                    {
                        var _loc12 = api.ui.getUIComponent(oBloc.params[0]);
                        _loc11 = _loc12[oBloc.params[1]];
                        if (typeof(_loc11) != "function")
                        {
                            ank.utils.Logger.err("[UI_EXEC_FUNCTION] la fonction n\'existe pas");
                            break;
                        } // end if
                        _oSequencer.addAction(false, _loc12, _loc11, oBloc.params[2]);
                        break;
                    } 
                    case "ADD_SPELL":
                    {
                        var _loc16 = new dofus.datacenter.Spell(oBloc.params[0], oBloc.params[1], oBloc.params[2]);
                        _oSequencer.addAction(false, api.datacenter.Player, api.datacenter.Player.updateSpellPosition, [_loc16]);
                        break;
                    } 
                    case "SET_SPELLS":
                    {
                        _oSequencer.addAction(false, api.network.Spells, api.network.Spells.onList, [oBloc.params.join(";")]);
                        break;
                    } 
                    case "REMOVE_SPELL":
                    {
                        _oSequencer.addAction(false, api.datacenter.Player, api.datacenter.Player.removeSpell, oBloc.params);
                        break;
                    } 
                    case "END":
                    {
                        _oSequencer.addAction(false, this, terminate, oBloc.params);
                        if (!_oSequencer.isPlaying())
                        {
                            _oSequencer.execute(true);
                        } // end if
                        return;
                    } 
                    default:
                    {
                        ank.utils.Logger.err("[executeBloc] Code action " + oBloc.actionCode + " inconnu");
                        return;
                    } 
                } // End of switch
                _oSequencer.addAction(false, this, callNextBloc, [oBloc.nextBlocID]);
                if (!_oSequencer.isPlaying())
                {
                    _oSequencer.execute(true);
                } // end if
                break;
            } 
            case dofus.datacenter.TutorialBloc.TYPE_WAITING:
            {
                _oCurrentWaitingBloc = oBloc;
                if (!(oBloc instanceof dofus.datacenter.TutorialWaiting))
                {
                    ank.utils.Logger.log("[executeBloc] le type ne correspond pas");
                    return;
                } // end if
                ank.utils.Timer.removeTimer(this, "tutorial");
                if (oBloc.timeout != 0)
                {
                    ank.utils.Timer.setTimer(this, "tutorial", this, onWaitingTimeout, oBloc.timeout, [oBloc]);
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
                var _loc7 = this.extractValue(oBloc.left);
                var _loc10 = this.extractValue(oBloc.right);
                var _loc5 = false;
                switch (oBloc.operator)
                {
                    case "=":
                    {
                        _loc5 = _loc7 == _loc10;
                        break;
                    } 
                    case "<":
                    {
                        _loc5 = _loc7 < _loc10;
                        break;
                    } 
                    case ">":
                    {
                        _loc5 = _loc7 > _loc10;
                        break;
                    } 
                } // End of switch
                if (_loc5)
                {
                    _oSequencer.addAction(false, this, callNextBloc, [oBloc.nextBlocTrueID]);
                }
                else
                {
                    _oSequencer.addAction(false, this, callNextBloc, [oBloc.nextBlocFalseID]);
                } // end else if
                if (!_oSequencer.isPlaying())
                {
                    _oSequencer.execute(true);
                } // end if
                break;
            } 
            default:
            {
                ank.utils.Logger.log("[executeBloc] mauvais type");
                break;
            } 
        } // End of switch
    } // End of the function
    function callNextBloc(mNextBlocID)
    {
        ank.utils.Timer.removeTimer(this, "tutorial");
        var _loc3;
        if (typeof(mNextBlocID) == "object")
        {
            _loc3 = mNextBlocID[random(mNextBlocID.length)];
        }
        else
        {
            _loc3 = mNextBlocID;
        } // end else if
        this.addToQueue({object: this, method: executeBloc, params: [_oTutorial.getBloc(_loc3)]});
    } // End of the function
    function callCurrentBlocDefaultCase()
    {
        var _loc2 = _oCurrentWaitingBloc.cases[dofus.datacenter.TutorialWaitingCase.CASE_DEFAULT];
        if (_loc2 != undefined)
        {
            this.callNextBloc(_loc2.__get__nextBlocID());
        } // end if
    } // End of the function
    function setObjectPropertyValue(oObject, sProperty, mValue)
    {
        if (oObject == undefined)
        {
            ank.utils.Logger.err("[setObjectPropertyValue] l\'objet n\'existe pas");
            return;
        } // end if
        oObject[sProperty] = mValue;
    } // End of the function
    function getSpriteIDFromData(mIDorCellNum)
    {
        if (typeof(mIDorCellNum) == "number")
        {
            return (mIDorCellNum == 0 ? (api.datacenter.Player.ID) : (mIDorCellNum));
        }
        else if (typeof(mIDorCellNum) == "string")
        {
            return (api.datacenter.Map.data[mIDorCellNum.substr(1)].spriteOnID);
        } // end else if
    } // End of the function
    function setToVariable(sVarName, nValue)
    {
        sVarName = this.extractVarName(sVarName);
        _oVars[sVarName] = nValue;
    } // End of the function
    function addToVariable(sVarName, nValue)
    {
        sVarName = this.extractVarName(sVarName);
        if (_oVars[sVarName] == undefined)
        {
            _oVars[sVarName] = nValue;
        }
        else
        {
            _oVars[sVarName] = _oVars[sVarName] + nValue;
        } // end else if
    } // End of the function
    function extractVarName(sVarName)
    {
        var _loc3 = sVarName.split("|");
        if (_loc3.length != 0)
        {
            sVarName = _loc3[0];
            for (var _loc2 = 1; _loc2 < _loc3.length; ++_loc2)
            {
                sVarName = sVarName + ("_" + _oVars[_loc3[_loc2]]);
            } // end of for
        } // end if
        return (sVarName);
    } // End of the function
    function extractValue(mVarOrValue)
    {
        if (typeof(mVarOrValue) == "string")
        {
            return (_oVars[this.extractVarName(mVarOrValue)]);
        }
        else
        {
            return (mVarOrValue);
        } // end else if
    } // End of the function
    function onWaitingTimeout(oBloc)
    {
        this.callNextBloc(oBloc.cases[dofus.datacenter.TutorialWaitingCase.CASE_TIMEOUT].nextBlocID);
    } // End of the function
    function onWaitingCase(oEvent)
    {
        var _loc5 = oEvent.code;
        var _loc4 = oEvent.params;
        var _loc2 = _oCurrentWaitingBloc.cases[_loc5];
        if (_loc2 != undefined)
        {
            switch (_loc2.__get__code())
            {
                case "CELL_RELEASE":
                case "CELL_OVER":
                case "CELL_OUT":
                case "SPRITE_RELEASE":
                case "SPELL_CONTAINER_SELECT":
                case "OBJECT_CONTAINER_SELECT":
                {
                    for (var _loc3 = 0; _loc3 < _loc2.params.length; ++_loc3)
                    {
                        if (_loc4[0] == _loc2.params[_loc3][0])
                        {
                            this.callNextBloc(_loc2.nextBlocID[_loc3] == undefined ? (_loc2.__get__nextBlocID()) : (_loc2.nextBlocID[_loc3]));
                            return;
                        } // end if
                    } // end of for
                    break;
                } 
                case "OBJECT_RELEASE":
                {
                    for (var _loc3 = 0; _loc3 < _loc2.params.length; ++_loc3)
                    {
                        if (_loc4[0] == _loc2.params[_loc3][0] && _loc4[1] == _loc2.params[_loc3][1])
                        {
                            this.callNextBloc(_loc2.nextBlocID[_loc3] == undefined ? (_loc2.__get__nextBlocID()) : (_loc2.nextBlocID[_loc3]));
                            return;
                        } // end if
                    } // end of for
                    break;
                } 
                default:
                {
                    this.callNextBloc(_loc2.__get__nextBlocID());
                    return;
                } 
            } // End of switch
            this.callCurrentBlocDefaultCase();
        }
        else
        {
            this.callCurrentBlocDefaultCase();
        } // end else if
    } // End of the function
    var _bInTutorialMode = false;
} // End of Class
#endinitclip
