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
   import com.ankamagames.berilia.Berilia;
   import flash.display.DisplayObject;
   import com.ankamagames.dofus.logic.game.roleplay.frames.InfoEntitiesFrame;
   import com.ankamagames.berilia.types.data.LinkedCursorData;
   import com.ankamagames.berilia.managers.TooltipManager;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.berilia.managers.LinkedCursorSpriteManager;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.atouin.managers.MapDisplayManager;
   import com.ankamagames.jerakine.entities.messages.EntityClickMessage;
   import com.ankamagames.dofus.logic.game.roleplay.messages.InteractiveElementActivationMessage;
   import com.ankamagames.atouin.messages.AdjacentMapClickMessage;
   import com.ankamagames.atouin.messages.MapLoadedMessage;
   import com.ankamagames.atouin.messages.MapZoomMessage;
   import com.ankamagames.jerakine.types.enums.Priority;
   
   public class CameraControlFrame extends Object implements Frame
   {
      
      public function CameraControlFrame() {
         super();
      }
      
      private static const _log:Logger;
      
      private static const MIN_ZOOM:Number = 1;
      
      private static const CENTER_Y:Number;
      
      private var _container:Sprite;
      
      private var _containerLastX:Number;
      
      private var _containerLastY:Number;
      
      private var _mapZoomed:Boolean;
      
      private var _dragging:Boolean;
      
      private var _allowDrag:Boolean;
      
      private var _wasDragging:Boolean;
      
      private var _buttonDown:Boolean;
      
      public function pushed() : Boolean {
         this._container = Atouin.getInstance().rootContainer as Sprite;
         StageShareManager.stage.addEventListener(Event.DEACTIVATE,this.onMouseUp);
         StageShareManager.stage.addEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMove);
         StageShareManager.stage.addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
         StageShareManager.stage.addEventListener(MouseEvent.MOUSE_UP,this.onMouseUp);
         return true;
      }
      
      public function pulled() : Boolean {
         StageShareManager.stage.removeEventListener(Event.DEACTIVATE,this.onMouseUp);
         StageShareManager.stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMove);
         StageShareManager.stage.removeEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
         StageShareManager.stage.removeEventListener(MouseEvent.MOUSE_UP,this.onMouseUp);
         return true;
      }
      
      public function get dragging() : Boolean {
         return this._dragging;
      }
      
      private function onMouseMove(pEvent:MouseEvent) : void {
         var window:Rectangle = null;
         if((this._allowDrag) && (Atouin.getInstance().currentZoom > MIN_ZOOM) && (!this._dragging) && (this._buttonDown))
         {
            Mouse.hide();
            InteractiveCellManager.getInstance().setInteraction(false);
            window = new Rectangle();
            window.x = window.y = 0;
            window.width = -StageShareManager.startWidth * Atouin.getInstance().currentZoom + StageShareManager.startWidth;
            window.height = -StageShareManager.startHeight * Atouin.getInstance().currentZoom + CENTER_Y + (CENTER_Y - (874 - StageShareManager.startHeight) * Atouin.getInstance().currentZoom);
            Berilia.getInstance().getUi("banner").mouseChildren = false;
            this._container.startDrag(false,window);
            this._containerLastX = this._container.x;
            this._containerLastY = this._container.y;
            StageShareManager.stage.addEventListener(Event.ENTER_FRAME,this.updateElementsPositions);
            this._dragging = true;
         }
      }
      
      private function onMouseDown(pEvent:Event) : void {
         this._buttonDown = true;
         if((!(pEvent.target == StageShareManager.stage)) && (!this.isInWorld(pEvent.target as DisplayObject)))
         {
            this._allowDrag = false;
         }
      }
      
      private function onMouseUp(pEvent:Event) : void {
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
      
      private function isInWorld(pObj:DisplayObject) : Boolean {
         var p:DisplayObject = pObj.parent;
         while(p)
         {
            p = p.parent;
            if(p == this._container)
            {
               return true;
            }
         }
         return false;
      }
      
      private function updateElementsPositions(pEvent:Event) : void {
         var offSetX:* = NaN;
         var offSetY:* = NaN;
         var infoEntitiesFrame:InfoEntitiesFrame = null;
         var lcd:LinkedCursorData = null;
         if((!(this._container.x == this._containerLastX)) || (!(this._container.y == this._containerLastY)))
         {
            offSetX = this._container.x - this._containerLastX;
            offSetY = this._container.y - this._containerLastY;
            TooltipManager.updateAllPositions(offSetX,offSetY);
            infoEntitiesFrame = Kernel.getWorker().getFrame(InfoEntitiesFrame) as InfoEntitiesFrame;
            if(infoEntitiesFrame)
            {
               infoEntitiesFrame.updateAllTooltips();
            }
            lcd = LinkedCursorSpriteManager.getInstance().getItem("changeMapCursor");
            if(lcd)
            {
               lcd.sprite.x = lcd.sprite.x + offSetX;
               lcd.sprite.y = lcd.sprite.y + offSetY;
            }
            this._containerLastX = this._container.x;
            this._containerLastY = this._container.y;
         }
      }
      
      public function process(msg:Message) : Boolean {
         switch(true)
         {
            case msg is EntityClickMessage:
            case msg is InteractiveElementActivationMessage:
            case msg is AdjacentMapClickMessage:
               if(this._wasDragging)
               {
                  this._wasDragging = false;
                  return true;
               }
            case msg is MapLoadedMessage:
               this._allowDrag = this._mapZoomed = false;
               return false;
            case msg is MapZoomMessage:
               if((MapDisplayManager.getInstance().currentMapRendered) && (!this._dragging) && (!this._mapZoomed))
               {
                  this._allowDrag = this._mapZoomed = true;
               }
               return false;
            default:
               return false;
         }
      }
      
      public function get priority() : int {
         return Priority.ULTIMATE_HIGHEST_DEPTH_OF_DOOM;
      }
   }
}
