package com.ankamagames.dofus.misc.utils
{
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import com.ankamagames.atouin.AtouinConstants;
   import com.ankamagames.dofus.types.entities.AnimatedCharacter;
   import flash.display.DisplayObjectContainer;
   import com.ankamagames.jerakine.sequencer.ISequencable;
   import com.ankamagames.jerakine.sequencer.CallbackStep;
   import com.ankamagames.jerakine.types.Callback;
   import com.ankamagames.dofus.logic.game.common.steps.CameraZoomStep;
   import com.ankamagames.dofus.logic.game.common.steps.CameraMoveStep;
   import com.ankamagames.dofus.scripts.ScriptEntity;
   import com.ankamagames.dofus.logic.game.common.steps.CameraFollowStep;
   import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
   import com.ankamagames.jerakine.utils.display.EnterFrameDispatcher;
   import com.ankamagames.atouin.Atouin;
   import com.ankamagames.atouin.managers.MapDisplayManager;
   import flash.events.Event;
   import flash.geom.Point;
   
   public class Camera extends Object
   {
      
      public function Camera(param1:Number=1) {
         super();
         this._zoom = param1;
         this._container = Atouin.getInstance().rootContainer;
      }
      
      private static const CENTER_X:Number = StageShareManager.startWidth / 2;
      
      private static const CENTER_Y:Number = (StageShareManager.startHeight - 163) / 2;
      
      private static const LASTCELL_X:Number = AtouinConstants.MAP_WIDTH * AtouinConstants.CELL_WIDTH;
      
      private static const LASTCELL_Y:Number = AtouinConstants.MAP_HEIGHT * AtouinConstants.CELL_HEIGHT;
      
      private static const MIN_SCALE:Number = 1;
      
      private static const OFFSCREEN_Y:Number = 16;
      
      private var _zoom:Number;
      
      private var _entityToFollow:AnimatedCharacter;
      
      private var _container:DisplayObjectContainer;
      
      private var _x:Number;
      
      private var _y:Number;
      
      public function get currentZoom() : Number {
         return this._zoom;
      }
      
      public function set currentZoom(param1:Number) : void {
         this._zoom = param1;
      }
      
      public function get x() : Number {
         return this._x;
      }
      
      public function get y() : Number {
         return this._y;
      }
      
      public function setZoom(param1:Number) : ISequencable {
         var pZoom:Number = param1;
         return new CallbackStep(new Callback(function(param1:Camera, param2:Number):void
         {
            param1.currentZoom = param2;
         },this,pZoom));
      }
      
      public function zoom(param1:Array) : ISequencable {
         var _loc2_:Array = param1;
         var _loc3_:* = true;
         if(_loc2_[_loc2_.length-1] is Boolean)
         {
            _loc3_ = _loc2_.pop();
         }
         return new CameraZoomStep(this,_loc2_,_loc3_);
      }
      
      public function moveTo(param1:Array) : ISequencable {
         var _loc2_:Array = param1;
         var _loc3_:* = true;
         if(_loc2_[_loc2_.length-1] is Boolean)
         {
            _loc3_ = _loc2_.pop();
         }
         return new CameraMoveStep(this,_loc2_,_loc3_);
      }
      
      public function follow(param1:ScriptEntity) : ISequencable {
         return new CameraFollowStep(this,DofusEntities.getEntity(param1.id) as AnimatedCharacter);
      }
      
      public function stop() : ISequencable {
         return new CallbackStep(new Callback(EnterFrameDispatcher.removeEventListener,this.onEnterFrame));
      }
      
      public function reset() : ISequencable {
         return new CallbackStep(new Callback(this.zoomOnPos,MIN_SCALE,0,0));
      }
      
      public function followEntity(param1:AnimatedCharacter) : void {
         this.stop().start();
         this._entityToFollow = param1;
         EnterFrameDispatcher.addEventListener(this.onEnterFrame,"Camera");
      }
      
      public function zoomOnPos(param1:Number, param2:Number, param3:Number) : void {
         var _loc4_:* = NaN;
         var _loc5_:* = NaN;
         if(param1 <= MIN_SCALE)
         {
            this._container.scaleX = MIN_SCALE;
            this._container.scaleY = MIN_SCALE;
            this._container.x = 0;
            this._container.y = 0;
            Atouin.getInstance().currentZoom = MIN_SCALE;
            MapDisplayManager.getInstance().cacheAsBitmapEnabled(true);
         }
         else
         {
            MapDisplayManager.getInstance().cacheAsBitmapEnabled(false);
            this._container.scaleX = param1;
            this._container.scaleY = param1;
            _loc4_ = -param2 * param1 + CENTER_X;
            _loc5_ = -param3 * param1 + CENTER_Y;
            if((LASTCELL_X - param2) * param1 < LASTCELL_X / 2)
            {
               _loc4_ = _loc4_ + (CENTER_X - (1262 - param2) * param1);
               if(_loc4_ < -param2 * param1)
               {
                  _loc4_ = -param2 * param1 + CENTER_X;
               }
            }
            else
            {
               if(param2 < CENTER_X / param1)
               {
                  _loc4_ = 0;
               }
            }
            if((LASTCELL_Y - param3) * param1 < LASTCELL_Y / 2)
            {
               _loc5_ = _loc5_ + (CENTER_Y - (876 - OFFSCREEN_Y - param3) * param1);
               if(_loc5_ < -param3 * param1)
               {
                  _loc5_ = -param3 * param1 + CENTER_Y;
               }
               _loc5_ = _loc5_ + OFFSCREEN_Y;
            }
            else
            {
               if(param3 < CENTER_Y / param1)
               {
                  _loc5_ = 0;
               }
            }
            this._container.x = _loc4_;
            this._container.y = _loc5_;
            Atouin.getInstance().currentZoom = param1;
         }
         this._x = param2;
         this._y = param3;
      }
      
      private function onEnterFrame(param1:Event) : void {
         var _loc2_:Point = this._entityToFollow.parent.localToGlobal(new Point(this._entityToFollow.x,this._entityToFollow.y));
         var _loc3_:Point = this._container.globalToLocal(_loc2_);
         if(this._zoom > MIN_SCALE)
         {
            this.zoomOnPos(this._zoom,_loc3_.x,_loc3_.y);
         }
      }
   }
}
