package com.ankamagames.dofus.types.entities
{
   import com.ankamagames.tiphon.display.TiphonSprite;
   import com.ankamagames.jerakine.entities.interfaces.IDisplayable;
   import com.ankamagames.jerakine.entities.interfaces.IMovable;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.jerakine.entities.behaviours.IDisplayBehavior;
   import com.ankamagames.jerakine.entities.behaviours.IMovementBehavior;
   import com.ankamagames.jerakine.interfaces.IRectangle;
   import com.ankamagames.atouin.entities.behaviours.display.AtouinDisplayBehavior;
   import com.ankamagames.atouin.entities.behaviours.movements.ParableMovementBehavior;
   import com.ankamagames.jerakine.types.enums.DirectionsEnum;
   import flash.events.Event;
   import com.ankamagames.jerakine.types.positions.MovementPath;
   import com.ankamagames.tiphon.types.look.TiphonEntityLook;
   
   public class Projectile extends TiphonSprite implements IDisplayable, IMovable, IEntity
   {
      
      public function Projectile(param1:int, param2:TiphonEntityLook, param3:Boolean=false, param4:Boolean=true) {
         super(param2);
         this.startPlayingOnlyWhenDisplayed = param4;
         this.id = param1;
         if(!param3)
         {
            this.init();
         }
         mouseChildren = false;
         mouseEnabled = false;
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(Projectile));
      
      private var _id:int;
      
      private var _position:MapPoint;
      
      private var _displayed:Boolean;
      
      private var _displayBehavior:IDisplayBehavior;
      
      private var _movementBehavior:IMovementBehavior;
      
      public function get displayBehaviors() : IDisplayBehavior {
         return this._displayBehavior;
      }
      
      public function set displayBehaviors(param1:IDisplayBehavior) : void {
         this._displayBehavior = param1;
      }
      
      public function get movementBehavior() : IMovementBehavior {
         return this._movementBehavior;
      }
      
      public function set movementBehavior(param1:IMovementBehavior) : void {
         this._movementBehavior = param1;
      }
      
      public function get id() : int {
         return this._id;
      }
      
      public function set id(param1:int) : void {
         this._id = param1;
      }
      
      public function get position() : MapPoint {
         return this._position;
      }
      
      public function set position(param1:MapPoint) : void {
         this._position = param1;
      }
      
      public function get isMoving() : Boolean {
         return this._movementBehavior.isMoving(this);
      }
      
      public function get absoluteBounds() : IRectangle {
         return this._displayBehavior.getAbsoluteBounds(this);
      }
      
      public function get displayed() : Boolean {
         return this._displayed;
      }
      
      public var startPlayingOnlyWhenDisplayed:Boolean;
      
      public function init(param1:int=-1) : void {
         this._displayBehavior = AtouinDisplayBehavior.getInstance();
         this._movementBehavior = ParableMovementBehavior.getInstance();
         setDirection(param1 == -1?DirectionsEnum.RIGHT:param1);
         if(!this.startPlayingOnlyWhenDisplayed || (parent))
         {
            this.setAnim();
         }
         else
         {
            addEventListener(Event.ADDED_TO_STAGE,this.onProjectileAdded);
         }
      }
      
      public function display(param1:uint=0) : void {
         this._displayBehavior.display(this,param1);
         this._displayed = true;
      }
      
      public function remove() : void {
         this._displayed = false;
         this._displayBehavior.remove(this);
         clearAnimation();
      }
      
      override public function destroy() : void {
         this.remove();
         super.destroy();
      }
      
      public function move(param1:MovementPath, param2:Function=null) : void {
         this._movementBehavior.move(this,param1,param2);
      }
      
      public function jump(param1:MapPoint) : void {
         this._movementBehavior.jump(this,param1);
      }
      
      public function stop(param1:Boolean=false) : void {
         this._movementBehavior.stop(this);
      }
      
      private function setAnim() : void {
         setAnimation("FX");
      }
      
      private function onProjectileAdded(param1:Event) : void {
         removeEventListener(Event.ADDED_TO_STAGE,this.onProjectileAdded);
         this.setAnim();
      }
   }
}
