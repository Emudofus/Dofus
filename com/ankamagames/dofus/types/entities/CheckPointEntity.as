package com.ankamagames.dofus.types.entities
{
   import flash.display.Sprite;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import com.ankamagames.jerakine.entities.interfaces.IDisplayable;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.jerakine.entities.behaviours.IDisplayBehavior;
   import com.ankamagames.jerakine.interfaces.IRectangle;
   
   public class CheckPointEntity extends Sprite implements IEntity, IDisplayable
   {
      
      public function CheckPointEntity(param1:Sprite=null, param2:MapPoint=null) {
         super();
         this._position = param2;
         if(param1 != null)
         {
            this._displayedObject = param1;
            addChild(this._displayedObject);
         }
      }
      
      private var _id:int;
      
      private var _position:MapPoint;
      
      private var _displayed:Boolean;
      
      private var _displayedObject:Sprite;
      
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
      
      public function get displayBehaviors() : IDisplayBehavior {
         return null;
      }
      
      public function set displayBehaviors(param1:IDisplayBehavior) : void {
      }
      
      public function get absoluteBounds() : IRectangle {
         return null;
      }
      
      public function get displayed() : Boolean {
         return this._displayed;
      }
      
      public function display(param1:uint=0) : void {
         this._displayed = true;
      }
      
      public function remove() : void {
         if(this._displayedObject != null)
         {
            removeChild(this._displayedObject);
            this._displayedObject = null;
         }
         this._displayed = false;
      }
   }
}
