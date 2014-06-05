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
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.entities.messages.EntityClickMessage;
   import com.ankamagames.dofus.logic.game.roleplay.messages.InteractiveElementActivationMessage;
   import com.ankamagames.atouin.messages.AdjacentMapClickMessage;
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
      
      private var _dragging:Boolean;
      
      private var _allowDrag:Boolean;
      
      private var _wasDragging:Boolean;
      
      private var _buttonDown:Boolean;
      
      public function pushed() : Boolean {
         this._container = Atouin.getInstance().rootContainer as Sprite;
         this._allowDrag = true;
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
            Mouse.show();
            Berilia.getInstance().getUi("banner").mouseChildren = true;
            this._dragging = false;
            InteractiveCellManager.getInstance().setInteraction(true);
            this._wasDragging = true;
         }
         this._allowDrag = true;
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
               break;
         }
         return false;
      }
      
      public function get priority() : int {
         return Priority.ULTIMATE_HIGHEST_DEPTH_OF_DOOM;
      }
   }
}
