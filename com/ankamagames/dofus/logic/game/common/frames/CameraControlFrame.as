package com.ankamagames.dofus.logic.game.common.frames
{
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import flash.display.Sprite;
   import com.ankamagames.atouin.Atouin;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.ui.Mouse;
   import com.ankamagames.atouin.managers.InteractiveCellManager;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.berilia.Berilia;
   import flash.display.DisplayObject;
   import com.ankamagames.dofus.logic.game.roleplay.frames.InfoEntitiesFrame;
   import com.ankamagames.berilia.types.data.LinkedCursorData;
   import com.ankamagames.dofus.logic.game.fight.frames.FightPreparationFrame;
   import com.ankamagames.berilia.managers.TooltipManager;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.berilia.managers.LinkedCursorSpriteManager;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.atouin.managers.MapDisplayManager;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.jerakine.entities.messages.EntityClickMessage;
   import com.ankamagames.dofus.logic.game.roleplay.messages.InteractiveElementActivationMessage;
   import com.ankamagames.atouin.messages.AdjacentMapClickMessage;
   import com.ankamagames.atouin.messages.MapLoadedMessage;
   import com.ankamagames.atouin.messages.MapZoomMessage;
   import com.ankamagames.jerakine.types.enums.Priority;
   
   public class CameraControlFrame extends Object implements Frame
   {
      
      public function CameraControlFrame()
      {
         super();
      }
      
      private static const _log:Logger = Log.getLogger(getQualifiedClassName(CameraControlFrame));
      
      private static const MIN_ZOOM:Number = 1;
      
      private static const CENTER_Y:Number = (StageShareManager.startHeight - 163) / 2;
      
      private var _container:Sprite;
      
      private var _containerLastX:Number;
      
      private var _containerLastY:Number;
      
      private var _mapZoomed:Boolean;
      
      private var _dragging:Boolean;
      
      private var _allowDrag:Boolean;
      
      private var _wasDragging:Boolean;
      
      private var _buttonDown:Boolean;
      
      public function pushed() : Boolean
      {
         this._container = Atouin.getInstance().rootContainer as Sprite;
         StageShareManager.stage.addEventListener(Event.DEACTIVATE,this.onMouseUp);
         StageShareManager.stage.addEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMove);
         StageShareManager.stage.addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
         StageShareManager.stage.addEventListener(MouseEvent.MOUSE_UP,this.onMouseUp);
         return true;
      }
      
      public function pulled() : Boolean
      {
         StageShareManager.stage.removeEventListener(Event.DEACTIVATE,this.onMouseUp);
         StageShareManager.stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMove);
         StageShareManager.stage.removeEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
         StageShareManager.stage.removeEventListener(MouseEvent.MOUSE_UP,this.onMouseUp);
         return true;
      }
      
      public function get dragging() : Boolean
      {
         return this._dragging;
      }
      
      private function onMouseMove(param1:MouseEvent) : void
      {
         var _loc2_:Rectangle = null;
         if((this._allowDrag) && Atouin.getInstance().currentZoom > MIN_ZOOM && !this._dragging && (this._buttonDown))
         {
            Mouse.hide();
            InteractiveCellManager.getInstance().setInteraction(false);
            KernelEventsManager.getInstance().processCallback(HookList.CloseContextMenu);
            _loc2_ = new Rectangle();
            _loc2_.x = _loc2_.y = 0;
            _loc2_.width = -StageShareManager.startWidth * Atouin.getInstance().currentZoom + StageShareManager.startWidth;
            _loc2_.height = -StageShareManager.startHeight * Atouin.getInstance().currentZoom + CENTER_Y + (CENTER_Y - (874 - StageShareManager.startHeight) * Atouin.getInstance().currentZoom);
            Berilia.getInstance().getUi("banner").mouseChildren = false;
            this._container.startDrag(false,_loc2_);
            this._containerLastX = this._container.x;
            this._containerLastY = this._container.y;
            StageShareManager.stage.addEventListener(Event.ENTER_FRAME,this.updateElementsPositions);
            this._dragging = true;
         }
      }
      
      private function onMouseDown(param1:Event) : void
      {
         this._buttonDown = true;
         if(!(param1.target == StageShareManager.stage) && !this.isInWorld(param1.target as DisplayObject))
         {
            this._allowDrag = false;
         }
      }
      
      private function onMouseUp(param1:Event) : void
      {
         this._buttonDown = false;
         if(this._dragging)
         {
            this._container.stopDrag();
            StageShareManager.stage.removeEventListener(Event.ENTER_FRAME,this.updateElementsPositions);
            Mouse.show();
            Berilia.getInstance().getUi("banner").mouseChildren = true;
            this._dragging = false;
            InteractiveCellManager.getInstance().setInteraction(true);
            this._wasDragging = true;
         }
         else
         {
            this._wasDragging = false;
         }
         this._allowDrag = this._mapZoomed;
      }
      
      private function isInWorld(param1:DisplayObject) : Boolean
      {
         var _loc2_:DisplayObject = param1.parent;
         while(_loc2_)
         {
            _loc2_ = _loc2_.parent;
            if(_loc2_ == this._container)
            {
               return true;
            }
         }
         return false;
      }
      
      private function updateElementsPositions(param1:Event) : void
      {
         var _loc2_:* = NaN;
         var _loc3_:* = NaN;
         var _loc4_:InfoEntitiesFrame = null;
         var _loc5_:LinkedCursorData = null;
         var _loc6_:FightPreparationFrame = null;
         if(!(this._container.x == this._containerLastX) || !(this._container.y == this._containerLastY))
         {
            _loc2_ = this._container.x - this._containerLastX;
            _loc3_ = this._container.y - this._containerLastY;
            TooltipManager.updateAllPositions(_loc2_,_loc3_);
            _loc4_ = Kernel.getWorker().getFrame(InfoEntitiesFrame) as InfoEntitiesFrame;
            if(_loc4_)
            {
               _loc4_.updateAllTooltips();
            }
            _loc5_ = LinkedCursorSpriteManager.getInstance().getItem("changeMapCursor");
            if(_loc5_)
            {
               _loc5_.sprite.x = _loc5_.sprite.x + _loc2_;
               _loc5_.sprite.y = _loc5_.sprite.y + _loc3_;
            }
            _loc6_ = Kernel.getWorker().getFrame(FightPreparationFrame) as FightPreparationFrame;
            if(_loc6_)
            {
               _loc6_.updateSwapPositionRequestsIcons();
            }
            this._containerLastX = this._container.x;
            this._containerLastY = this._container.y;
         }
      }
      
      public function process(param1:Message) : Boolean
      {
         var _loc2_:* = false;
         switch(true)
         {
            case param1 is EntityClickMessage:
            case param1 is InteractiveElementActivationMessage:
            case param1 is AdjacentMapClickMessage:
               if(this._wasDragging)
               {
                  this._wasDragging = false;
                  return true;
               }
               break;
            case param1 is MapLoadedMessage:
               this._allowDrag = this._mapZoomed = false;
               return false;
            case param1 is MapZoomMessage:
               if((MapDisplayManager.getInstance().currentMapRendered) && !this._dragging && !this._mapZoomed)
               {
                  this._allowDrag = this._mapZoomed = true;
               }
               _loc2_ = PlayedCharacterManager.getInstance().isFighting;
               return _loc2_;
         }
         return false;
      }
      
      public function get priority() : int
      {
         return Priority.ULTIMATE_HIGHEST_DEPTH_OF_DOOM;
      }
   }
}
