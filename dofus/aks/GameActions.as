// Action script...

// [Initial MovieClip Action of sprite 941]
#initclip 153
class dofus.aks.GameActions extends dofus.aks.Handler
{
    var aks, api, __get__aks;
    function GameActions(oAKS, oAPI)
    {
        super.initialize(oAKS, oAPI);
    } // End of the function
    function sendActions(nActionType, aParams)
    {
        var _loc2 = new String();
        aks.send("GA" + String(nActionType).addLeftChar("0", 3) + aParams.join(";"));
    } // End of the function
    function actionAck(nActionID)
    {
        aks.send("GKK" + nActionID, false);
    } // End of the function
    function actionCancel(nActionID, params)
    {
        aks.send("GKE" + nActionID + "|" + params, false);
    } // End of the function
    function challenge(sSpriteID)
    {
        this.sendActions(900, [sSpriteID]);
    } // End of the function
    function acceptChallenge(sSpriteID)
    {
        this.sendActions(901, [sSpriteID]);
    } // End of the function
    function refuseChallenge(sSpriteID)
    {
        this.sendActions(902, [sSpriteID]);
    } // End of the function
    function joinChallenge(nChallengeID, sSpriteID)
    {
        if (sSpriteID == undefined)
        {
            this.sendActions(903, [nChallengeID]);
        }
        else
        {
            this.sendActions(903, [nChallengeID, sSpriteID]);
        } // end else if
    } // End of the function
    function attack(sSpriteID)
    {
        this.sendActions(906, [sSpriteID]);
    } // End of the function
    function attackTaxCollector(sSpriteID)
    {
        this.sendActions(909, [sSpriteID]);
    } // End of the function
    function mutantAttack(sSpriteID)
    {
        this.sendActions(910, [sSpriteID]);
    } // End of the function
    function acceptMarriage(sSpriteID)
    {
        this.sendActions(618, [sSpriteID]);
    } // End of the function
    function refuseMarriage(sSpriteID)
    {
        this.sendActions(619, [sSpriteID]);
    } // End of the function
    function onActionsStart(sExtraData)
    {
        var _loc4 = sExtraData;
        if (_loc4 != api.datacenter.Player.ID)
        {
            return;
        } // end if
        var _loc2 = api.datacenter.Player.data;
        _loc2.GameActionsManager.m_bNextAction = true;
        if (api.datacenter.Game.isFight)
        {
            var _loc3 = _loc2.sequencer;
            _loc3.addAction(false, api.gfx, api.gfx.setInteraction, [ank.battlefield.Constants.INTERACTION_CELL_NONE]);
            _loc3.execute();
        } // end if
    } // End of the function
    function onActionsFinish(sExtraData)
    {
        var _loc4 = sExtraData.split("|");
        var _loc3 = Number(_loc4[0]);
        var _loc5 = _loc4[1];
        if (_loc5 != api.datacenter.Player.ID)
        {
            return;
        } // end if
        var _loc6 = api.datacenter.Player.data;
        var _loc2 = _loc6.sequencer;
        _loc6.GameActionsManager.m_bNextAction = false;
        if (api.datacenter.Game.isFight)
        {
            _loc2.addAction(false, api.kernel.GameManager, api.kernel.GameManager.setEnabledInteractionIfICan, [ank.battlefield.Constants.INTERACTION_CELL_RELEASE_OVER_OUT]);
            if (_loc3 != undefined)
            {
                _loc2.addAction(false, this, actionAck, [_loc3]);
            } // end if
            _loc2.addAction(false, api.kernel.GameManager, api.kernel.GameManager.cleanPlayer, [_loc5]);
            _loc2.execute();
        } // end if
    } // End of the function
    function onActions(sExtraData)
    {
        var _loc7;
        _loc7 = sExtraData.indexOf(";");
        var _loc13 = Number(sExtraData.substring(0, _loc7));
        sExtraData = sExtraData.substring(_loc7 + 1);
        _loc7 = sExtraData.indexOf(";");
        var _loc5 = Number(sExtraData.substring(0, _loc7));
        sExtraData = sExtraData.substring(_loc7 + 1);
        _loc7 = sExtraData.indexOf(";");
        var _loc4 = sExtraData.substring(0, _loc7);
        var _loc3 = sExtraData.substring(_loc7 + 1);
        if (_loc4.length == 0)
        {
            _loc4 = api.datacenter.Player.ID;
        } // end if
        var _loc14;
        var _loc21 = api.datacenter.Game.currentPlayerID;
        if (api.datacenter.Game.isFight && _loc21 != undefined)
        {
            _loc14 = _loc21;
        }
        else
        {
            _loc14 = _loc4;
        } // end else if
        var _loc16 = api.datacenter.Sprites.getItemAt(_loc14);
        var _loc2 = _loc16.sequencer;
        var _loc11 = _loc16.GameActionsManager;
        var _loc8 = true;
        _loc11.onServerResponse(_loc13);
        switch (_loc5)
        {
            case 0:
            {
                return;
            } 
            case 1:
            {
                var _loc59 = api.datacenter.Sprites.getItemAt(_loc4);
                var _loc54 = _loc59.forceRun || api.datacenter.Game.isInCreaturesMode && _loc59 instanceof dofus.datacenter.Character;
                var _loc55 = _loc59.forceWalk;
                var _loc67 = api.datacenter.Game.isFight ? (8) : (6);
                api.gfx.moveSprite(_loc4, _loc3, _loc2, !api.datacenter.Game.isFight, _loc54, _loc55, _loc67);
                if (api.datacenter.Game.isRunning)
                {
                    _loc2.addAction(false, api.gfx, api.gfx.unSelect, [true]);
                } // end if
                break;
            } 
            case 2:
            {
                if (_loc2 == undefined)
                {
                    api.gfx.clear();
                    api.datacenter.clearGame();
                    api.ui.loadUIComponent("CenterText", "CenterText", {text: api.lang.getText("LOADING_MAP"), timer: 2000}, {bForceLoad: true});
                    aks.Game.getMapData(api.datacenter.Map.id);
                }
                else
                {
                    _loc2.addAction(false, api.gfx, api.gfx.clear);
                    _loc2.addAction(false, api.datacenter, api.datacenter.clearGame);
                    if (_loc3.length == 0)
                    {
                        _loc2.addAction(true, ank.utils.Timer, ank.utils.Timer.setTimer, [_loc2, "gameactions", _loc2, _loc2.onActionEnd, 50]);
                    }
                    else
                    {
                        _loc2.addAction(true, api.ui, api.ui.loadUIComponent, ["Cinematic", "Cinematic", {file: dofus.Constants.CINEMATICS_PATH + _loc3 + ".swf", sequencer: _loc2}]);
                    } // end else if
                    _loc2.addAction(false, api.ui, api.ui.loadUIComponent, ["CenterText", "CenterText", {text: api.lang.getText("LOADING_MAP"), timer: 2000}, {bForceLoad: true}]);
                    _loc2.addAction(false, aks.Game, aks.Game.getMapData, [api.datacenter.Map.id]);
                } // end else if
                break;
            } 
            case 4:
            {
                var _loc9 = _loc3.split(",");
                var _loc58 = _loc9[0];
                var _loc40 = Number(_loc9[1]);
                var _loc19 = api.datacenter.Sprites.getItemAt(_loc58).mc;
                _loc2.addAction(false, _loc19, _loc19.setPosition, [_loc40]);
                break;
            } 
            case 5:
            {
                _loc9 = _loc3.split(",");
                _loc58 = _loc9[0];
                _loc40 = Number(_loc9[1]);
                api.gfx.slideSprite(_loc58, _loc40, _loc2);
                break;
            } 
            case 11:
            {
                _loc9 = _loc3.split(",");
                _loc58 = _loc9[0];
                var _loc52 = Number(_loc9[1]);
                _loc2.addAction(false, api.gfx.setSpriteDirection(_loc58, _loc52));
                break;
            } 
            case 100:
            case 108:
            case 110:
            {
                _loc9 = _loc3.split(",");
                _loc58 = _loc9[0];
                _loc59 = api.datacenter.Sprites.getItemAt(_loc58);
                var _loc12 = Number(_loc9[1]);
                if (_loc12 != 0)
                {
                    var _loc45 = _loc12 < 0 ? ("LOST_LP") : ("WIN_LP");
                    _loc2.addAction(false, api.kernel, api.kernel.showMessage, [undefined, api.lang.getText(_loc45, [_loc59.name, Math.abs(_loc12)]), "INFO_FIGHT_CHAT"]);
                    _loc2.addAction(false, _loc59, _loc59.updateLP, [_loc12]);
                }
                else
                {
                    _loc2.addAction(false, api.kernel, api.kernel.showMessage, [undefined, api.lang.getText("NOCHANGE_LP", [_loc59.name]), "INFO_FIGHT_CHAT"]);
                } // end else if
                break;
            } 
            case 101:
            case 102:
            case 111:
            case 120:
            case 168:
            {
                _loc9 = _loc3.split(",");
                _loc59 = api.datacenter.Sprites.getItemAt(_loc9[0]);
                _loc12 = Number(_loc9[1]);
                if (_loc12 == 0)
                {
                    break;
                } // end if
                if (_loc5 == 101 || _loc5 == 111 || _loc5 == 120 || _loc5 == 168)
                {
                    _loc45 = _loc12 < 0 ? ("LOST_AP") : ("WIN_AP");
                    _loc2.addAction(false, api.kernel, api.kernel.showMessage, [undefined, api.lang.getText(_loc45, [_loc59.name, Math.abs(_loc12)]), "INFO_FIGHT_CHAT"]);
                } // end if
                _loc2.addAction(false, _loc59, _loc59.updateAP, [_loc12, _loc5 == 102]);
                break;
            } 
            case 127:
            case 129:
            case 128:
            case 169:
            {
                _loc9 = _loc3.split(",");
                _loc58 = _loc9[0];
                _loc12 = Number(_loc9[1]);
                _loc59 = api.datacenter.Sprites.getItemAt(_loc58);
                if (_loc12 == 0)
                {
                    break;
                } // end if
                if (_loc5 == 127 || _loc5 == 128 || _loc5 == 169)
                {
                    _loc45 = _loc12 < 0 ? ("LOST_MP") : ("WIN_MP");
                    _loc2.addAction(false, api.kernel, api.kernel.showMessage, [undefined, api.lang.getText(_loc45, [_loc59.name, Math.abs(_loc12)]), "INFO_FIGHT_CHAT"]);
                } // end if
                _loc2.addAction(false, _loc59, _loc59.updateMP, [_loc12, _loc5 == 129]);
                break;
            } 
            case 103:
            {
                _loc58 = _loc3;
                _loc59 = api.datacenter.Sprites.getItemAt(_loc58);
                _loc19 = _loc59.mc;
                var _loc36 = _loc59.sex == 1 ? ("f") : ("m");
                _loc2.addAction(false, api.kernel, api.kernel.showMessage, [undefined, ank.utils.PatternDecoder.combine(api.lang.getText("DIE", [_loc59.name]), _loc36, true), "INFO_FIGHT_CHAT"]);
                var _loc15 = api.ui.getUIComponent("Timeline");
                _loc2.addAction(false, _loc15, _loc15.hideItem, [_loc58]);
                _loc2.addAction(true, _loc19, _loc19.setAnim, ["Die"], 1500);
                _loc2.addAction(false, _loc19, _loc19.clear);
                if (api.datacenter.Player.summonedCreaturesID[_loc58])
                {
                    --api.datacenter.Player.SummonedCreatures;
                    delete api.datacenter.Player.summonedCreaturesID[_loc58];
                    api.ui.getUIComponent("Banner").setSpellStateOnAllContainers();
                } // end if
                break;
            } 
            case 104:
            {
                _loc59 = api.datacenter.Sprites.getItemAt(_loc4);
                _loc19 = _loc59.mc;
                _loc2.addAction(false, api.kernel, api.kernel.showMessage, [undefined, api.lang.getText("CANT_MOVEOUT"), "INFO_FIGHT_CHAT"]);
                _loc2.addAction(false, _loc19, _loc19.setAnim, ["Hit"]);
                break;
            } 
            case 105:
            case 164:
            {
                _loc9 = _loc3.split(",");
                _loc58 = _loc9[0];
                var _loc37 = _loc5 == 164 ? (_loc9[1] + "%") : (_loc9[1]);
                _loc59 = api.datacenter.Sprites.getItemAt(_loc58);
                _loc2.addAction(false, api.kernel, api.kernel.showMessage, [undefined, api.lang.getText("REDUCE_DAMAGES", [_loc59.name, _loc37]), "INFO_FIGHT_CHAT"]);
                break;
            } 
            case 106:
            {
                _loc9 = _loc3.split(",");
                _loc58 = _loc9[0];
                var _loc62 = _loc9[1] == "1";
                _loc59 = api.datacenter.Sprites.getItemAt(_loc58);
                _loc45 = _loc62 ? (api.lang.getText("RETURN_SPELL_OK", [_loc59.name])) : (api.lang.getText("RETURN_SPELL_NO", [_loc59.name]));
                _loc2.addAction(false, api.kernel, api.kernel.showMessage, [undefined, _loc45, "INFO_FIGHT_CHAT"]);
                break;
            } 
            case 107:
            {
                _loc9 = _loc3.split(",");
                _loc58 = _loc9[0];
                _loc37 = _loc9[1];
                _loc59 = api.datacenter.Sprites.getItemAt(_loc58);
                _loc2.addAction(false, api.kernel, api.kernel.showMessage, [undefined, api.lang.getText("RETURN_DAMAGES", [_loc59.name, _loc37]), "INFO_FIGHT_CHAT"]);
                break;
            } 
            case 130:
            {
                var _loc17 = Number(_loc3);
                _loc59 = api.datacenter.Sprites.getItemAt(_loc4);
                _loc2.addAction(false, api.kernel, api.kernel.showMessage, [undefined, ank.utils.PatternDecoder.combine(api.lang.getText("STEAL_GOLD", [_loc59.name, _loc17]), "m", _loc17 < 2), "INFO_FIGHT_CHAT"]);
                break;
            } 
            case 132:
            {
                var _loc41 = api.datacenter.Sprites.getItemAt(_loc4);
                var _loc68 = api.datacenter.Sprites.getItemAt(_loc3);
                _loc2.addAction(false, api.kernel, api.kernel.showMessage, [undefined, api.lang.getText("REMOVE_ALL_EFFECTS", [_loc41.name, _loc68.name]), "INFO_FIGHT_CHAT"]);
                _loc2.addAction(false, _loc68.CharacteristicsManager, _loc68.CharacteristicsManager.terminateAllEffects);
                _loc2.addAction(false, _loc68.EffectsManager, _loc68.EffectsManager.terminateAllEffects);
                break;
            } 
            case 140:
            {
                var _loc42 = Number(_loc3);
                _loc59 = api.datacenter.Sprites.getItemAt(_loc4);
                _loc2.addAction(false, api.kernel, api.kernel.showMessage, [undefined, api.lang.getText("A_PASS_NEXT_TURN", [_loc59.name]), "ERROR_CHAT"]);
                break;
            } 
            case 151:
            {
                _loc42 = Number(_loc3);
                _loc59 = api.datacenter.Sprites.getItemAt(_loc4);
                var _loc47 = _loc42 == -1 ? (api.lang.getText("CANT_DO_INVISIBLE_OBSTACLE")) : (api.lang.getText("INVISIBLE_OBSTACLE", [_loc59.name, api.lang.getSpellText(_loc42).n]));
                _loc2.addAction(false, api.kernel, api.kernel.showMessage, [undefined, _loc47, "ERROR_CHAT"]);
                break;
            } 
            case 166:
            {
                _loc9 = _loc3.split(",");
                _loc42 = Number(_loc9[0]);
                _loc59 = api.datacenter.Sprites.getItemAt(_loc4);
                var _loc82 = Number(_loc9[1]);
                _loc2.addAction(false, api.kernel, api.kernel.showMessage, [undefined, api.lang.getText("RETURN_AP", [_loc59.name, _loc82]), "INFO_FIGHT_CHAT"]);
                break;
            } 
            case 164:
            {
                _loc9 = _loc3.split(",");
                _loc42 = Number(_loc9[0]);
                _loc59 = api.datacenter.Sprites.getItemAt(_loc4);
                _loc82 = Number(_loc9[1]);
                _loc2.addAction(false, api.kernel, api.kernel.showMessage, [undefined, api.lang.getText("REDUCE_LP_DAMAGES", [_loc59.name, _loc82]), "INFO_FIGHT_CHAT"]);
                break;
            } 
            case 180:
            case 181:
            {
                if (_loc4 == api.datacenter.Player.ID)
                {
                    ++api.datacenter.Player.SummonedCreatures;
                    var _loc28 = _loc3.split(";")[2];
                    api.datacenter.Player.summonedCreaturesID[_loc28] = true;
                } // end if
                _loc2.addAction(false, aks.Game, aks.Game.onMovement, [_loc3]);
                break;
            } 
            case 185:
            {
                _loc2.addAction(false, aks.Game, aks.Game.onMovement, [_loc3]);
                break;
            } 
            case 117:
            case 116:
            case 115:
            case 122:
            case 112:
            case 142:
            case 138:
            case 160:
            case 161:
            case 114:
            case 182:
            case 118:
            case 157:
            case 123:
            case 152:
            case 126:
            case 155:
            case 119:
            case 154:
            case 124:
            case 156:
            case 125:
            case 153:
            case 160:
            case 161:
            case 162:
            case 163:
            case 606:
            case 607:
            case 608:
            case 609:
            case 610:
            case 611:
            {
                _loc9 = _loc3.split(",");
                _loc58 = _loc9[0];
                _loc59 = api.datacenter.Sprites.getItemAt(_loc58);
                _loc82 = Number(_loc9[1]);
                var _loc76 = Number(_loc9[2]);
                var _loc22 = _loc59.CharacteristicsManager;
                var _loc56 = new dofus.datacenter.Effect(_loc5, _loc82, undefined, undefined, undefined, _loc76);
                _loc2.addAction(false, _loc22, _loc22.addEffect, [_loc56]);
                _loc2.addAction(false, api.kernel, api.kernel.showMessage, [undefined, "<b>" + _loc59.name + "</b> : " + _loc56.description, "INFO_FIGHT_CHAT"]);
                break;
            } 
            case 149:
            {
                _loc9 = _loc3.split(",");
                _loc58 = _loc9[0];
                _loc59 = api.datacenter.Sprites.getItemAt(_loc58);
                var _loc32 = Number(_loc9[1]);
                var _loc60 = Number(_loc9[2]);
                _loc76 = Number(_loc9[3]);
                _loc2.addAction(false, api.kernel, api.kernel.showMessage, [undefined, api.lang.getText("GFX", [_loc59.name]), "INFO_FIGHT_CHAT"]);
                _loc22 = _loc59.CharacteristicsManager;
                _loc56 = new dofus.datacenter.Effect(_loc5, _loc32, _loc60, undefined, undefined, _loc76);
                _loc2.addAction(false, _loc22, _loc22.addEffect, [_loc56]);
                break;
            } 
            case 150:
            {
                _loc9 = _loc3.split(",");
                _loc58 = _loc9[0];
                _loc59 = api.datacenter.Sprites.getItemAt(_loc58);
                _loc76 = Number(_loc9[1]);
                _loc2.addAction(false, api.kernel, api.kernel.showMessage, [undefined, api.lang.getText("INVISIBILITY", [_loc59.name]), "INFO_FIGHT_CHAT"]);
                if (_loc76 > 0)
                {
                    _loc22 = _loc59.CharacteristicsManager;
                    _loc56 = new dofus.datacenter.Effect(_loc5, 1, undefined, undefined, undefined, _loc76);
                    _loc2.addAction(false, _loc22, _loc22.addEffect, [_loc56]);
                }
                else
                {
                    api.gfx.hideSprite(_loc58, false);
                } // end else if
                break;
            } 
            case 165:
            {
                _loc9 = _loc3.split(",");
                _loc58 = _loc9[0];
                var _loc77 = Number(_loc9[1]);
                _loc82 = Number(_loc9[2]);
                _loc76 = Number(_loc9[3]);
                break;
            } 
            case 200:
            {
                _loc9 = _loc3.split(",");
                _loc40 = Number(_loc9[0]);
                var _loc43 = Number(_loc9[1]);
                _loc2.addAction(false, api.gfx, api.gfx.setObject2Frame, [_loc40, _loc43]);
                break;
            } 
            case 208:
            {
                _loc9 = _loc3.split(",");
                _loc59 = api.datacenter.Sprites.getItemAt(_loc4);
                _loc40 = Number(_loc9[0]);
                var _loc61 = _loc9[1];
                var _loc38 = Number(_loc9[2]);
                var _loc39 = isNaN(Number(_loc9[3])) ? (String(_loc9[3]).split("~")) : ("anim" + _loc9[3]);
                var _loc33 = _loc9[4] != undefined ? (Number(_loc9[4])) : (1);
                var _loc10 = new ank.battlefield.datacenter.VisualEffect();
                _loc10.file = dofus.Constants.SPELLS_PATH + _loc61 + ".swf";
                _loc10.level = _loc33;
                _loc10.bInFrontOfSprite = true;
                _loc10.bTryToBypassContainerColor = true;
                api.gfx.spriteLaunchVisualEffect(_loc4, _loc10, _loc40, _loc38, _loc39);
                break;
            } 
            case 300:
            {
                _loc9 = _loc3.split(",");
                _loc59 = api.datacenter.Sprites.getItemAt(_loc4);
                _loc42 = Number(_loc9[0]);
                _loc40 = Number(_loc9[1]);
                _loc61 = _loc9[2];
                _loc33 = Number(_loc9[3]);
                var _loc29 = Number(_loc9[4]);
                _loc39 = isNaN(Number(_loc9[5])) ? (String(_loc9[5]).split("~")) : ("anim" + _loc9[5]);
                var _loc23 = _loc9[6] == "1" ? (true) : (false);
                _loc10 = new ank.battlefield.datacenter.VisualEffect();
                _loc10.file = dofus.Constants.SPELLS_PATH + _loc61 + ".swf";
                _loc10.level = _loc33;
                _loc10.bInFrontOfSprite = _loc23;
                _loc10.params = new dofus.datacenter.Spell(_loc42, _loc33).elements;
                _loc2.addAction(false, api.kernel, api.kernel.showMessage, [undefined, api.lang.getText("HAS_LAUNCH_SPELL", [_loc59.name, api.lang.getSpellText(_loc42).n]), "INFO_FIGHT_CHAT"]);
                api.gfx.spriteLaunchVisualEffect(_loc4, _loc10, _loc40, _loc29, _loc39);
                if (_loc4 == api.datacenter.Player.ID)
                {
                    var _loc46 = api.datacenter.Player.SpellsManager;
                    var _loc64 = api.gfx.mapHandler.getCellData(_loc40).spriteOnID;
                    var _loc24 = new dofus.datacenter.LaunchedSpell(_loc42, _loc64);
                    _loc46.addLaunchedSpell(_loc24);
                } // end if
                break;
            } 
            case 301:
            {
                _loc42 = Number(_loc3);
                _loc2.addAction(false, api.sounds, api.sounds.onGameCriticalHit, []);
                _loc2.addAction(false, api.kernel, api.kernel.showMessage, [undefined, "(" + api.lang.getText("CRITICAL_HIT") + ")", "INFO_FIGHT_CHAT"]);
                _loc2.addAction(false, api.gfx, api.gfx.setSpriteAnim, [_loc4, "bonus"]);
                break;
            } 
            case 302:
            {
                _loc42 = Number(_loc3);
                _loc59 = api.datacenter.Sprites.getItemAt(_loc4);
                _loc2.addAction(false, api.sounds, api.sounds.onGameCriticalMiss, []);
                _loc2.addAction(false, api.kernel, api.kernel.showMessage, [undefined, api.lang.getText("HAS_LAUNCH_SPELL", [_loc59.name, api.lang.getSpellText(_loc42).n]), "INFO_FIGHT_CHAT"]);
                _loc2.addAction(false, api.kernel, api.kernel.showMessage, [undefined, "(" + api.lang.getText("CRITICAL_MISS") + ")", "INFO_FIGHT_CHAT"]);
                _loc2.addAction(false, api.gfx, api.gfx.addSpriteBubble, [_loc4, api.lang.getText("CRITICAL_MISS")]);
                break;
            } 
            case 303:
            {
                _loc9 = _loc3.split(",");
                _loc40 = Number(_loc9[0]);
                _loc61 = _loc9[1];
                _loc29 = Number(_loc9[2]);
                _loc23 = _loc9[3] == "1" ? (true) : (false);
                _loc59 = api.datacenter.Sprites.getItemAt(_loc4);
                _loc19 = _loc59.mc;
                var _loc20 = _loc59.ToolAnimation;
                _loc2.addAction(false, api.kernel, api.kernel.showMessage, [undefined, api.lang.getText("HAS_ATTACK_CC", [_loc59.name]), "INFO_FIGHT_CHAT"]);
                if (_loc61 == undefined)
                {
                    _loc2.addAction(false, api.gfx, api.gfx.autoCalculateSpriteDirection, [_loc4, _loc40]);
                    _loc2.addAction(true, api.gfx, api.gfx.setSpriteAnim, [_loc4, _loc20]);
                }
                else
                {
                    var _loc48 = _loc59.accessories[0].unicID;
                    var _loc34 = _loc59.Guild;
                    _loc10 = new ank.battlefield.datacenter.VisualEffect();
                    _loc10.file = dofus.Constants.SPELLS_PATH + _loc61 + ".swf";
                    _loc10.level = 1;
                    _loc10.bInFrontOfSprite = _loc23;
                    _loc10.params = new dofus.datacenter.CloseCombat(new dofus.datacenter.Item(undefined, _loc48), _loc34).elements;
                    api.gfx.spriteLaunchVisualEffect(_loc4, _loc10, _loc40, _loc29, _loc20);
                } // end else if
                break;
            } 
            case 304:
            {
                _loc59 = api.datacenter.Sprites.getItemAt(_loc4);
                _loc19 = _loc59.mc;
                _loc2.addAction(false, api.sounds, api.sounds.onGameCriticalHit, []);
                _loc2.addAction(false, api.kernel, api.kernel.showMessage, [undefined, "(" + api.lang.getText("CRITICAL_HIT") + ")", "INFO_FIGHT_CHAT"]);
                _loc2.addAction(false, _loc19, _loc19.setAnim, ["bonus"]);
                break;
            } 
            case 305:
            {
                _loc59 = api.datacenter.Sprites.getItemAt(_loc4);
                _loc2.addAction(false, api.sounds, api.sounds.onGameCriticalMiss, []);
                _loc2.addAction(false, api.kernel, api.kernel.showMessage, [undefined, api.lang.getText("HAS_ATTACK_CC", [_loc59.name]), "INFO_FIGHT_CHAT"]);
                _loc2.addAction(false, api.kernel, api.kernel.showMessage, [undefined, "(" + api.lang.getText("CRITICAL_MISS") + ")", "INFO_FIGHT_CHAT"]);
                _loc2.addAction(false, api.gfx, api.gfx.addSpriteBubble, [_loc4, api.lang.getText("CRITICAL_MISS")]);
                break;
            } 
            case 306:
            {
                _loc9 = _loc3.split(",");
                _loc42 = Number(_loc9[0]);
                _loc40 = Number(_loc9[1]);
                _loc61 = _loc9[2];
                _loc33 = Number(_loc9[3]);
                var _loc30 = _loc9[4] == "1" ? (true) : (false);
                var _loc44 = Number(_loc9[5]);
                var _loc35 = api.datacenter.Sprites.getItemAt(_loc4);
                var _loc65 = api.datacenter.Sprites.getItemAt(_loc44);
                _loc10 = new ank.battlefield.datacenter.VisualEffect();
                _loc10.id = _loc42;
                _loc10.file = dofus.Constants.SPELLS_PATH + _loc61 + ".swf";
                _loc10.level = _loc33;
                _loc10.bInFrontOfSprite = _loc30;
                _loc2.addAction(false, api.kernel, api.kernel.showMessage, [undefined, api.lang.getText("HAS_START_TRAP", [_loc35.name, api.lang.getSpellText(_loc10.id).n, _loc65.name]), "INFO_FIGHT_CHAT"]);
                _loc2.addAction(false, api.gfx, api.gfx.addVisualEffectOnSprite, [_loc44, _loc10, _loc40, 11], 1000);
                break;
            } 
            case 307:
            {
                _loc9 = _loc3.split(",");
                _loc42 = Number(_loc9[0]);
                _loc40 = Number(_loc9[1]);
                _loc33 = Number(_loc9[3]);
                _loc44 = Number(_loc9[5]);
                _loc35 = api.datacenter.Sprites.getItemAt(_loc4);
                _loc65 = api.datacenter.Sprites.getItemAt(_loc44);
                var _loc25 = new dofus.datacenter.Spell(_loc42, _loc33);
                _loc2.addAction(false, api.kernel, api.kernel.showMessage, [undefined, api.lang.getText("HAS_START_GLIPH", [_loc35.name, _loc25.name, _loc65.name]), "INFO_FIGHT_CHAT"]);
                break;
            } 
            case 308:
            {
                _loc59 = api.datacenter.Sprites.getItemAt(Number(_loc3));
                _loc2.addAction(false, api.kernel, api.kernel.showMessage, [undefined, api.lang.getText("HAS_DODGE_SPELL", [_loc59.name]), "INFO_FIGHT_CHAT"]);
                break;
            } 
            case 501:
            {
                _loc9 = _loc3.split(",");
                _loc40 = _loc9[0];
                var _loc18 = Number(_loc9[1]);
                _loc59 = api.datacenter.Sprites.getItemAt(_loc4);
                var _loc26 = _loc9[2] == undefined ? (_loc59.ToolAnimation) : ("anim" + _loc9[2]);
                _loc2.addAction(false, api.gfx, api.gfx.autoCalculateSpriteDirection, [_loc4, _loc40]);
                _loc2.addAction(_loc4 == api.datacenter.Player.ID, api.gfx, api.gfx.setSpriteLoopAnim, [_loc4, _loc26, _loc18], _loc18);
                break;
            } 
            case 617:
            {
                _loc8 = false;
                _loc9 = _loc3.split(",");
                var _loc63 = api.datacenter.Sprites.getItemAt(Number(_loc9[0]));
                var _loc27 = api.datacenter.Sprites.getItemAt(Number(_loc9[1]));
                var _loc66 = _loc9[2];
                api.gfx.addSpriteBubble(_loc66, api.lang.getText("A_ASK_MARRIAGE_B", [_loc63.name, _loc27.name]));
                if (_loc63.id == api.datacenter.Player.ID)
                {
                    api.kernel.showMessage(api.lang.getText("MARRIAGE"), api.lang.getText("A_ASK_MARRIAGE_B", [_loc63.name, _loc27.name]), "CAUTION_YESNO", {name: "Marriage", listener: this, params: {spriteID: _loc63.id, refID: _loc4}});
                } // end if
                break;
            } 
            case 618:
            case 619:
            {
                _loc8 = false;
                _loc9 = _loc3.split(",");
                _loc63 = api.datacenter.Sprites.getItemAt(Number(_loc9[0]));
                _loc27 = api.datacenter.Sprites.getItemAt(Number(_loc9[1]));
                _loc66 = _loc9[2];
                var _loc31 = _loc5 == 618 ? ("A_MARRIED_B") : ("A_NOT_MARRIED_B");
                api.gfx.addSpriteBubble(_loc66, api.lang.getText(_loc31, [_loc63.name, _loc27.name]));
                break;
            } 
            case 900:
            {
                _loc8 = false;
                _loc41 = api.datacenter.Sprites.getItemAt(_loc4);
                _loc68 = api.datacenter.Sprites.getItemAt(Number(_loc3));
                if (_loc41 == undefined || _loc68 == undefined)
                {
                    this.refuseChallenge(_loc4);
                    return;
                } // end if
                api.kernel.showMessage(undefined, api.lang.getText("A_CHALENGE_B", [_loc41.name, _loc68.name]), "INFO_CHAT");
                if (_loc41.id == api.datacenter.Player.ID)
                {
                    api.kernel.showMessage(api.lang.getText("CHALENGE"), api.lang.getText("YOU_CHALENGE_B", [_loc68.name]), "INFO_CANCEL", {name: "Challenge", listener: this, params: {spriteID: _loc41.id}});
                } // end if
                if (_loc68.id == api.datacenter.Player.ID)
                {
                    api.kernel.showMessage(api.lang.getText("CHALENGE"), api.lang.getText("A_CHALENGE_YOU", [_loc41.name]), "CAUTION_YESNO", {name: "Challenge", listener: this, params: {spriteID: _loc41.id}});
                    api.sounds.onGameInvitation();
                } // end if
                break;
            } 
            case 901:
            {
                _loc8 = false;
                if (_loc4 == api.datacenter.Player.ID || Number(_loc3) == api.datacenter.Player.ID)
                {
                    api.ui.unloadUIComponent("AskCancelChallenge");
                } // end if
                break;
            } 
            case 902:
            {
                _loc8 = false;
                api.ui.unloadUIComponent("AskYesNoChallenge");
                api.ui.unloadUIComponent("AskCancelChallenge");
                break;
            } 
            case 903:
            {
                _loc8 = false;
                switch (_loc3)
                {
                    case "c":
                    {
                        api.kernel.showMessage(undefined, api.lang.getText("CHALENGE_FULL"), "ERROR_CHAT");
                        break;
                    } 
                    case "t":
                    {
                        api.kernel.showMessage(undefined, api.lang.getText("TEAM_FULL"), "ERROR_CHAT");
                        break;
                    } 
                    case "a":
                    {
                        api.kernel.showMessage(undefined, api.lang.getText("TEAM_DIFFERENT_ALIGNMENT"), "ERROR_CHAT");
                        break;
                    } 
                    case "g":
                    {
                        api.kernel.showMessage(undefined, api.lang.getText("CANT_DO_BECAUSE_GUILD"), "ERROR_CHAT");
                        break;
                    } 
                    case "l":
                    {
                        api.kernel.showMessage(undefined, api.lang.getText("CANT_DO_TOO_LATE"), "ERROR_CHAT");
                        break;
                    } 
                    case "m":
                    {
                        api.kernel.showMessage(undefined, api.lang.getText("CANT_U_ARE_MUTANT"), "ERROR_CHAT");
                        break;
                    } 
                    case "p":
                    {
                        api.kernel.showMessage(undefined, api.lang.getText("CANT_BECAUSE_MAP"), "ERROR_CHAT");
                        break;
                    } 
                    case "r":
                    {
                        api.kernel.showMessage(undefined, api.lang.getText("CANT_BECAUSE_ON_RESPAWN"), "ERROR_CHAT");
                        break;
                    } 
                    case "o":
                    {
                        api.kernel.showMessage(undefined, api.lang.getText("CANT_YOU_R_OCCUPED"), "ERROR_CHAT");
                        break;
                    } 
                    case "z":
                    {
                        api.kernel.showMessage(undefined, api.lang.getText("CANT_YOU_OPPONENT_OCCUPED"), "ERROR_CHAT");
                        break;
                    } 
                    case "h":
                    {
                        api.kernel.showMessage(undefined, api.lang.getText("CANT_FIGHT"), "ERROR_CHAT");
                        break;
                    } 
                    case "i":
                    {
                        api.kernel.showMessage(undefined, api.lang.getText("CANT_FIGHT_NO_RIGHTS"), "ERROR_CHAT");
                        break;
                    } 
                    case "s":
                    {
                        api.kernel.showMessage(undefined, api.lang.getText("ERROR_21"), "ERROR_CHAT");
                        break;
                    } 
                    case "n":
                    {
                        api.kernel.showMessage(undefined, api.lang.getText("SUBSCRIPTION_OUT"), "ERROR_CHAT");
                        break;
                    } 
                    case "b":
                    {
                        api.kernel.showMessage(undefined, api.lang.getText("A_NOT_SUBSCRIB"), "ERROR_CHAT");
                        break;
                    } 
                } // End of switch
                break;
            } 
            case 905:
            {
                api.ui.loadUIComponent("CenterText", "CenterText", {text: api.lang.getText("YOU_ARE_ATTAC"), background: true, timer: 2000}, {bForceLoad: true});
                break;
            } 
            case 906:
            {
                var _loc49 = _loc3;
                _loc41 = api.datacenter.Sprites.getItemAt(_loc4);
                _loc68 = api.datacenter.Sprites.getItemAt(_loc49);
                api.kernel.showMessage(undefined, api.lang.getText("A_ATTACK_B", [_loc41.name, _loc68.name]), "INFO_CHAT");
                if (_loc49 == api.datacenter.Player.ID)
                {
                    api.ui.loadUIComponent("CenterText", "CenterText", {text: api.lang.getText("YOU_ARE_ATTAC"), background: true, timer: 2000}, {bForceLoad: true});
                } // end if
                break;
            } 
            case 909:
            {
                _loc49 = _loc3;
                _loc41 = api.datacenter.Sprites.getItemAt(_loc4);
                _loc68 = api.datacenter.Sprites.getItemAt(_loc49);
                api.kernel.showMessage(undefined, api.lang.getText("A_ATTACK_B", [_loc41.name, _loc68.name]), "INFO_CHAT");
                break;
            } 
            case 998:
            {
                _loc9 = sExtraData.split(",");
                _loc58 = _loc9[0];
                var _loc57 = _loc9[0];
                var _loc53 = _loc9[2];
                var _loc51 = _loc9[3];
                var _loc50 = _loc9[4];
                var _loc69 = _loc9[6];
                var _loc70 = _loc9[7];
                _loc56 = new dofus.datacenter.Effect(_loc57, _loc53, _loc51, _loc50, _loc69, _loc70);
                _loc59 = api.datacenter.Sprites.getItemAt(_loc58);
                _loc59.EffectsManager.addEffect(_loc56);
                break;
            } 
            case 999:
            {
                _loc2.addAction(false, this.__get__aks(), aks.processCommand, [_loc3]);
            } 
        } // End of switch
        if (!isNaN(_loc13) && _loc4 == api.datacenter.Player.ID)
        {
            _loc2.addAction(false, _loc11, _loc11.ack, [_loc13]);
        }
        else
        {
            _loc11.end(_loc14 == api.datacenter.Player.ID);
        } // end else if
        if (!_loc2.isPlaying() && _loc8)
        {
            _loc2.execute(true);
        } // end if
    } // End of the function
    function cancel(oEvent)
    {
        switch (oEvent.target._name)
        {
            case "AskCancelChallenge":
            {
                this.refuseChallenge(oEvent.params.spriteID);
                break;
            } 
        } // End of switch
    } // End of the function
    function yes(oEvent)
    {
        switch (oEvent.target._name)
        {
            case "AskYesNoChallenge":
            {
                this.acceptChallenge(oEvent.params.spriteID);
                break;
            } 
            case "AskYesNoMarriage":
            {
                this.acceptMarriage(oEvent.params.refID);
                api.gfx.addSpriteBubble(oEvent.params.spriteID, api.lang.getText("YES"));
                break;
            } 
        } // End of switch
    } // End of the function
    function no(oEvent)
    {
        switch (oEvent.target._name)
        {
            case "AskYesNoChallenge":
            {
                this.refuseChallenge(oEvent.params.spriteID);
                break;
            } 
            case "AskYesNoMarriage":
            {
                this.refuseMarriage(oEvent.params.refID);
                api.gfx.addSpriteBubble(oEvent.params.spriteID, api.lang.getText("NO"));
                break;
            } 
        } // End of switch
    } // End of the function
} // End of Class
#endinitclip
