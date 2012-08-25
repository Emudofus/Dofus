package com.ankamagames.dofus.logic.game.fight.frames
{
    import __AS3__.vec.*;
    import com.ankamagames.atouin.*;
    import com.ankamagames.atouin.enums.*;
    import com.ankamagames.atouin.managers.*;
    import com.ankamagames.atouin.messages.*;
    import com.ankamagames.atouin.renderers.*;
    import com.ankamagames.atouin.types.*;
    import com.ankamagames.atouin.utils.*;
    import com.ankamagames.berilia.factories.*;
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.berilia.types.data.*;
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.kernel.net.*;
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.dofus.logic.game.fight.actions.*;
    import com.ankamagames.dofus.misc.lists.*;
    import com.ankamagames.dofus.network.enums.*;
    import com.ankamagames.dofus.network.messages.game.context.*;
    import com.ankamagames.dofus.network.messages.game.context.fight.*;
    import com.ankamagames.dofus.network.types.game.context.fight.*;
    import com.ankamagames.dofus.types.entities.*;
    import com.ankamagames.jerakine.entities.interfaces.*;
    import com.ankamagames.jerakine.entities.messages.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.messages.*;
    import com.ankamagames.jerakine.types.*;
    import com.ankamagames.jerakine.types.enums.*;
    import com.ankamagames.jerakine.types.positions.*;
    import com.ankamagames.jerakine.types.zones.*;
    import flash.ui.*;
    import flash.utils.*;

    public class FightPreparationFrame extends Object implements Frame
    {
        private var _fightContextFrame:FightContextFrame;
        private var _playerTeam:uint;
        private var _challengerPositions:Vector.<uint>;
        private var _defenderPositions:Vector.<uint>;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(FightPreparationFrame));
        private static const COLOR_CHALLENGER:Color = new Color(14492160);
        private static const COLOR_DEFENDER:Color = new Color(8925);
        private static const SELECTION_CHALLENGER:String = "FightPlacementChallengerTeam";
        private static const SELECTION_DEFENDER:String = "FightPlacementDefenderTeam";

        public function FightPreparationFrame(param1:FightContextFrame)
        {
            this._fightContextFrame = param1;
            return;
        }// end function

        public function get priority() : int
        {
            return Priority.HIGH;
        }// end function

        public function pushed() : Boolean
        {
            Mouse.show();
            LinkedCursorSpriteManager.getInstance().removeItem("npcMonsterCursor");
            Atouin.getInstance().cellOverEnabled = true;
            this._fightContextFrame.entitiesFrame.untargetableEntities = true;
            DataMapProvider.getInstance().isInFight = true;
            return true;
        }// end function

        public function process(param1:Message) : Boolean
        {
            var _loc_2:GameFightLeaveMessage = null;
            var _loc_3:GameFightPlacementPossiblePositionsMessage = null;
            var _loc_4:CellClickMessage = null;
            var _loc_5:AnimatedCharacter = null;
            var _loc_6:GameFightReadyAction = null;
            var _loc_7:GameFightReadyMessage = null;
            var _loc_8:EntityClickMessage = null;
            var _loc_9:Object = null;
            var _loc_10:Object = null;
            var _loc_11:ContextMenuData = null;
            var _loc_12:GameContextKickAction = null;
            var _loc_13:uint = 0;
            var _loc_14:GameContextKickMessage = null;
            var _loc_15:GameFightUpdateTeamMessage = null;
            var _loc_16:GameFightRemoveTeamMemberMessage = null;
            var _loc_17:GameFightEndMessage = null;
            var _loc_18:FightContextFrame = null;
            var _loc_19:GameFightEndMessage = null;
            var _loc_20:IEntity = null;
            var _loc_21:String = null;
            var _loc_22:FightEntitiesFrame = null;
            var _loc_23:GameFightCharacterInformations = null;
            var _loc_24:GameFightPlacementPositionRequestMessage = null;
            switch(true)
            {
                case param1 is GameFightLeaveMessage:
                {
                    _loc_2 = param1 as GameFightLeaveMessage;
                    if (_loc_2.charId == PlayedCharacterManager.getInstance().id)
                    {
                        Kernel.getWorker().removeFrame(this);
                        KernelEventsManager.getInstance().processCallback(HookList.GameFightLeave, _loc_2.charId);
                        _loc_19 = new GameFightEndMessage();
                        _loc_19.initGameFightEndMessage();
                        Kernel.getWorker().process(_loc_19);
                        return true;
                    }
                    return false;
                }
                case param1 is GameFightPlacementPossiblePositionsMessage:
                {
                    _loc_3 = param1 as GameFightPlacementPossiblePositionsMessage;
                    var _loc_25:* = _loc_3.positionsForChallengers;
                    this._challengerPositions = _loc_3.positionsForChallengers;
                    this.displayZone(SELECTION_CHALLENGER, _loc_25, COLOR_CHALLENGER);
                    var _loc_25:* = _loc_3.positionsForDefenders;
                    this._defenderPositions = _loc_3.positionsForDefenders;
                    this.displayZone(SELECTION_DEFENDER, _loc_25, COLOR_DEFENDER);
                    this._playerTeam = _loc_3.teamNumber;
                    return true;
                }
                case param1 is CellClickMessage:
                {
                    _loc_4 = param1 as CellClickMessage;
                    for each (_loc_20 in EntitiesManager.getInstance().getEntitiesOnCell(_loc_4.cellId))
                    {
                        
                        if (_loc_20 is AnimatedCharacter && !(_loc_20 as AnimatedCharacter).isMoving)
                        {
                            _loc_5 = _loc_20 as AnimatedCharacter;
                            break;
                        }
                    }
                    if (_loc_5)
                    {
                        if (_loc_5.id > 0)
                        {
                            _loc_21 = this._fightContextFrame.getFighterName(_loc_5.id);
                            _loc_22 = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
                            _loc_23 = _loc_22.getEntityInfos(_loc_5.id) as GameFightCharacterInformations;
                            _loc_10 = UiModuleManager.getInstance().getModule("Ankama_ContextMenu").mainClass;
                            _loc_11 = MenusFactory.create(_loc_23, "player", [_loc_5]);
                            _loc_10.createContextMenu(_loc_11);
                        }
                    }
                    else if (this.isValidPlacementCell(_loc_4.cellId, this._playerTeam))
                    {
                        _loc_24 = new GameFightPlacementPositionRequestMessage();
                        _loc_24.initGameFightPlacementPositionRequestMessage(_loc_4.cellId);
                        ConnectionsHandler.getConnection().send(_loc_24);
                    }
                    return true;
                }
                case param1 is GameEntityDispositionErrorMessage:
                {
                    _log.error("Cette position n\'est pas accessible.");
                    return true;
                }
                case param1 is GameFightReadyAction:
                {
                    _loc_6 = param1 as GameFightReadyAction;
                    _loc_7 = new GameFightReadyMessage();
                    _loc_7.initGameFightReadyMessage(_loc_6.isReady);
                    ConnectionsHandler.getConnection().send(_loc_7);
                    return true;
                }
                case param1 is EntityClickMessage:
                {
                    _loc_8 = param1 as EntityClickMessage;
                    if (_loc_8.entity.id < 0)
                    {
                        return true;
                    }
                    _loc_9 = new Object();
                    _loc_9.name = this._fightContextFrame.getFighterName(_loc_8.entity.id);
                    _loc_10 = UiModuleManager.getInstance().getModule("Ankama_ContextMenu").mainClass;
                    _loc_11 = MenusFactory.create(_loc_9, "player", [_loc_8.entity]);
                    _loc_10.createContextMenu(_loc_11);
                    return true;
                }
                case param1 is GameContextKickAction:
                {
                    _loc_12 = param1 as GameContextKickAction;
                    _loc_13 = PlayedCharacterManager.getInstance().infos.id;
                    _loc_14 = new GameContextKickMessage();
                    _loc_14.initGameContextKickMessage(_loc_12.targetId);
                    ConnectionsHandler.getConnection().send(_loc_14);
                    return true;
                }
                case param1 is GameFightUpdateTeamMessage:
                {
                    _loc_15 = param1 as GameFightUpdateTeamMessage;
                    this._fightContextFrame.isFightLeader = _loc_15.team.leaderId == PlayedCharacterManager.getInstance().infos.id;
                    if (_loc_15.team.teamMembers.indexOf(PlayedCharacterManager.getInstance().id) != -1 || _loc_15.team.teamMembers.length >= 1 && _loc_15.team.teamMembers[0].id == PlayedCharacterManager.getInstance().id)
                    {
                        PlayedCharacterManager.getInstance().teamId = _loc_15.team.teamId;
                    }
                    return true;
                }
                case param1 is GameFightRemoveTeamMemberMessage:
                {
                    _loc_16 = param1 as GameFightRemoveTeamMemberMessage;
                    this._fightContextFrame.entitiesFrame.process(RemoveEntityAction.create(_loc_16.charId));
                    return true;
                }
                case param1 is GameContextDestroyMessage:
                {
                    _loc_17 = new GameFightEndMessage();
                    _loc_17.initGameFightEndMessage();
                    _loc_18 = Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame;
                    if (_loc_18)
                    {
                        _loc_18.process(_loc_17);
                    }
                    else
                    {
                        Kernel.getWorker().process(_loc_17);
                    }
                    return true;
                }
                default:
                {
                    break;
                }
            }
            return false;
        }// end function

        public function pulled() : Boolean
        {
            DataMapProvider.getInstance().isInFight = false;
            var _loc_1:* = SelectionManager.getInstance().getSelection(SELECTION_CHALLENGER);
            if (_loc_1)
            {
                _loc_1.remove();
            }
            var _loc_2:* = SelectionManager.getInstance().getSelection(SELECTION_DEFENDER);
            if (_loc_2)
            {
                _loc_2.remove();
            }
            this._fightContextFrame.entitiesFrame.untargetableEntities = Dofus.getInstance().options.cellSelectionOnly;
            return true;
        }// end function

        private function displayZone(param1:String, param2:Vector.<uint>, param3:Color) : void
        {
            var _loc_4:* = new Selection();
            new Selection().renderer = new ZoneDARenderer(PlacementStrataEnums.STRATA_AREA);
            _loc_4.color = param3;
            _loc_4.zone = new Custom(param2);
            SelectionManager.getInstance().addSelection(_loc_4, param1);
            SelectionManager.getInstance().update(param1);
            return;
        }// end function

        private function isValidPlacementCell(param1:uint, param2:uint) : Boolean
        {
            var _loc_4:Vector.<uint> = null;
            var _loc_3:* = MapPoint.fromCellId(param1);
            if (!DataMapProvider.getInstance().pointMov(_loc_3.x, _loc_3.y, false))
            {
                return false;
            }
            switch(param2)
            {
                case TeamEnum.TEAM_CHALLENGER:
                {
                    _loc_4 = this._challengerPositions;
                    break;
                }
                case TeamEnum.TEAM_DEFENDER:
                {
                    _loc_4 = this._defenderPositions;
                    break;
                }
                case TeamEnum.TEAM_SPECTATOR:
                {
                    return false;
                }
                default:
                {
                    break;
                }
            }
            var _loc_5:uint = 0;
            while (_loc_5 < _loc_4.length)
            {
                
                if (_loc_4[_loc_5] == param1)
                {
                    return true;
                }
                _loc_5 = _loc_5 + 1;
            }
            return false;
        }// end function

    }
}
