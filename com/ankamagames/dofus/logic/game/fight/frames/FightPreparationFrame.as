package com.ankamagames.dofus.logic.game.fight.frames
{
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.types.Color;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import __AS3__.vec.Vector;
   import com.ankamagames.jerakine.types.enums.Priority;
   import flash.ui.Mouse;
   import com.ankamagames.berilia.managers.LinkedCursorSpriteManager;
   import com.ankamagames.atouin.Atouin;
   import com.ankamagames.atouin.utils.DataMapProvider;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.dofus.network.messages.game.context.fight.GameFightLeaveMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.GameFightPlacementPossiblePositionsMessage;
   import com.ankamagames.atouin.messages.CellClickMessage;
   import com.ankamagames.dofus.types.entities.AnimatedCharacter;
   import com.ankamagames.dofus.logic.game.fight.actions.GameFightPlacementPositionRequestAction;
   import com.ankamagames.dofus.network.messages.game.context.fight.GameFightPlacementPositionRequestMessage;
   import com.ankamagames.dofus.logic.game.fight.actions.GameFightReadyAction;
   import com.ankamagames.dofus.network.messages.game.context.fight.GameFightReadyMessage;
   import com.ankamagames.jerakine.entities.messages.EntityClickMessage;
   import com.ankamagames.dofus.logic.game.fight.actions.GameContextKickAction;
   import com.ankamagames.dofus.network.messages.game.context.GameContextKickMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.GameFightUpdateTeamMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.GameFightRemoveTeamMemberMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.GameFightEndMessage;
   import com.ankamagames.berilia.types.data.ContextMenuData;
   import com.ankamagames.dofus.network.types.game.context.fight.FightTeamMemberInformations;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.atouin.managers.EntitiesManager;
   import com.ankamagames.berilia.managers.UiModuleManager;
   import com.ankamagames.jerakine.entities.interfaces.*;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightCharacterInformations;
   import com.ankamagames.berilia.factories.MenusFactory;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightCompanionInformations;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.dofus.logic.game.fight.actions.RemoveEntityAction;
   import com.ankamagames.dofus.logic.game.fight.managers.TacticModeManager;
   import com.ankamagames.dofus.network.messages.game.context.GameEntityDispositionErrorMessage;
   import com.ankamagames.dofus.network.messages.game.context.GameContextDestroyMessage;
   import com.ankamagames.dofus.logic.game.fight.actions.ShowTacticModeAction;
   import com.ankamagames.atouin.managers.SelectionManager;
   import com.ankamagames.atouin.types.Selection;
   import com.ankamagames.atouin.renderers.ZoneDARenderer;
   import com.ankamagames.atouin.enums.PlacementStrataEnums;
   import com.ankamagames.jerakine.types.zones.Custom;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.dofus.network.enums.TeamEnum;
   
   public class FightPreparationFrame extends Object implements Frame
   {
      
      public function FightPreparationFrame(param1:FightContextFrame) {
         super();
         this._fightContextFrame = param1;
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(FightPreparationFrame));
      
      private static const COLOR_CHALLENGER:Color = new Color(14492160);
      
      private static const COLOR_DEFENDER:Color = new Color(8925);
      
      public static const SELECTION_CHALLENGER:String = "FightPlacementChallengerTeam";
      
      public static const SELECTION_DEFENDER:String = "FightPlacementDefenderTeam";
      
      private var _fightContextFrame:FightContextFrame;
      
      private var _playerTeam:uint;
      
      private var _challengerPositions:Vector.<uint>;
      
      private var _defenderPositions:Vector.<uint>;
      
      public function get priority() : int {
         return Priority.HIGH;
      }
      
      public function pushed() : Boolean {
         Mouse.show();
         LinkedCursorSpriteManager.getInstance().removeItem("npcMonsterCursor");
         Atouin.getInstance().cellOverEnabled = true;
         this._fightContextFrame.entitiesFrame.untargetableEntities = true;
         DataMapProvider.getInstance().isInFight = true;
         return true;
      }
      
      public function process(param1:Message) : Boolean {
         var _loc2_:GameFightLeaveMessage = null;
         var _loc3_:GameFightPlacementPossiblePositionsMessage = null;
         var _loc4_:CellClickMessage = null;
         var _loc5_:AnimatedCharacter = null;
         var _loc6_:GameFightPlacementPositionRequestAction = null;
         var _loc7_:GameFightPlacementPositionRequestMessage = null;
         var _loc8_:GameFightReadyAction = null;
         var _loc9_:GameFightReadyMessage = null;
         var _loc10_:EntityClickMessage = null;
         var _loc11_:IInteractive = null;
         var _loc12_:GameContextKickAction = null;
         var _loc13_:GameContextKickMessage = null;
         var _loc14_:GameFightUpdateTeamMessage = null;
         var _loc15_:* = 0;
         var _loc16_:* = false;
         var _loc17_:GameFightRemoveTeamMemberMessage = null;
         var _loc18_:GameFightEndMessage = null;
         var _loc19_:FightContextFrame = null;
         var _loc20_:GameFightEndMessage = null;
         var _loc21_:FightContextFrame = null;
         var _loc22_:IEntity = null;
         var _loc23_:Object = null;
         var _loc24_:ContextMenuData = null;
         var _loc25_:Object = null;
         var _loc26_:FightEntitiesFrame = null;
         var _loc27_:Object = null;
         var _loc28_:GameFightPlacementPositionRequestMessage = null;
         var _loc29_:FightTeamMemberInformations = null;
         switch(true)
         {
            case param1 is GameFightLeaveMessage:
               _loc2_ = param1 as GameFightLeaveMessage;
               if(_loc2_.charId == PlayedCharacterManager.getInstance().id)
               {
                  Kernel.getWorker().removeFrame(this);
                  KernelEventsManager.getInstance().processCallback(HookList.GameFightLeave,_loc2_.charId);
                  _loc20_ = new GameFightEndMessage();
                  _loc20_.initGameFightEndMessage();
                  _loc21_ = Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame;
                  if(_loc21_)
                  {
                     _loc21_.process(_loc20_);
                  }
                  else
                  {
                     Kernel.getWorker().process(_loc20_);
                  }
                  return true;
               }
               return false;
            case param1 is GameFightPlacementPossiblePositionsMessage:
               _loc3_ = param1 as GameFightPlacementPossiblePositionsMessage;
               this.displayZone(SELECTION_CHALLENGER,this._challengerPositions = _loc3_.positionsForChallengers,COLOR_CHALLENGER);
               this.displayZone(SELECTION_DEFENDER,this._defenderPositions = _loc3_.positionsForDefenders,COLOR_DEFENDER);
               this._playerTeam = _loc3_.teamNumber;
               return true;
            case param1 is CellClickMessage:
               _loc4_ = param1 as CellClickMessage;
               for each (_loc22_ in EntitiesManager.getInstance().getEntitiesOnCell(_loc4_.cellId))
               {
                  if(_loc22_ is AnimatedCharacter && !(_loc22_ as AnimatedCharacter).isMoving)
                  {
                     _loc5_ = _loc22_ as AnimatedCharacter;
                     break;
                  }
               }
               if(_loc5_)
               {
                  _loc23_ = UiModuleManager.getInstance().getModule("Ankama_ContextMenu").mainClass;
                  _loc25_ = new Object();
                  _loc25_.name = this._fightContextFrame.getFighterName(_loc5_.id);
                  _loc26_ = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
                  _loc27_ = _loc26_.getEntityInfos(_loc5_.id);
                  if(_loc27_ is GameFightCharacterInformations)
                  {
                     _loc24_ = MenusFactory.create(_loc27_ as GameFightCharacterInformations,"player",[_loc5_]);
                  }
                  else
                  {
                     if(_loc27_ is GameFightCompanionInformations)
                     {
                        _loc24_ = MenusFactory.create(_loc27_ as GameFightCompanionInformations,"companion",[_loc5_]);
                     }
                     else
                     {
                        return true;
                     }
                  }
                  if(_loc24_)
                  {
                     _loc23_.createContextMenu(_loc24_);
                  }
               }
               else
               {
                  if(this.isValidPlacementCell(_loc4_.cellId,this._playerTeam))
                  {
                     _loc28_ = new GameFightPlacementPositionRequestMessage();
                     _loc28_.initGameFightPlacementPositionRequestMessage(_loc4_.cellId);
                     ConnectionsHandler.getConnection().send(_loc28_);
                  }
               }
               return true;
            case param1 is GameFightPlacementPositionRequestAction:
               _loc6_ = param1 as GameFightPlacementPositionRequestAction;
               _loc7_ = new GameFightPlacementPositionRequestMessage();
               _loc7_.initGameFightPlacementPositionRequestMessage(_loc6_.cellId);
               ConnectionsHandler.getConnection().send(_loc7_);
               return true;
            case param1 is GameEntityDispositionErrorMessage:
               _log.error("Cette position n\'est pas accessible.");
               return true;
            case param1 is GameFightReadyAction:
               _loc8_ = param1 as GameFightReadyAction;
               _loc9_ = new GameFightReadyMessage();
               _loc9_.initGameFightReadyMessage(_loc8_.isReady);
               ConnectionsHandler.getConnection().send(_loc9_);
               return true;
            case param1 is EntityClickMessage:
               _loc10_ = param1 as EntityClickMessage;
               _loc11_ = _loc10_.entity as IInteractive;
               if(_loc11_)
               {
                  _loc23_ = UiModuleManager.getInstance().getModule("Ankama_ContextMenu").mainClass;
                  _loc25_ = new Object();
                  _loc25_.name = this._fightContextFrame.getFighterName(_loc11_.id);
                  _loc26_ = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
                  _loc27_ = _loc26_.getEntityInfos(_loc11_.id);
                  if(_loc27_ is GameFightCharacterInformations)
                  {
                     _loc24_ = MenusFactory.create(_loc25_,"player",[_loc11_]);
                  }
                  else
                  {
                     if(_loc27_ is GameFightCompanionInformations)
                     {
                        _loc24_ = MenusFactory.create(_loc25_,"companion",[_loc11_]);
                     }
                     else
                     {
                        return true;
                     }
                  }
                  if(_loc24_)
                  {
                     _loc23_.createContextMenu(_loc24_);
                  }
               }
               return true;
            case param1 is GameContextKickAction:
               _loc12_ = param1 as GameContextKickAction;
               _loc13_ = new GameContextKickMessage();
               _loc13_.initGameContextKickMessage(_loc12_.targetId);
               ConnectionsHandler.getConnection().send(_loc13_);
               return true;
            case param1 is GameFightUpdateTeamMessage:
               _loc14_ = param1 as GameFightUpdateTeamMessage;
               _loc15_ = PlayedCharacterManager.getInstance().id;
               _loc16_ = false;
               for each (_loc29_ in _loc14_.team.teamMembers)
               {
                  if(_loc29_.id == _loc15_)
                  {
                     _loc16_ = true;
                  }
               }
               if((_loc16_) || _loc14_.team.teamMembers.length >= 1 && _loc14_.team.teamMembers[0].id == _loc15_)
               {
                  PlayedCharacterManager.getInstance().teamId = _loc14_.team.teamId;
                  this._fightContextFrame.isFightLeader = _loc14_.team.leaderId == _loc15_;
               }
               return true;
            case param1 is GameFightRemoveTeamMemberMessage:
               _loc17_ = param1 as GameFightRemoveTeamMemberMessage;
               this._fightContextFrame.entitiesFrame.process(RemoveEntityAction.create(_loc17_.charId));
               return true;
            case param1 is GameContextDestroyMessage:
               _loc18_ = new GameFightEndMessage();
               _loc18_.initGameFightEndMessage();
               _loc19_ = Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame;
               if(_loc19_)
               {
                  _loc19_.process(_loc18_);
               }
               else
               {
                  Kernel.getWorker().process(_loc18_);
               }
               return true;
            case param1 is ShowTacticModeAction:
               this.removeSelections();
               if(!TacticModeManager.getInstance().tacticModeActivated)
               {
                  TacticModeManager.getInstance().show(PlayedCharacterManager.getInstance().currentMap);
               }
               else
               {
                  TacticModeManager.getInstance().hide();
               }
               this.displayZone(SELECTION_CHALLENGER,this._challengerPositions,COLOR_CHALLENGER);
               this.displayZone(SELECTION_DEFENDER,this._defenderPositions,COLOR_DEFENDER);
               return true;
            default:
               return false;
         }
      }
      
      public function pulled() : Boolean {
         DataMapProvider.getInstance().isInFight = false;
         this.removeSelections();
         this._fightContextFrame.entitiesFrame.untargetableEntities = Dofus.getInstance().options.cellSelectionOnly;
         return true;
      }
      
      private function removeSelections() : void {
         var _loc1_:Selection = SelectionManager.getInstance().getSelection(SELECTION_CHALLENGER);
         if(_loc1_)
         {
            _loc1_.remove();
         }
         var _loc2_:Selection = SelectionManager.getInstance().getSelection(SELECTION_DEFENDER);
         if(_loc2_)
         {
            _loc2_.remove();
         }
      }
      
      private function displayZone(param1:String, param2:Vector.<uint>, param3:Color) : void {
         var _loc4_:Selection = new Selection();
         _loc4_.renderer = new ZoneDARenderer(PlacementStrataEnums.STRATA_AREA);
         _loc4_.color = param3;
         _loc4_.zone = new Custom(param2);
         SelectionManager.getInstance().addSelection(_loc4_,param1);
         SelectionManager.getInstance().update(param1);
      }
      
      private function isValidPlacementCell(param1:uint, param2:uint) : Boolean {
         var _loc5_:uint = 0;
         var _loc3_:MapPoint = MapPoint.fromCellId(param1);
         if(!DataMapProvider.getInstance().pointMov(_loc3_.x,_loc3_.y,false))
         {
            return false;
         }
         var _loc4_:Vector.<uint> = new Vector.<uint>();
         switch(param2)
         {
            case TeamEnum.TEAM_CHALLENGER:
               _loc4_ = this._challengerPositions;
               break;
            case TeamEnum.TEAM_DEFENDER:
               _loc4_ = this._defenderPositions;
               break;
            case TeamEnum.TEAM_SPECTATOR:
               return false;
         }
         if(_loc4_)
         {
            _loc5_ = 0;
            while(_loc5_ < _loc4_.length)
            {
               if(_loc4_[_loc5_] == param1)
               {
                  return true;
               }
               _loc5_++;
            }
         }
         return false;
      }
   }
}
