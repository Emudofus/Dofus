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
   import __AS3__.vec.Vector;
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
   import com.ankamagames.dofus.logic.game.fight.miscs.TackleUtil;
   import com.ankamagames.atouin.renderers.MovementZoneRenderer;
   import com.ankamagames.jerakine.entities.interfaces.*;
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
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(FightTurnFrame));
      
      public static const SELECTION_PATH:String = "FightMovementPath";
      
      public static const SELECTION_PATH_UNREACHABLE:String = "FightMovementPathUnreachable";
      
      private static const PATH_COLOR:Color = new Color(26112);
      
      private static const PATH_UNREACHABLE_COLOR:Color = new Color(6684672);
      
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
      
      public function set myTurn(param1:Boolean) : void {
         var _loc5_:FightContextFrame = null;
         var _loc6_:IEntity = null;
         var _loc2_:* = !(param1 == this._myTurn);
         var _loc3_:* = !this._myTurn;
         this._myTurn = param1;
         if(param1)
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
         var _loc4_:FightSpellCastFrame = Kernel.getWorker().getFrame(FightSpellCastFrame) as FightSpellCastFrame;
         if(_loc4_)
         {
            if(_loc3_)
            {
               _loc4_.drawRange();
            }
            if(_loc2_)
            {
               if(_loc4_)
               {
                  _loc5_ = Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame;
                  if(_loc5_.timelineOverEntityId)
                  {
                     _loc6_ = DofusEntities.getEntity(_loc5_.timelineOverEntityId);
                     if(_loc6_)
                     {
                        FightContextFrame.currentCell = _loc6_.position.cellId;
                     }
                  }
                  _loc4_.refreshTarget(true);
               }
            }
         }
         if((this._myTurn) && !_loc4_)
         {
            this.drawPath();
         }
      }
      
      public function set turnDuration(param1:uint) : void {
         this._turnDuration = param1;
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
      
      public function process(param1:Message) : Boolean {
         var _loc2_:CellOverMessage = null;
         var _loc3_:GameFightSpellCastAction = null;
         var _loc4_:* = 0;
         var _loc5_:GameFightFighterInformations = null;
         var _loc6_:CellClickMessage = null;
         var _loc7_:EntityMovementCompleteMessage = null;
         var _loc8_:* = 0;
         var _loc9_:IMovable = null;
         var _loc10_:Frame = null;
         switch(true)
         {
            case param1 is CellOverMessage:
               if(!this.myTurn)
               {
                  return false;
               }
               if(Kernel.getWorker().getFrame(FightSpellCastFrame) != null)
               {
                  return false;
               }
               _loc2_ = param1 as CellOverMessage;
               this.drawPath(_loc2_.cell);
               this._lastCell = _loc2_.cell;
               return false;
            case param1 is GameFightSpellCastAction:
               _loc3_ = param1 as GameFightSpellCastAction;
               if(this._spellCastFrame != null)
               {
                  Kernel.getWorker().removeFrame(this._spellCastFrame);
               }
               this.removePath();
               if(this._myTurn)
               {
                  this.startRemindTurn();
               }
               _loc4_ = CurrentPlayedFighterManager.getInstance().currentFighterId;
               _loc5_ = FightEntitiesFrame.getCurrentInstance().getEntityInfos(_loc4_) as GameFightFighterInformations;
               if((_loc5_) && (_loc5_.alive))
               {
                  Kernel.getWorker().addFrame(this._spellCastFrame = new FightSpellCastFrame(_loc3_.spellId));
               }
               return true;
            case param1 is CellClickMessage:
               if(!this.myTurn)
               {
                  return false;
               }
               _loc6_ = param1 as CellClickMessage;
               this.askMoveTo(_loc6_.cell);
               return true;
            case param1 is GameMapNoMovementMessage:
               if(!this.myTurn)
               {
                  return false;
               }
               this._isRequestingMovement = false;
               this.removePath();
               return true;
            case param1 is EntityMovementCompleteMessage:
               _loc7_ = param1 as EntityMovementCompleteMessage;
               if(!this.myTurn)
               {
                  return true;
               }
               if(_loc7_.entity.id == CurrentPlayedFighterManager.getInstance().currentFighterId)
               {
                  this._isRequestingMovement = false;
                  _loc10_ = Kernel.getWorker().getFrame(FightSpellCastFrame);
                  if(!_loc10_)
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
            case param1 is GameFightTurnFinishAction:
               if(!this.myTurn)
               {
                  return false;
               }
               _loc8_ = CurrentPlayedFighterManager.getInstance().currentFighterId;
               _loc9_ = DofusEntities.getEntity(_loc8_) as IMovable;
               if(!_loc9_)
               {
                  return true;
               }
               if(_loc9_.isMoving)
               {
                  this._finishingTurn = true;
               }
               else
               {
                  this.finishTurn();
               }
               return true;
            case param1 is MapContainerRollOutMessage:
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
      
      public function drawPath(param1:MapPoint=null) : void {
         var _loc3_:* = NaN;
         var _loc5_:* = 0;
         var _loc6_:* = 0;
         var _loc15_:PathElement = null;
         var _loc16_:Selection = null;
         var _loc17_:Sprite = null;
         var _loc18_:TextFormat = null;
         var _loc19_:GlowFilter = null;
         if(this._isRequestingMovement)
         {
            return;
         }
         if(!param1)
         {
            if(FightContextFrame.currentCell == -1)
            {
               return;
            }
            param1 = MapPoint.fromCellId(FightContextFrame.currentCell);
         }
         var _loc2_:IEntity = DofusEntities.getEntity(CurrentPlayedFighterManager.getInstance().currentFighterId);
         if(!_loc2_)
         {
            this.removePath();
            return;
         }
         var _loc4_:CharacterCharacteristicsInformations = CurrentPlayedFighterManager.getInstance().getCharacteristicsInformations();
         var _loc7_:int = _loc4_.movementPointsCurrent;
         var _loc8_:int = _loc4_.actionPointsCurrent;
         if((IMovable(_loc2_).isMoving) || _loc2_.position.distanceToCell(param1) > _loc4_.movementPointsCurrent)
         {
            this.removePath();
            return;
         }
         var _loc9_:MovementPath = Pathfinding.findPath(DataMapProvider.getInstance(),_loc2_.position,param1,false,false,null,null,true);
         if(_loc9_.path.length == 0 || _loc9_.path.length > _loc4_.movementPointsCurrent)
         {
            this.removePath();
            return;
         }
         this._lastPath = _loc9_;
         this._cells = new Vector.<uint>();
         this._cellsUnreachable = new Vector.<uint>();
         var _loc10_:* = true;
         var _loc11_:* = 0;
         var _loc12_:PathElement = null;
         var _loc13_:FightEntitiesFrame = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
         var _loc14_:GameFightFighterInformations = _loc13_.getEntityInfos(_loc2_.id) as GameFightFighterInformations;
         for each (_loc15_ in _loc9_.path)
         {
            if(_loc10_)
            {
               _loc10_ = false;
            }
            else
            {
               _loc3_ = TackleUtil.getTackle(_loc14_,_loc12_.step);
               _loc5_ = _loc5_ + int((_loc7_ - _loc11_) * (1 - _loc3_) + 0.5);
               if(_loc5_ < 0)
               {
                  _loc5_ = 0;
               }
               _loc6_ = _loc6_ + int(_loc8_ * (1 - _loc3_) + 0.5);
               if(_loc6_ < 0)
               {
                  _loc6_ = 0;
               }
               _loc7_ = _loc4_.movementPointsCurrent - _loc5_;
               _loc8_ = _loc4_.actionPointsCurrent - _loc6_;
               if(_loc11_ < _loc7_)
               {
                  this._cells.push(_loc15_.step.cellId);
                  _loc11_++;
               }
               else
               {
                  this._cellsUnreachable.push(_loc15_.step.cellId);
               }
            }
            _loc12_ = _loc15_;
         }
         _loc3_ = TackleUtil.getTackle(_loc14_,_loc12_.step);
         _loc5_ = _loc5_ + int((_loc7_ - _loc11_) * (1 - _loc3_) + 0.5);
         if(_loc5_ < 0)
         {
            _loc5_ = 0;
         }
         _loc6_ = _loc6_ + int(_loc8_ * (1 - _loc3_) + 0.5);
         if(_loc6_ < 0)
         {
            _loc6_ = 0;
         }
         _loc7_ = _loc4_.movementPointsCurrent - _loc5_;
         _loc8_ = _loc4_.actionPointsCurrent - _loc6_;
         if(_loc11_ < _loc7_)
         {
            this._cells.push(_loc9_.end.cellId);
         }
         else
         {
            this._cellsUnreachable.push(_loc9_.end.cellId);
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
               this._movementSelectionUnreachable.renderer = new MovementZoneRenderer(Dofus.getInstance().options.showMovementDistance,_loc7_ + 1);
               this._movementSelectionUnreachable.color = PATH_UNREACHABLE_COLOR;
               SelectionManager.getInstance().addSelection(this._movementSelectionUnreachable,SELECTION_PATH_UNREACHABLE);
            }
            this._movementSelectionUnreachable.zone = new Custom(this._cellsUnreachable);
            SelectionManager.getInstance().update(SELECTION_PATH_UNREACHABLE);
         }
         else
         {
            _loc16_ = SelectionManager.getInstance().getSelection(SELECTION_PATH_UNREACHABLE);
            if(_loc16_)
            {
               _loc16_.remove();
               this._movementSelectionUnreachable = null;
            }
         }
         if(_loc5_ > 0 || _loc6_ > 0)
         {
            if(!this._cursorData)
            {
               _loc17_ = new Sprite();
               this._tfAP = new TextField();
               this._tfAP.selectable = false;
               _loc18_ = new TextFormat(FontManager.getInstance().getRealFontName("Verdana"),16,255,true);
               this._tfAP.defaultTextFormat = _loc18_;
               this._tfAP.setTextFormat(_loc18_);
               this._tfAP.text = "-" + _loc6_ + " " + I18n.getUiText("ui.common.ap");
               if(EmbedFontManager.getInstance().isEmbed(_loc18_.font))
               {
                  this._tfAP.embedFonts = true;
               }
               this._tfAP.width = this._tfAP.textWidth + 5;
               this._tfAP.height = this._tfAP.textHeight;
               _loc17_.addChild(this._tfAP);
               this._tfMP = new TextField();
               this._tfMP.selectable = false;
               _loc18_ = new TextFormat(FontManager.getInstance().getRealFontName("Verdana"),16,26112,true);
               this._tfMP.defaultTextFormat = _loc18_;
               this._tfMP.setTextFormat(_loc18_);
               this._tfMP.text = "-" + _loc5_ + " " + I18n.getUiText("ui.common.mp");
               if(EmbedFontManager.getInstance().isEmbed(_loc18_.font))
               {
                  this._tfMP.embedFonts = true;
               }
               this._tfMP.width = this._tfMP.textWidth + 5;
               this._tfMP.height = this._tfMP.textHeight;
               this._tfMP.y = this._tfAP.height;
               _loc17_.addChild(this._tfMP);
               _loc19_ = new GlowFilter(16777215,1,4,4,3,1);
               _loc17_.filters = [_loc19_];
               this._cursorData = new LinkedCursorData();
               this._cursorData.sprite = _loc17_;
               this._cursorData.sprite.cacheAsBitmap = true;
               this._cursorData.offset = new Point(14,14);
            }
            if(_loc6_ > 0)
            {
               this._tfAP.text = "-" + _loc6_ + " " + I18n.getUiText("ui.common.ap");
               this._tfAP.width = this._tfAP.textWidth + 5;
               this._tfAP.visible = true;
               this._tfMP.y = this._tfAP.height;
            }
            else
            {
               this._tfAP.visible = false;
               this._tfMP.y = 0;
            }
            if(_loc5_ > 0)
            {
               this._tfMP.text = "-" + _loc5_ + " " + I18n.getUiText("ui.common.mp");
               this._tfMP.width = this._tfMP.textWidth + 5;
               this._tfMP.visible = true;
            }
            else
            {
               this._tfMP.visible = false;
            }
            LinkedCursorSpriteManager.getInstance().addItem(TAKLED_CURSOR_NAME,this._cursorData,true);
         }
         else
         {
            if(LinkedCursorSpriteManager.getInstance().getItem(TAKLED_CURSOR_NAME))
            {
               LinkedCursorSpriteManager.getInstance().removeItem(TAKLED_CURSOR_NAME);
            }
         }
         this._movementSelection.zone = new Custom(this._cells);
         SelectionManager.getInstance().update(SELECTION_PATH,0,true);
      }
      
      public function updatePath() : void {
         this.drawPath(this._lastCell);
      }
      
      private function removePath() : void {
         var _loc1_:Selection = SelectionManager.getInstance().getSelection(SELECTION_PATH);
         if(_loc1_)
         {
            _loc1_.remove();
            this._movementSelection = null;
         }
         _loc1_ = SelectionManager.getInstance().getSelection(SELECTION_PATH_UNREACHABLE);
         if(_loc1_)
         {
            _loc1_.remove();
            this._movementSelectionUnreachable = null;
         }
         if(LinkedCursorSpriteManager.getInstance().getItem(TAKLED_CURSOR_NAME))
         {
            LinkedCursorSpriteManager.getInstance().removeItem(TAKLED_CURSOR_NAME);
         }
      }
      
      private function askMoveTo(param1:MapPoint) : Boolean {
         var _loc8_:* = 0;
         var _loc12_:PathElement = null;
         if(this._isRequestingMovement)
         {
            return false;
         }
         this._isRequestingMovement = true;
         var _loc2_:IEntity = DofusEntities.getEntity(CurrentPlayedFighterManager.getInstance().currentFighterId);
         if(!_loc2_)
         {
            _log.warn("The player tried to move before its character was added to the scene. Aborting.");
            return this._isRequestingMovement = false;
         }
         if(IMovable(_loc2_).isMoving)
         {
            return this._isRequestingMovement = false;
         }
         var _loc3_:MovementPath = Pathfinding.findPath(DataMapProvider.getInstance(),_loc2_.position,param1,false,false,null,null,true);
         var _loc4_:CharacterCharacteristicsInformations = CurrentPlayedFighterManager.getInstance().getCharacteristicsInformations();
         if(_loc3_.path.length == 0 || _loc3_.path.length > _loc4_.movementPointsCurrent)
         {
            return this._isRequestingMovement = false;
         }
         var _loc5_:FightEntitiesFrame = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
         var _loc6_:GameFightFighterInformations = _loc5_.getEntityInfos(_loc2_.id) as GameFightFighterInformations;
         var _loc7_:Number = TackleUtil.getTackle(_loc6_,_loc2_.position);
         var _loc9_:* = 0;
         var _loc10_:PathElement = null;
         var _loc11_:int = _loc4_.movementPointsCurrent;
         this._cells = new Vector.<uint>();
         for each (_loc12_ in _loc3_.path)
         {
            if(_loc10_)
            {
               _loc7_ = TackleUtil.getTackle(_loc6_,_loc10_.step);
               _loc8_ = _loc8_ + int((_loc11_ - _loc9_) * (1 - _loc7_) + 0.5);
               if(_loc8_ < 0)
               {
                  _loc8_ = 0;
               }
               _loc11_ = _loc4_.movementPointsCurrent - _loc8_;
               if(_loc9_ < _loc11_)
               {
                  this._cells.push(_loc12_.step.cellId);
                  _loc9_++;
               }
               else
               {
                  this._cellsUnreachable.push(_loc12_.step.cellId);
               }
            }
            _loc10_ = _loc12_;
         }
         if(_loc11_ < _loc3_.length)
         {
            _loc3_.end = _loc3_.getPointAtIndex(_loc11_).step;
            _loc3_.deletePoint(_loc11_,0);
         }
         var _loc13_:GameMapMovementRequestMessage = new GameMapMovementRequestMessage();
         _loc13_.initGameMapMovementRequestMessage(MapMovementAdapter.getServerMovement(_loc3_),PlayedCharacterManager.getInstance().currentMap.mapId);
         ConnectionsHandler.getConnection().send(_loc13_);
         this.removePath();
         return true;
      }
      
      private function finishTurn() : void {
         var _loc1_:GameFightTurnFinishMessage = new GameFightTurnFinishMessage();
         ConnectionsHandler.getConnection().send(_loc1_);
         this._finishingTurn = false;
      }
      
      private function startRemindTurn() : void {
         if(!this._myTurn)
         {
            return;
         }
         if(this._turnDuration > 0 && (Dofus.getInstance().options.remindTurn))
         {
            if(this._remindTurnTimeoutId != 0)
            {
               clearTimeout(this._remindTurnTimeoutId);
            }
            this._remindTurnTimeoutId = setTimeout(this.remindTurn,REMIND_TURN_DELAY);
         }
      }
      
      private function remindTurn() : void {
         var _loc1_:String = I18n.getUiText("ui.fight.inactivity");
         KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,_loc1_,ChatFrame.RED_CHANNEL_ID,TimeManager.getInstance().getTimestamp());
         KernelEventsManager.getInstance().processCallback(FightHookList.RemindTurn);
         clearTimeout(this._remindTurnTimeoutId);
         this._remindTurnTimeoutId = 0;
      }
   }
}
