package com.ankamagames.dofus.logic.game.fight.frames
{
    import com.ankamagames.jerakine.messages.Frame;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.jerakine.types.Color;
    import __AS3__.vec.Vector;
    import com.ankamagames.jerakine.types.enums.Priority;
    import flash.ui.Mouse;
    import com.ankamagames.berilia.managers.LinkedCursorSpriteManager;
    import com.ankamagames.atouin.Atouin;
    import com.ankamagames.atouin.utils.DataMapProvider;
    import com.ankamagames.dofus.network.messages.game.context.fight.GameFightLeaveMessage;
    import com.ankamagames.dofus.network.messages.game.context.fight.GameFightPlacementPossiblePositionsMessage;
    import com.ankamagames.atouin.messages.CellClickMessage;
    import com.ankamagames.dofus.types.entities.AnimatedCharacter;
    import com.ankamagames.dofus.logic.game.fight.actions.GameFightPlacementPositionRequestAction;
    import com.ankamagames.dofus.network.messages.game.context.fight.GameFightPlacementPositionRequestMessage;
    import com.ankamagames.dofus.logic.game.fight.actions.GameFightReadyAction;
    import com.ankamagames.dofus.network.messages.game.context.fight.GameFightReadyMessage;
    import com.ankamagames.jerakine.entities.messages.EntityClickMessage;
    import com.ankamagames.jerakine.entities.interfaces.IInteractive;
    import com.ankamagames.dofus.logic.game.fight.actions.GameContextKickAction;
    import com.ankamagames.dofus.network.messages.game.context.GameContextKickMessage;
    import com.ankamagames.dofus.network.messages.game.context.fight.GameFightUpdateTeamMessage;
    import com.ankamagames.dofus.network.messages.game.context.fight.GameFightRemoveTeamMemberMessage;
    import com.ankamagames.dofus.network.messages.game.context.fight.GameFightEndMessage;
    import com.ankamagames.jerakine.entities.interfaces.IEntity;
    import com.ankamagames.berilia.types.data.ContextMenuData;
    import com.ankamagames.dofus.network.types.game.context.fight.FightTeamMemberInformations;
    import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
    import com.ankamagames.dofus.kernel.Kernel;
    import com.ankamagames.berilia.managers.KernelEventsManager;
    import com.ankamagames.dofus.misc.lists.HookList;
    import com.ankamagames.atouin.managers.EntitiesManager;
    import com.ankamagames.berilia.managers.UiModuleManager;
    import com.ankamagames.dofus.network.types.game.context.fight.GameFightCharacterInformations;
    import com.ankamagames.berilia.factories.MenusFactory;
    import com.ankamagames.dofus.network.types.game.context.fight.GameFightCompanionInformations;
    import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
    import com.ankamagames.dofus.network.messages.game.context.GameEntityDispositionErrorMessage;
    import com.ankamagames.dofus.logic.game.fight.actions.RemoveEntityAction;
    import com.ankamagames.dofus.network.messages.game.context.GameContextDestroyMessage;
    import com.ankamagames.dofus.logic.game.fight.managers.TacticModeManager;
    import com.ankamagames.dofus.logic.game.fight.actions.ShowTacticModeAction;
    import com.ankamagames.jerakine.messages.Message;
    import com.ankamagames.atouin.managers.SelectionManager;
    import com.ankamagames.atouin.types.Selection;
    import com.ankamagames.atouin.renderers.ZoneDARenderer;
    import com.ankamagames.atouin.enums.PlacementStrataEnums;
    import com.ankamagames.jerakine.types.zones.Custom;
    import com.ankamagames.jerakine.types.positions.MapPoint;
    import com.ankamagames.dofus.network.enums.TeamEnum;
    import com.ankamagames.jerakine.entities.interfaces.*;
    import __AS3__.vec.*;

    public class FightPreparationFrame implements Frame 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(FightPreparationFrame));
        private static const COLOR_CHALLENGER:Color = new Color(0xDD2200);
        private static const COLOR_DEFENDER:Color = new Color(8925);
        public static const SELECTION_CHALLENGER:String = "FightPlacementChallengerTeam";
        public static const SELECTION_DEFENDER:String = "FightPlacementDefenderTeam";

        private var _fightContextFrame:FightContextFrame;
        private var _playerTeam:uint;
        private var _challengerPositions:Vector.<uint>;
        private var _defenderPositions:Vector.<uint>;

        public function FightPreparationFrame(fightContextFrame:FightContextFrame)
        {
            this._fightContextFrame = fightContextFrame;
        }

        public function get priority():int
        {
            return (Priority.HIGH);
        }

        public function pushed():Boolean
        {
            Mouse.show();
            LinkedCursorSpriteManager.getInstance().removeItem("npcMonsterCursor");
            Atouin.getInstance().cellOverEnabled = true;
            this._fightContextFrame.entitiesFrame.untargetableEntities = true;
            DataMapProvider.getInstance().isInFight = true;
            return (true);
        }

        public function process(msg:Message):Boolean
        {
            var _local_2:GameFightLeaveMessage;
            var _local_3:GameFightPlacementPossiblePositionsMessage;
            var _local_4:CellClickMessage;
            var _local_5:AnimatedCharacter;
            var _local_6:GameFightPlacementPositionRequestAction;
            var _local_7:GameFightPlacementPositionRequestMessage;
            var _local_8:GameFightReadyAction;
            var _local_9:GameFightReadyMessage;
            var _local_10:EntityClickMessage;
            var _local_11:IInteractive;
            var _local_12:GameContextKickAction;
            var _local_13:GameContextKickMessage;
            var _local_14:GameFightUpdateTeamMessage;
            var _local_15:int;
            var _local_16:Boolean;
            var _local_17:GameFightRemoveTeamMemberMessage;
            var _local_18:GameFightEndMessage;
            var _local_19:FightContextFrame;
            var gfemsg:GameFightEndMessage;
            var fightContextFrame2:FightContextFrame;
            var entity:IEntity;
            var modContextMenu:Object;
            var menu:ContextMenuData;
            var fighter:Object;
            var entitiesFrame:FightEntitiesFrame;
            var fighterInfos:Object;
            var gfpprmsg:GameFightPlacementPositionRequestMessage;
            var teamMember:FightTeamMemberInformations;
            switch (true)
            {
                case (msg is GameFightLeaveMessage):
                    _local_2 = (msg as GameFightLeaveMessage);
                    if (_local_2.charId == PlayedCharacterManager.getInstance().id)
                    {
                        Kernel.getWorker().removeFrame(this);
                        KernelEventsManager.getInstance().processCallback(HookList.GameFightLeave, _local_2.charId);
                        gfemsg = new GameFightEndMessage();
                        gfemsg.initGameFightEndMessage();
                        fightContextFrame2 = (Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame);
                        if (fightContextFrame2)
                        {
                            fightContextFrame2.process(gfemsg);
                        }
                        else
                        {
                            Kernel.getWorker().process(gfemsg);
                        };
                        return (true);
                    };
                    return (false);
                case (msg is GameFightPlacementPossiblePositionsMessage):
                    _local_3 = (msg as GameFightPlacementPossiblePositionsMessage);
                    this.displayZone(SELECTION_CHALLENGER, (this._challengerPositions = _local_3.positionsForChallengers), COLOR_CHALLENGER);
                    this.displayZone(SELECTION_DEFENDER, (this._defenderPositions = _local_3.positionsForDefenders), COLOR_DEFENDER);
                    this._playerTeam = _local_3.teamNumber;
                    return (true);
                case (msg is CellClickMessage):
                    _local_4 = (msg as CellClickMessage);
                    for each (entity in EntitiesManager.getInstance().getEntitiesOnCell(_local_4.cellId))
                    {
                        if ((((entity is AnimatedCharacter)) && (!((entity as AnimatedCharacter).isMoving))))
                        {
                            _local_5 = (entity as AnimatedCharacter);
                            break;
                        };
                    };
                    if (_local_5)
                    {
                        modContextMenu = UiModuleManager.getInstance().getModule("Ankama_ContextMenu").mainClass;
                        fighter = new Object();
                        fighter.name = this._fightContextFrame.getFighterName(_local_5.id);
                        entitiesFrame = (Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame);
                        fighterInfos = entitiesFrame.getEntityInfos(_local_5.id);
                        if ((fighterInfos is GameFightCharacterInformations))
                        {
                            menu = MenusFactory.create((fighterInfos as GameFightCharacterInformations), "player", [_local_5]);
                        }
                        else
                        {
                            if ((fighterInfos is GameFightCompanionInformations))
                            {
                                menu = MenusFactory.create((fighterInfos as GameFightCompanionInformations), "companion", [_local_5]);
                            }
                            else
                            {
                                return (true);
                            };
                        };
                        if (menu)
                        {
                            modContextMenu.createContextMenu(menu);
                        };
                    }
                    else
                    {
                        if (this.isValidPlacementCell(_local_4.cellId, this._playerTeam))
                        {
                            gfpprmsg = new GameFightPlacementPositionRequestMessage();
                            gfpprmsg.initGameFightPlacementPositionRequestMessage(_local_4.cellId);
                            ConnectionsHandler.getConnection().send(gfpprmsg);
                        };
                    };
                    return (true);
                case (msg is GameFightPlacementPositionRequestAction):
                    _local_6 = (msg as GameFightPlacementPositionRequestAction);
                    _local_7 = new GameFightPlacementPositionRequestMessage();
                    _local_7.initGameFightPlacementPositionRequestMessage(_local_6.cellId);
                    ConnectionsHandler.getConnection().send(_local_7);
                    return (true);
                case (msg is GameEntityDispositionErrorMessage):
                    _log.error("Cette position n'est pas accessible.");
                    return (true);
                case (msg is GameFightReadyAction):
                    _local_8 = (msg as GameFightReadyAction);
                    _local_9 = new GameFightReadyMessage();
                    _local_9.initGameFightReadyMessage(_local_8.isReady);
                    ConnectionsHandler.getConnection().send(_local_9);
                    return (true);
                case (msg is EntityClickMessage):
                    _local_10 = (msg as EntityClickMessage);
                    _local_11 = (_local_10.entity as IInteractive);
                    if (_local_11)
                    {
                        modContextMenu = UiModuleManager.getInstance().getModule("Ankama_ContextMenu").mainClass;
                        fighter = new Object();
                        fighter.name = this._fightContextFrame.getFighterName(_local_11.id);
                        entitiesFrame = (Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame);
                        fighterInfos = entitiesFrame.getEntityInfos(_local_11.id);
                        if ((fighterInfos is GameFightCharacterInformations))
                        {
                            menu = MenusFactory.create(fighter, "player", [_local_11]);
                        }
                        else
                        {
                            if ((fighterInfos is GameFightCompanionInformations))
                            {
                                menu = MenusFactory.create(fighter, "companion", [_local_11]);
                            }
                            else
                            {
                                return (true);
                            };
                        };
                        if (menu)
                        {
                            modContextMenu.createContextMenu(menu);
                        };
                    };
                    return (true);
                case (msg is GameContextKickAction):
                    _local_12 = (msg as GameContextKickAction);
                    _local_13 = new GameContextKickMessage();
                    _local_13.initGameContextKickMessage(_local_12.targetId);
                    ConnectionsHandler.getConnection().send(_local_13);
                    return (true);
                case (msg is GameFightUpdateTeamMessage):
                    _local_14 = (msg as GameFightUpdateTeamMessage);
                    _local_15 = PlayedCharacterManager.getInstance().id;
                    _local_16 = false;
                    for each (teamMember in _local_14.team.teamMembers)
                    {
                        if (teamMember.id == _local_15)
                        {
                            _local_16 = true;
                        };
                    };
                    if (((_local_16) || ((((_local_14.team.teamMembers.length >= 1)) && ((_local_14.team.teamMembers[0].id == _local_15))))))
                    {
                        PlayedCharacterManager.getInstance().teamId = _local_14.team.teamId;
                        this._fightContextFrame.isFightLeader = (_local_14.team.leaderId == _local_15);
                    };
                    return (true);
                case (msg is GameFightRemoveTeamMemberMessage):
                    _local_17 = (msg as GameFightRemoveTeamMemberMessage);
                    this._fightContextFrame.entitiesFrame.process(RemoveEntityAction.create(_local_17.charId));
                    return (true);
                case (msg is GameContextDestroyMessage):
                    _local_18 = new GameFightEndMessage();
                    _local_18.initGameFightEndMessage();
                    _local_19 = (Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame);
                    if (_local_19)
                    {
                        _local_19.process(_local_18);
                    }
                    else
                    {
                        Kernel.getWorker().process(_local_18);
                    };
                    return (true);
                case (msg is ShowTacticModeAction):
                    this.removeSelections();
                    if (!(TacticModeManager.getInstance().tacticModeActivated))
                    {
                        TacticModeManager.getInstance().show(PlayedCharacterManager.getInstance().currentMap);
                    }
                    else
                    {
                        TacticModeManager.getInstance().hide();
                    };
                    this.displayZone(SELECTION_CHALLENGER, this._challengerPositions, COLOR_CHALLENGER);
                    this.displayZone(SELECTION_DEFENDER, this._defenderPositions, COLOR_DEFENDER);
                    return (true);
            };
            return (false);
        }

        public function pulled():Boolean
        {
            DataMapProvider.getInstance().isInFight = false;
            this.removeSelections();
            this._fightContextFrame.entitiesFrame.untargetableEntities = Dofus.getInstance().options.cellSelectionOnly;
            return (true);
        }

        private function removeSelections():void
        {
            var sc:Selection = SelectionManager.getInstance().getSelection(SELECTION_CHALLENGER);
            if (sc)
            {
                sc.remove();
            };
            var sd:Selection = SelectionManager.getInstance().getSelection(SELECTION_DEFENDER);
            if (sd)
            {
                sd.remove();
            };
        }

        private function displayZone(name:String, cells:Vector.<uint>, color:Color):void
        {
            var s:Selection = new Selection();
            s.renderer = new ZoneDARenderer(PlacementStrataEnums.STRATA_AREA);
            s.color = color;
            s.zone = new Custom(cells);
            SelectionManager.getInstance().addSelection(s, name);
            SelectionManager.getInstance().update(name);
        }

        private function isValidPlacementCell(cellId:uint, team:uint):Boolean
        {
            var i:uint;
            var mapPoint:MapPoint = MapPoint.fromCellId(cellId);
            if (!(DataMapProvider.getInstance().pointMov(mapPoint.x, mapPoint.y, false)))
            {
                return (false);
            };
            var validCells:Vector.<uint> = new Vector.<uint>();
            switch (team)
            {
                case TeamEnum.TEAM_CHALLENGER:
                    validCells = this._challengerPositions;
                    break;
                case TeamEnum.TEAM_DEFENDER:
                    validCells = this._defenderPositions;
                    break;
                case TeamEnum.TEAM_SPECTATOR:
                    return (false);
            };
            if (validCells)
            {
                i = 0;
                while (i < validCells.length)
                {
                    if (validCells[i] == cellId)
                    {
                        return (true);
                    };
                    i++;
                };
            };
            return (false);
        }


    }
}//package com.ankamagames.dofus.logic.game.fight.frames

