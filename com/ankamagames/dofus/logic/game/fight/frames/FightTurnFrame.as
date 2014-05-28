package com.ankamagames.dofus.logic.game.fight.frames
{
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.types.Color;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.atouin.types.Selection;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.berilia.types.data.LinkedCursorData;
   import flash.text.TextField;
   import com.ankamagames.jerakine.types.positions.MovementPath;
   import com.ankamagames.jerakine.types.enums.Priority;
   import flash.utils.clearTimeout;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.atouin.messages.CellOverMessage;
   import com.ankamagames.dofus.logic.game.fight.actions.GameFightSpellCastAction;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterInformations;
   import com.ankamagames.atouin.messages.CellClickMessage;
   import com.ankamagames.atouin.messages.EntityMovementCompleteMessage;
   import com.ankamagames.dofus.logic.game.fight.managers.CurrentPlayedFighterManager;
   import com.ankamagames.dofus.network.messages.game.context.GameMapNoMovementMessage;
   import com.ankamagames.dofus.logic.game.fight.actions.GameFightTurnFinishAction;
   import com.ankamagames.atouin.messages.MapContainerRollOutMessage;
   import com.ankamagames.atouin.Atouin;
   import com.ankamagames.jerakine.types.positions.PathElement;
   import flash.display.Sprite;
   import flash.text.TextFormat;
   import flash.filters.GlowFilter;
   import com.ankamagames.dofus.network.types.game.character.characteristic.CharacterCharacteristicsInformations;
   import com.ankamagames.jerakine.pathfinding.Pathfinding;
   import com.ankamagames.atouin.utils.DataMapProvider;
   import com.ankamagames.jerakine.entities.interfaces.*;
   import com.ankamagames.dofus.logic.game.fight.miscs.TackleUtil;
   import com.ankamagames.atouin.renderers.MovementZoneRenderer;
   import com.ankamagames.atouin.managers.SelectionManager;
   import com.ankamagames.jerakine.types.zones.Custom;
   import com.ankamagames.jerakine.managers.FontManager;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.berilia.managers.EmbedFontManager;
   import flash.geom.Point;
   import com.ankamagames.berilia.managers.LinkedCursorSpriteManager;
   import com.ankamagames.dofus.network.messages.game.context.GameMapMovementRequestMessage;
   import com.ankamagames.dofus.logic.game.common.managers.MapMovementAdapter;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.dofus.network.messages.game.context.fight.GameFightTurnFinishMessage;
   import flash.utils.setTimeout;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.misc.lists.ChatHookList;
   import com.ankamagames.dofus.logic.game.common.frames.ChatFrame;
   import com.ankamagames.dofus.logic.game.common.managers.TimeManager;
   import com.ankamagames.dofus.misc.lists.FightHookList;
   
   public class FightTurnFrame extends Object implements Frame
   {
      
      public function FightTurnFrame() {
         super();
      }
      
      private static const TAKLED_CURSOR_NAME:String = "TackledCursor";
      
      protected static const _log:Logger;
      
      public static const SELECTION_PATH:String = "FightMovementPath";
      
      public static const SELECTION_PATH_UNREACHABLE:String = "FightMovementPathUnreachable";
      
      private static const PATH_COLOR:Color;
      
      private static const PATH_UNREACHABLE_COLOR:Color;
      
      private static const REMIND_TURN_DELAY:uint = 15000;
      
      private var _movementSelection:Selection;
      
      private var _movementSelectionUnreachable:Selection;
      
      private var _isRequestingMovement:Boolean;
      
      private var _spellCastFrame:Frame;
      
      private var _finishingTurn:Boolean;
      
      private var _remindTurnTimeoutId:uint;
      
      private var _myTurn:Boolean;
      
      private var _turnDuration:uint;
      
      private var _lastCell:MapPoint;
      
      private var _cursorData:LinkedCursorData = null;
      
      private var _tfAP:TextField;
      
      private var _tfMP:TextField;
      
      private var _cells:Vector.<uint>;
      
      private var _cellsUnreachable:Vector.<uint>;
      
      private var _lastPath:MovementPath;
      
      public function get priority() : int {
         return Priority.HIGH;
      }
      
      public function get myTurn() : Boolean {
         return this._myTurn;
      }
      
      public function set myTurn(b:Boolean) : void {
         var fcf:FightContextFrame = null;
         var entity:IEntity = null;
         var refreshTarget:Boolean = !(b == this._myTurn);
         var monsterEndTurn:Boolean = !this._myTurn;
         this._myTurn = b;
         if(b)
         {
            this.startRemindTurn();
         }
         else
         {
            this._isRequestingMovement = false;
            if(this._remindTurnTimeoutId != 0)
            {
               clearTimeout(this._remindTurnTimeoutId);
            }
            this.removePath();
         }
         var scf:FightSpellCastFrame = Kernel.getWorker().getFrame(FightSpellCastFrame) as FightSpellCastFrame;
         if(scf)
         {
            if(monsterEndTurn)
            {
               scf.drawRange();
            }
            if(refreshTarget)
            {
               if(scf)
               {
                  fcf = Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame;
                  if(fcf.timelineOverEntityId)
                  {
                     entity = DofusEntities.getEntity(fcf.timelineOverEntityId);
                     if(entity)
                     {
                        FightContextFrame.currentCell = entity.position.cellId;
                     }
                  }
                  scf.refreshTarget(true);
               }
            }
         }
         if((this._myTurn) && (!scf))
         {
            this.drawPath();
         }
      }
      
      public function set turnDuration(v:uint) : void {
         this._turnDuration = v;
      }
      
      public function get lastPath() : MovementPath {
         return this._lastPath;
      }
      
      public function freePlayer() : void {
         this._isRequestingMovement = false;
      }
      
      public function pushed() : Boolean {
         return true;
      }
      
      public function process(msg:Message) : Boolean {
         var conmsg:CellOverMessage = null;
         var gfsca:GameFightSpellCastAction = null;
         var myId:* = 0;
         var playerInformation:GameFightFighterInformations = null;
         var ccmsg:CellClickMessage = null;
         var emcmsg:EntityMovementCompleteMessage = null;
         var cfId:* = 0;
         var imE:IMovable = null;
         var spellCastFrame:Frame = null;
         switch(true)
         {
            case msg is CellOverMessage:
               if(!this.myTurn)
               {
                  return false;
               }
               if(Kernel.getWorker().getFrame(FightSpellCastFrame) != null)
               {
                  return false;
               }
               conmsg = msg as CellOverMessage;
               this.drawPath(conmsg.cell);
               this._lastCell = conmsg.cell;
               return false;
            case msg is GameFightSpellCastAction:
               gfsca = msg as GameFightSpellCastAction;
               if(this._spellCastFrame != null)
               {
                  Kernel.getWorker().removeFrame(this._spellCastFrame);
               }
               this.removePath();
               if(this._myTurn)
               {
                  this.startRemindTurn();
               }
               myId = CurrentPlayedFighterManager.getInstance().currentFighterId;
               playerInformation = FightEntitiesFrame.getCurrentInstance().getEntityInfos(myId) as GameFightFighterInformations;
               if((playerInformation) && (playerInformation.alive))
               {
                  Kernel.getWorker().addFrame(this._spellCastFrame = new FightSpellCastFrame(gfsca.spellId));
               }
               return true;
            case msg is CellClickMessage:
               if(!this.myTurn)
               {
                  return false;
               }
               ccmsg = msg as CellClickMessage;
               this.askMoveTo(ccmsg.cell);
               return true;
            case msg is GameMapNoMovementMessage:
               if(!this.myTurn)
               {
                  return false;
               }
               this._isRequestingMovement = false;
               this.removePath();
               return true;
            case msg is EntityMovementCompleteMessage:
               emcmsg = msg as EntityMovementCompleteMessage;
               if(!this.myTurn)
               {
                  return true;
               }
               if(emcmsg.entity.id == CurrentPlayedFighterManager.getInstance().currentFighterId)
               {
                  this._isRequestingMovement = false;
                  spellCastFrame = Kernel.getWorker().getFrame(FightSpellCastFrame);
                  if(!spellCastFrame)
                  {
                     this.drawPath();
                  }
                  this.startRemindTurn();
                  if(this._finishingTurn)
                  {
                     this.finishTurn();
                  }
               }
               return true;
            case msg is GameFightTurnFinishAction:
               if(!this.myTurn)
               {
                  return false;
               }
               cfId = CurrentPlayedFighterManager.getInstance().currentFighterId;
               imE = DofusEntities.getEntity(cfId) as IMovable;
               if(!imE)
               {
                  return true;
               }
               if(imE.isMoving)
               {
                  this._finishingTurn = true;
               }
               else
               {
                  this.finishTurn();
               }
               return true;
            case msg is MapContainerRollOutMessage:
               this.removePath();
               return true;
            default:
               return false;
         }
      }
      
      public function pulled() : Boolean {
         if(this._remindTurnTimeoutId != 0)
         {
            clearTimeout(this._remindTurnTimeoutId);
         }
         Atouin.getInstance().cellOverEnabled = false;
         this.removePath();
         Kernel.getWorker().removeFrame(this._spellCastFrame);
         return true;
      }
      
      public function drawPath(cell:MapPoint = null) : void {
         var tackle:* = NaN;
         var mpLost:* = 0;
         var apLost:* = 0;
         var pe:PathElement = null;
         var s:Selection = null;
         var cursorSprite:Sprite = null;
         var textFormat:TextFormat = null;
         var effect:GlowFilter = null;
         if(this._isRequestingMovement)
         {
            return;
         }
         if(!cell)
         {
            if(FightContextFrame.currentCell == -1)
            {
               return;
            }
            cell = MapPoint.fromCellId(FightContextFrame.currentCell);
         }
         var playerEntity:IEntity = DofusEntities.getEntity(CurrentPlayedFighterManager.getInstance().currentFighterId);
         if(!playerEntity)
         {
            this.removePath();
            return;
         }
         var characteristics:CharacterCharacteristicsInformations = CurrentPlayedFighterManager.getInstance().getCharacteristicsInformations();
         var movementPoints:int = characteristics.movementPointsCurrent;
         var actionPoints:int = characteristics.actionPointsCurrent;
         if((IMovable(playerEntity).isMoving) || (playerEntity.position.distanceToCell(cell) > characteristics.movementPointsCurrent))
         {
            this.removePath();
            return;
         }
         var path:MovementPath = Pathfinding.findPath(DataMapProvider.getInstance(),playerEntity.position,cell,false,false,null,null,true);
         if((path.path.length == 0) || (path.path.length > characteristics.movementPointsCurrent))
         {
            this.removePath();
            return;
         }
         this._lastPath = path;
         this._cells = new Vector.<uint>();
         this._cellsUnreachable = new Vector.<uint>();
         var isFirst:Boolean = true;
         var mpCount:int = 0;
         var lastPe:PathElement = null;
         var entitiesFrame:FightEntitiesFrame = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
         var playerInfos:GameFightFighterInformations = entitiesFrame.getEntityInfos(playerEntity.id) as GameFightFighterInformations;
         for each(pe in path.path)
         {
            if(isFirst)
            {
               isFirst = false;
            }
            else
            {
               tackle = TackleUtil.getTackle(playerInfos,lastPe.step);
               mpLost = mpLost + int((movementPoints - mpCount) * (1 - tackle) + 0.5);
               if(mpLost < 0)
               {
                  mpLost = 0;
               }
               apLost = apLost + int(actionPoints * (1 - tackle) + 0.5);
               if(apLost < 0)
               {
                  apLost = 0;
               }
               movementPoints = characteristics.movementPointsCurrent - mpLost;
               actionPoints = characteristics.actionPointsCurrent - apLost;
               if(mpCount < movementPoints)
               {
                  this._cells.push(pe.step.cellId);
                  mpCount++;
               }
               else
               {
                  this._cellsUnreachable.push(pe.step.cellId);
               }
            }
            lastPe = pe;
         }
         tackle = TackleUtil.getTackle(playerInfos,lastPe.step);
         mpLost = mpLost + int((movementPoints - mpCount) * (1 - tackle) + 0.5);
         if(mpLost < 0)
         {
            mpLost = 0;
         }
         apLost = apLost + int(actionPoints * (1 - tackle) + 0.5);
         if(apLost < 0)
         {
            apLost = 0;
         }
         movementPoints = characteristics.movementPointsCurrent - mpLost;
         actionPoints = characteristics.actionPointsCurrent - apLost;
         if(mpCount < movementPoints)
         {
            this._cells.push(path.end.cellId);
         }
         else
         {
            this._cellsUnreachable.push(path.end.cellId);
         }
         if(this._movementSelection == null)
         {
            this._movementSelection = new Selection();
            this._movementSelection.renderer = new MovementZoneRenderer(Dofus.getInstance().options.showMovementDistance);
            this._movementSelection.color = PATH_COLOR;
            SelectionManager.getInstance().addSelection(this._movementSelection,SELECTION_PATH);
         }
         if(this._cellsUnreachable.length > 0)
         {
            if(this._movementSelectionUnreachable == null)
            {
               this._movementSelectionUnreachable = new Selection();
               this._movementSelectionUnreachable.renderer = new MovementZoneRenderer(Dofus.getInstance().options.showMovementDistance,movementPoints + 1);
               this._movementSelectionUnreachable.color = PATH_UNREACHABLE_COLOR;
               SelectionManager.getInstance().addSelection(this._movementSelectionUnreachable,SELECTION_PATH_UNREACHABLE);
            }
            this._movementSelectionUnreachable.zone = new Custom(this._cellsUnreachable);
            SelectionManager.getInstance().update(SELECTION_PATH_UNREACHABLE);
         }
         else
         {
            s = SelectionManager.getInstance().getSelection(SELECTION_PATH_UNREACHABLE);
            if(s)
            {
               s.remove();
               this._movementSelectionUnreachable = null;
            }
         }
         if((mpLost > 0) || (apLost > 0))
         {
            if(!this._cursorData)
            {
               cursorSprite = new Sprite();
               this._tfAP = new TextField();
               this._tfAP.selectable = false;
               textFormat = new TextFormat(FontManager.getInstance().getRealFontName("Verdana"),16,255,true);
               this._tfAP.defaultTextFormat = textFormat;
               this._tfAP.setTextFormat(textFormat);
               this._tfAP.text = "-" + apLost + " " + I18n.getUiText("ui.common.ap");
               if(EmbedFontManager.getInstance().isEmbed(textFormat.font))
               {
                  this._tfAP.embedFonts = true;
               }
               this._tfAP.width = this._tfAP.textWidth + 5;
               this._tfAP.height = this._tfAP.textHeight;
               cursorSprite.addChild(this._tfAP);
               this._tfMP = new TextField();
               this._tfMP.selectable = false;
               textFormat = new TextFormat(FontManager.getInstance().getRealFontName("Verdana"),16,26112,true);
               this._tfMP.defaultTextFormat = textFormat;
               this._tfMP.setTextFormat(textFormat);
               this._tfMP.text = "-" + mpLost + " " + I18n.getUiText("ui.common.mp");
               if(EmbedFontManager.getInstance().isEmbed(textFormat.font))
               {
                  this._tfMP.embedFonts = true;
               }
               this._tfMP.width = this._tfMP.textWidth + 5;
               this._tfMP.height = this._tfMP.textHeight;
               this._tfMP.y = this._tfAP.height;
               cursorSprite.addChild(this._tfMP);
               effect = new GlowFilter(16777215,1,4,4,3,1);
               cursorSprite.filters = [effect];
               this._cursorData = new LinkedCursorData();
               this._cursorData.sprite = cursorSprite;
               this._cursorData.sprite.cacheAsBitmap = true;
               this._cursorData.offset = new Point(14,14);
            }
            if(apLost > 0)
            {
               this._tfAP.text = "-" + apLost + " " + I18n.getUiText("ui.common.ap");
               this._tfAP.width = this._tfAP.textWidth + 5;
               this._tfAP.visible = true;
               this._tfMP.y = this._tfAP.height;
            }
            else
            {
               this._tfAP.visible = false;
               this._tfMP.y = 0;
            }
            if(mpLost > 0)
            {
               this._tfMP.text = "-" + mpLost + " " + I18n.getUiText("ui.common.mp");
               this._tfMP.width = this._tfMP.textWidth + 5;
               this._tfMP.visible = true;
            }
            else
            {
               this._tfMP.visible = false;
            }
            LinkedCursorSpriteManager.getInstance().addItem(TAKLED_CURSOR_NAME,this._cursorData,true);
         }
         else if(LinkedCursorSpriteManager.getInstance().getItem(TAKLED_CURSOR_NAME))
         {
            LinkedCursorSpriteManager.getInstance().removeItem(TAKLED_CURSOR_NAME);
         }
         
         this._movementSelection.zone = new Custom(this._cells);
         SelectionManager.getInstance().update(SELECTION_PATH,0,true);
      }
      
      public function updatePath() : void {
         this.drawPath(this._lastCell);
      }
      
      private function removePath() : void {
         var s:Selection = SelectionManager.getInstance().getSelection(SELECTION_PATH);
         if(s)
         {
            s.remove();
            this._movementSelection = null;
         }
         s = SelectionManager.getInstance().getSelection(SELECTION_PATH_UNREACHABLE);
         if(s)
         {
            s.remove();
            this._movementSelectionUnreachable = null;
         }
         if(LinkedCursorSpriteManager.getInstance().getItem(TAKLED_CURSOR_NAME))
         {
            LinkedCursorSpriteManager.getInstance().removeItem(TAKLED_CURSOR_NAME);
         }
      }
      
      private function askMoveTo(cell:MapPoint) : Boolean {
         var mpLost:* = 0;
         var pe:PathElement = null;
         if(this._isRequestingMovement)
         {
            return false;
         }
         this._isRequestingMovement = true;
         var playerEntity:IEntity = DofusEntities.getEntity(CurrentPlayedFighterManager.getInstance().currentFighterId);
         if(!playerEntity)
         {
            _log.warn("The player tried to move before its character was added to the scene. Aborting.");
            return this._isRequestingMovement = false;
         }
         if(IMovable(playerEntity).isMoving)
         {
            return this._isRequestingMovement = false;
         }
         var path:MovementPath = Pathfinding.findPath(DataMapProvider.getInstance(),playerEntity.position,cell,false,false,null,null,true);
         var characteristics:CharacterCharacteristicsInformations = CurrentPlayedFighterManager.getInstance().getCharacteristicsInformations();
         if((path.path.length == 0) || (path.path.length > characteristics.movementPointsCurrent))
         {
            return this._isRequestingMovement = false;
         }
         var entitiesFrame:FightEntitiesFrame = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
         var playerInfos:GameFightFighterInformations = entitiesFrame.getEntityInfos(playerEntity.id) as GameFightFighterInformations;
         var tackle:Number = TackleUtil.getTackle(playerInfos,playerEntity.position);
         var mpCount:int = 0;
         var lastPe:PathElement = null;
         var realMP:int = characteristics.movementPointsCurrent;
         this._cells = new Vector.<uint>();
         for each(pe in path.path)
         {
            if(lastPe)
            {
               tackle = TackleUtil.getTackle(playerInfos,lastPe.step);
               mpLost = mpLost + int((realMP - mpCount) * (1 - tackle) + 0.5);
               if(mpLost < 0)
               {
                  mpLost = 0;
               }
               realMP = characteristics.movementPointsCurrent - mpLost;
               if(mpCount < realMP)
               {
                  this._cells.push(pe.step.cellId);
                  mpCount++;
               }
               else
               {
                  this._cellsUnreachable.push(pe.step.cellId);
               }
            }
            lastPe = pe;
         }
         if(realMP < path.length)
         {
            path.end = path.getPointAtIndex(realMP).step;
            path.deletePoint(realMP,0);
         }
         var gmmrmsg:GameMapMovementRequestMessage = new GameMapMovementRequestMessage();
         gmmrmsg.initGameMapMovementRequestMessage(MapMovementAdapter.getServerMovement(path),PlayedCharacterManager.getInstance().currentMap.mapId);
         ConnectionsHandler.getConnection().send(gmmrmsg);
         this.removePath();
         return true;
      }
      
      private function finishTurn() : void {
         var gftfmsg:GameFightTurnFinishMessage = new GameFightTurnFinishMessage();
         ConnectionsHandler.getConnection().send(gftfmsg);
         this._finishingTurn = false;
      }
      
      private function startRemindTurn() : void {
         if(!this._myTurn)
         {
            return;
         }
         if((this._turnDuration > 0) && (Dofus.getInstance().options.remindTurn))
         {
            if(this._remindTurnTimeoutId != 0)
            {
               clearTimeout(this._remindTurnTimeoutId);
            }
            this._remindTurnTimeoutId = setTimeout(this.remindTurn,REMIND_TURN_DELAY);
         }
      }
      
      private function remindTurn() : void {
         var text:String = I18n.getUiText("ui.fight.inactivity");
         KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,text,ChatFrame.RED_CHANNEL_ID,TimeManager.getInstance().getTimestamp());
         KernelEventsManager.getInstance().processCallback(FightHookList.RemindTurn);
         clearTimeout(this._remindTurnTimeoutId);
         this._remindTurnTimeoutId = 0;
      }
   }
}
