package com.ankamagames.dofus.types.entities
{
   import flash.display.Sprite;
   import com.ankamagames.jerakine.entities.interfaces.IInteractive;
   import com.ankamagames.jerakine.entities.interfaces.IDisplayable;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.jerakine.entities.behaviours.IDisplayBehavior;
   import com.ankamagames.jerakine.interfaces.IRectangle;
   import com.ankamagames.jerakine.messages.MessageHandler;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.jerakine.types.enums.InteractionsEnum;
   import com.ankamagames.atouin.entities.behaviours.display.AtouinDisplayBehavior;
   import com.ankamagames.atouin.managers.EntitiesManager;
   
   public class RoleplayObjectEntity extends Sprite implements IInteractive, IDisplayable
   {
      
      public function RoleplayObjectEntity(pId:int, pPosition:MapPoint) {
         super();
         this._displayBehavior = AtouinDisplayBehavior.getInstance();
         this.id = EntitiesManager.getInstance().getFreeEntityId();
         this.position = pPosition;
         mouseChildren = false;
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(RoleplayObjectEntity));
      
      private var _id:int;
      
      private var _position:MapPoint;
      
      private var _displayed:Boolean;
      
      protected var _displayBehavior:IDisplayBehavior;
      
      public function get id() : int {
         return this._id;
      }
      
      public function set id(nValue:int) : void {
         this._id = nValue;
      }
      
      public function get position() : MapPoint {
         return this._position;
      }
      
      public function set position(oValue:MapPoint) : void {
         this._position = oValue;
      }
      
      public function get displayed() : Boolean {
         return this._displayed;
      }
      
      public function get displayBehaviors() : IDisplayBehavior {
         return this._displayBehavior;
      }
      
      public function set displayBehaviors(oValue:IDisplayBehavior) : void {
         this._displayBehavior = oValue;
      }
      
      public function get absoluteBounds() : IRectangle {
         return this._displayBehavior.getAbsoluteBounds(this);
      }
      
      public function get handler() : MessageHandler {
         return Kernel.getWorker();
      }
      
      override public function get useHandCursor() : Boolean {
         return true;
      }
      
      public function get enabledInteractions() : uint {
         return InteractionsEnum.CLICK | InteractionsEnum.OUT | InteractionsEnum.OVER;
      }
      
      public function display(strata:uint=10) : void {
         this._displayBehavior.display(this,strata);
         this._displayed = true;
      }
      
      public function remove() : void {
         this._displayed = false;
         this._displayBehavior.remove(this);
      }
   }
}
