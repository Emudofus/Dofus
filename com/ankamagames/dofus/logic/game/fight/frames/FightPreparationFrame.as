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
   import com.ankamagames.dofus.logic.game.fight.actions.GameFightReadyAction;
   import com.ankamagames.dofus.network.messages.game.context.fight.GameFightReadyMessage;
   import com.ankamagames.jerakine.entities.messages.EntityClickMessage;
   import com.ankamagames.berilia.types.data.ContextMenuData;
   import com.ankamagames.dofus.logic.game.fight.actions.GameContextKickAction;
   import com.ankamagames.dofus.network.messages.game.context.GameContextKickMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.GameFightUpdateTeamMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.GameFightRemoveTeamMemberMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.GameFightEndMessage;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightCharacterInformations;
   import com.ankamagames.dofus.network.messages.game.context.fight.GameFightPlacementPositionRequestMessage;
   import com.ankamagames.dofus.network.types.game.context.fight.FightTeamMemberInformations;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.atouin.managers.EntitiesManager;
   import com.ankamagames.berilia.managers.UiModuleManager;
   import com.ankamagames.berilia.factories.MenusFactory;
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
         

      public function FightPreparationFrame(fightContextFrame:FightContextFrame) {
         super();
         this._fightContextFrame=fightContextFrame;
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
         Atouin.getInstance().cellOverEnabled=true;
         this._fightContextFrame.entitiesFrame.untargetableEntities=true;
         DataMapProvider.getInstance().isInFight=true;
         return true;
      }

      public function process(msg:Message) : Boolean {
         var gflmsg:GameFightLeaveMessage = null;
         var gfpppmsg:GameFightPlacementPossiblePositionsMessage = null;
         var ccmsg:CellClickMessage = null;
         var cellEntity:AnimatedCharacter = null;
         var gfra:GameFightReadyAction = null;
         var gfrmsg:GameFightReadyMessage = null;
         var ecmsg:EntityClickMessage = null;
         var fighter:Object = null;
         var modContextMenu:Object = null;
         var menu:ContextMenuData = null;
         var gcka:GameContextKickAction = null;
         var playerId:uint = 0;
         var gckmsg:GameContextKickMessage = null;
         var gfutmsg:GameFightUpdateTeamMessage = null;
         var gfutmsg_myId:* = 0;
         var alreadyInTeam:* = false;
         var gfrtmmsg:GameFightRemoveTeamMemberMessage = null;
         var gfemsg2:GameFightEndMessage = null;
         var fightContextFrame:FightContextFrame = null;
         var gfemsg:GameFightEndMessage = null;
         var entity:IEntity = null;
         var fighterName:String = null;
         var entitiesFrame:FightEntitiesFrame = null;
         var playerInfos:GameFightCharacterInformations = null;
         var gfpprmsg:GameFightPlacementPositionRequestMessage = null;
         var teamMember:FightTeamMemberInformations = null;
         switch(true)
         {
            case msg is GameFightLeaveMessage:
               gflmsg=msg as GameFightLeaveMessage;
               if(gflmsg.charId==PlayedCharacterManager.getInstance().id)
               {
                  Kernel.getWorker().removeFrame(this);
                  KernelEventsManager.getInstance().processCallback(HookList.GameFightLeave,gflmsg.charId);
                  gfemsg=new GameFightEndMessage();
                  gfemsg.initGameFightEndMessage();
                  Kernel.getWorker().process(gfemsg);
                  return true;
               }
               return false;
            case msg is GameFightPlacementPossiblePositionsMessage:
               gfpppmsg=msg as GameFightPlacementPossiblePositionsMessage;
               this.displayZone(SELECTION_CHALLENGER,this._challengerPositions=gfpppmsg.positionsForChallengers,COLOR_CHALLENGER);
               this.displayZone(SELECTION_DEFENDER,this._defenderPositions=gfpppmsg.positionsForDefenders,COLOR_DEFENDER);
               this._playerTeam=gfpppmsg.teamNumber;
               return true;
            case msg is CellClickMessage:
               ccmsg=msg as CellClickMessage;
               for each (entity in EntitiesManager.getInstance().getEntitiesOnCell(ccmsg.cellId))
               {
                  if((entity is AnimatedCharacter)&&(!(entity as AnimatedCharacter).isMoving))
                  {
                     cellEntity=entity as AnimatedCharacter;
                     break;
                  }
               }
               if(cellEntity)
               {
                  if(cellEntity.id>0)
                  {
                     fighterName=this._fightContextFrame.getFighterName(cellEntity.id);
                     entitiesFrame=Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
                     playerInfos=entitiesFrame.getEntityInfos(cellEntity.id) as GameFightCharacterInformations;
                     modContextMenu=UiModuleManager.getInstance().getModule("Ankama_ContextMenu").mainClass;
                     menu=MenusFactory.create(playerInfos,"player",[cellEntity]);
                     modContextMenu.createContextMenu(menu);
                  }
               }
               else
               {
                  if(this.isValidPlacementCell(ccmsg.cellId,this._playerTeam))
                  {
                     gfpprmsg=new GameFightPlacementPositionRequestMessage();
                     gfpprmsg.initGameFightPlacementPositionRequestMessage(ccmsg.cellId);
                     ConnectionsHandler.getConnection().send(gfpprmsg);
                  }
               }
               return true;
            case msg is GameEntityDispositionErrorMessage:
               _log.error("Cette position n\'est pas accessible.");
               return true;
            case msg is GameFightReadyAction:
               gfra=msg as GameFightReadyAction;
               gfrmsg=new GameFightReadyMessage();
               gfrmsg.initGameFightReadyMessage(gfra.isReady);
               ConnectionsHandler.getConnection().send(gfrmsg);
               return true;
            case msg is EntityClickMessage:
               ecmsg=msg as EntityClickMessage;
               if(ecmsg.entity.id<0)
               {
                  return true;
               }
               fighter=new Object();
               fighter.name=this._fightContextFrame.getFighterName(ecmsg.entity.id);
               modContextMenu=UiModuleManager.getInstance().getModule("Ankama_ContextMenu").mainClass;
               menu=MenusFactory.create(fighter,"player",[ecmsg.entity]);
               modContextMenu.createContextMenu(menu);
               return true;
            case msg is GameContextKickAction:
               gcka=msg as GameContextKickAction;
               playerId=PlayedCharacterManager.getInstance().infos.id;
               gckmsg=new GameContextKickMessage();
               gckmsg.initGameContextKickMessage(gcka.targetId);
               ConnectionsHandler.getConnection().send(gckmsg);
               return true;
            case msg is GameFightUpdateTeamMessage:
               gfutmsg=msg as GameFightUpdateTeamMessage;
               gfutmsg_myId=PlayedCharacterManager.getInstance().id;
               alreadyInTeam=false;
               for each (teamMember in gfutmsg.team.teamMembers)
               {
                  if(teamMember.id==gfutmsg_myId)
                  {
                     alreadyInTeam=true;
                  }
               }
               if((alreadyInTeam)||(gfutmsg.team.teamMembers.length>=1)&&(gfutmsg.team.teamMembers[0].id==gfutmsg_myId))
               {
                  PlayedCharacterManager.getInstance().teamId=gfutmsg.team.teamId;
                  this._fightContextFrame.isFightLeader=gfutmsg.team.leaderId==gfutmsg_myId;
               }
               return true;
            case msg is GameFightRemoveTeamMemberMessage:
               gfrtmmsg=msg as GameFightRemoveTeamMemberMessage;
               this._fightContextFrame.entitiesFrame.process(RemoveEntityAction.create(gfrtmmsg.charId));
               return true;
            case msg is GameContextDestroyMessage:
               gfemsg2=new GameFightEndMessage();
               gfemsg2.initGameFightEndMessage();
               fightContextFrame=Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame;
               if(fightContextFrame)
               {
                  fightContextFrame.process(gfemsg2);
               }
               else
               {
                  Kernel.getWorker().process(gfemsg2);
               }
               return true;
            case msg is ShowTacticModeAction:
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
         DataMapProvider.getInstance().isInFight=false;
         this.removeSelections();
         this._fightContextFrame.entitiesFrame.untargetableEntities=Dofus.getInstance().options.cellSelectionOnly;
         return true;
      }

      private function removeSelections() : void {
         var sc:Selection = SelectionManager.getInstance().getSelection(SELECTION_CHALLENGER);
         if(sc)
         {
            sc.remove();
         }
         var sd:Selection = SelectionManager.getInstance().getSelection(SELECTION_DEFENDER);
         if(sd)
         {
            sd.remove();
         }
      }

      private function displayZone(name:String, cells:Vector.<uint>, color:Color) : void {
         var s:Selection = new Selection();
         s.renderer=new ZoneDARenderer(PlacementStrataEnums.STRATA_AREA);
         s.color=color;
         s.zone=new Custom(cells);
         SelectionManager.getInstance().addSelection(s,name);
         SelectionManager.getInstance().update(name);
      }

      private function isValidPlacementCell(cellId:uint, team:uint) : Boolean {
         var i:uint = 0;
         var mapPoint:MapPoint = MapPoint.fromCellId(cellId);
         if(!DataMapProvider.getInstance().pointMov(mapPoint.x,mapPoint.y,false))
         {
            return false;
         }
         var validCells:Vector.<uint> = new Vector.<uint>();
         switch(team)
         {
            case TeamEnum.TEAM_CHALLENGER:
               validCells=this._challengerPositions;
               break;
            case TeamEnum.TEAM_DEFENDER:
               validCells=this._defenderPositions;
               break;
            case TeamEnum.TEAM_SPECTATOR:
               return false;
               break;
         }
         if(validCells)
         {
            i=0;
            while(i<validCells.length)
            {
               if(validCells[i]==cellId)
               {
                  return true;
               }
               i++;
            }
         }
         return false;
      }
   }

}