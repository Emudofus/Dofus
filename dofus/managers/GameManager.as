// Action script...

// [Initial MovieClip Action of sprite 897]
#initclip 109
class dofus.managers.GameManager extends dofus.utils.ApiElement
{
    var api;
    function GameManager(oAPI)
    {
        super();
        this.initialize(oAPI);
    } // End of the function
    function initialize(oAPI)
    {
        super.initialize(oAPI);
        api.ui.addEventListener("removeCursor", this);
    } // End of the function
    function askPrivateMessage(sPlayerName)
    {
        var _loc2 = api.ui.loadUIComponent("AskPrivateChat", "AskPrivateChat", {title: api.lang.getText("WISPER_MESSAGE") + " " + api.lang.getText("TO") + " " + sPlayerName, params: {playerName: sPlayerName}});
        _loc2.addEventListener("send", this);
        _loc2.addEventListener("addfriend", this);
    } // End of the function
    function giveUpGame()
    {
        api.kernel.showMessage(undefined, api.lang.getText("DO_U_GIVEUP"), "CAUTION_YESNO", {name: "GiveUp", listener: this});
    } // End of the function
    function offlineExchange()
    {
        api.kernel.showMessage(undefined, api.lang.getText("DO_U_OFFLINEEXCHANGE"), "CAUTION_YESNO", {name: "OfflineExchange", listener: this});
    } // End of the function
    function startExchange(nExchangeType, sSpriteID, nCellNum)
    {
        var _loc2 = api.datacenter.Player.data;
        if (_loc2.isInMove)
        {
            _loc2.GameActionsManager.cancel(_loc2.cellNum, true);
        } // end if
        api.network.Exchange.request(nExchangeType, sSpriteID, nCellNum);
    } // End of the function
    function startDialog(sSpriteID)
    {
        var _loc2 = api.datacenter.Player.data;
        if (_loc2.isInMove)
        {
            _loc2.GameActionsManager.cancel(_loc2.cellNum, true);
        } // end if
        api.network.Dialog.create(sSpriteID);
    } // End of the function
    function askAttack(sSpriteID)
    {
        var _loc2 = api.datacenter.Sprites.getItemAt(sSpriteID).name;
        api.kernel.showMessage(undefined, api.lang.getText("DO_U_ATTACK", [_loc2]), "CAUTION_YESNO", {name: "Punish", listener: this, params: {spriteID: sSpriteID}});
    } // End of the function
    function useRessource(mcCell, nCellNum, nSkillID)
    {
        if (api.gfx.onCellRelease(mcCell))
        {
            api.network.GameActions.sendActions(500, [nCellNum, nSkillID]);
        } // end if
    } // End of the function
    function useSkill(nSkillID)
    {
        api.network.GameActions.sendActions(507, [nSkillID]);
    } // End of the function
    function setEnabledInteractionIfICan(nInteractionType)
    {
        if (api.datacenter.Player.isCurrentPlayer)
        {
            api.gfx.setInteraction(nInteractionType);
        } // end if
    } // End of the function
    function cleanPlayer(sSpriteID)
    {
        if (sSpriteID != api.datacenter.Game.currentPlayerID)
        {
            var _loc2 = api.datacenter.Sprites.getItemAt(sSpriteID);
            _loc2.EffectsManager.nextTurn();
            _loc2.CharacteristicsManager.nextTurn();
            _loc2.GameActionsManager.clear();
        } // end if
    } // End of the function
    function cleanUpGameArea(bKeepSelection)
    {
        if (bKeepSelection)
        {
            api.gfx.unSelect(true);
        } // end if
        api.ui.removeCursor();
        api.ui.getUIComponent("Banner").hideRightPanel();
        api.gfx.clearPointer();
        api.gfx.clearZoneLayer("spell");
        delete api.datacenter.Player.currentUseObject;
        if (!(api.datacenter.Game.isFight && !api.datacenter.Game.isRunning))
        {
            api.datacenter.Game.setInteractionType("move");
        } // end if
        api.datacenter.Player.InteractionsManager.setState(api.datacenter.Game.isFight);
    } // End of the function
    function terminateFight()
    {
        api.sounds.onGameEnd();
        api.sounds.playMusic(api.datacenter.Map.musicID);
        api.kernel.showMessage(undefined, api.lang.getText("GAME_END"), "INFO_CHAT");
        api.ui.loadUIComponent("GameResult", "GameResult", {data: api.datacenter.Game.results}, {bAlwaysOnTop: true});
        api.network.Game.onLeave();
    } // End of the function
    function switchToItemTarget(oItem)
    {
        if (api.datacenter.Game.isFight)
        {
            return;
        } // end if
        api.gfx.unSelect(true);
        api.gfx.clearPointer();
        api.gfx.addPointerShape("C", 0, dofus.Constants.CELL_SPELL_EFFECT_COLOR, api.datacenter.Player.data.cellNum);
        api.datacenter.Player.currentUseObject = oItem;
        api.datacenter.Game.setInteractionType("target");
        api.gfx.setInteraction(ank.battlefield.Constants.INTERACTION_CELL_RELEASE_OVER_OUT);
        api.ui.setCursor(oItem, {width: 25, height: 25, x: 15, y: 15});
        api.datacenter.Basics.gfx_canLaunch = false;
        _level1.forceMouseOver();
    } // End of the function
    function switchToSpellLaunch(oSpell, bSpell, bForced)
    {
        if (bForced != true)
        {
            if (!api.datacenter.Game.isRunning)
            {
                return;
            } // end if
            if (api.datacenter.Player.data.sequencer.isPlaying())
            {
                return;
            } // end if
            if (api.datacenter.Player.data.GameActionsManager.isWaiting())
            {
                return;
            } // end if
            if (!api.datacenter.Player.SpellsManager.checkCanLaunchSpell(oSpell.ID, undefined))
            {
                if (api.datacenter.Basics.spellManager_errorMsg != undefined)
                {
                    api.kernel.showMessage(undefined, api.datacenter.Basics.spellManager_errorMsg, "ERROR_CHAT");
                    delete api.datacenter.Basics.spellManager_errorMsg;
                } // end if
                return;
            } // end if
        } // end if
        delete api.datacenter.Basics.interactionsManager_path;
        api.gfx.unSelect(true);
        api.datacenter.Player.currentUseObject = oSpell;
        api.gfx.clearZoneLayer("spell");
        api.gfx.clearPointer();
        if (oSpell.rangeMax != 63)
        {
            var _loc6 = oSpell.rangeMax;
            var _loc7 = oSpell.rangeMin;
            if (_loc6 != 0)
            {
                var _loc8 = oSpell.canBoostRange ? (api.datacenter.Player.data.CharacteristicsManager.getModeratorValue(19) + api.datacenter.Player.RangeModerator) : (0);
                _loc6 = _loc6 + _loc8;
                _loc6 = Math.max(_loc7, _loc6);
            } // end if
            var _loc4 = api.datacenter.Player.data.cellNum;
            var _loc3 = oSpell.effectZones;
            for (var _loc2 = 0; _loc2 < _loc3.length; ++_loc2)
            {
                if (_loc3[_loc2].size < 63)
                {
                    api.gfx.addPointerShape(_loc3[_loc2].shape, _loc3[_loc2].size, dofus.Constants.CELL_SPELL_EFFECT_COLOR, _loc4);
                } // end if
            } // end of for
            if (oSpell.lineOnly)
            {
                api.gfx.drawZone(_loc4, _loc7, _loc6, "spell", dofus.Constants.CELL_SPELL_RANGE_COLOR, "X");
            }
            else
            {
                api.gfx.drawZone(_loc4, _loc7, _loc6, "spell", dofus.Constants.CELL_SPELL_RANGE_COLOR, "C");
            } // end else if
        }
        else
        {
            api.gfx.drawZone(0, 0, 100, "spell", dofus.Constants.CELL_SPELL_RANGE_COLOR, "C");
        } // end else if
        if (bSpell)
        {
            api.datacenter.Game.setInteractionType("spell");
        }
        else
        {
            api.datacenter.Game.setInteractionType("cc");
        } // end else if
        api.ui.setCursor(oSpell, {width: 25, height: 25, x: 15, y: 15});
        api.ui.setCursorForbidden(true, dofus.Constants.FORBIDDEN_FILE);
        api.datacenter.Basics.gfx_canLaunch = false;
        _level1.forceMouseOver();
    } // End of the function
    function removeCursor(oEvent)
    {
        switch (api.datacenter.Game.interactionType)
        {
            case 2:
            case 3:
            {
                if (!api.datacenter.Basics.gfx_canLaunch)
                {
                    api.datacenter.Game.setInteractionType("move");
                } // end if
                api.gfx.clearZoneLayer("spell");
                api.gfx.clearPointer();
                break;
            } 
            case 5:
            {
                if (!api.datacenter.Basics.gfx_canLaunch)
                {
                    api.datacenter.Game.setInteractionType("move");
                } // end if
                api.gfx.setInteraction(ank.battlefield.Constants.INTERACTION_CELL_RELEASE);
                api.gfx.clearPointer();
                break;
            } 
        } // End of switch
    } // End of the function
    function yes(oEvent)
    {
        switch (oEvent.target._name)
        {
            case "AskYesNoGiveUp":
            {
                api.network.Game.leave();
                break;
            } 
            case "AskYesNoOfflineExchange":
            {
                api.network.Exchange.offlineExchange();
                break;
            } 
            case "AskYesNoPunish":
            {
                api.network.GameActions.attack(oEvent.params.spriteID);
                break;
            } 
            case "AskYesNoAttack":
            {
                api.network.GameActions.attack(oEvent.params.spriteID);
                break;
            } 
        } // End of switch
    } // End of the function
    function send(oEvent)
    {
        if (oEvent.message.length != 0)
        {
            api.kernel.Console.process("/w " + oEvent.params.playerName + " " + oEvent.message);
        } // end if
    } // End of the function
    function addfriend(oEvent)
    {
        api.network.Friends.addFriend(oEvent.params.playerName);
    } // End of the function
    function updateCompass(nX, nY, bForced)
    {
        var _loc2 = api.ui.getUIComponent("Banner");
        if (!bForced && api.datacenter.Basics.banner_targetCoords[0] == nX && api.datacenter.Basics.banner_targetCoords[1] == nY)
        {
            delete api.datacenter.Basics.banner_targetCoords;
            _loc2.showCircleXtra("artwork", true, {bMask: true});
            return (false);
        }
        else
        {
            var _loc3 = api.datacenter.Map;
            _loc2.showCircleXtra("compass", true, undefined, {updateOnLoad: false});
            _loc2.setCircleXtraParams({allCoords: {targetCoords: [nX, nY], currentCoords: [_loc3.x, _loc3.y]}});
            api.datacenter.Basics.banner_targetCoords = [nX, nY];
            return (true);
        } // end else if
    } // End of the function
} // End of Class
#endinitclip
