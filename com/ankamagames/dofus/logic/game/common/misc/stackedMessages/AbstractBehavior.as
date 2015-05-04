package com.ankamagames.dofus.logic.game.common.misc.stackedMessages
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.dofus.types.enums.StackActionEnum;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import flash.display.Sprite;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.utils.errors.AbstractMethodCallError;
   import com.ankamagames.dofus.kernel.Kernel;
   
   public class AbstractBehavior extends Object
   {
      
      public function AbstractBehavior()
      {
         super();
      }
      
      protected static var _log:Logger = Log.getLogger(getQualifiedClassName(AbstractBehavior));
      
      public static const NORMAL:String = "normal";
      
      public static const STOP:String = "stop";
      
      public static const ALWAYS:String = "always";
      
      public static function createFake(param1:String, param2:Array = null) : AbstractBehavior
      {
         var _loc3_:AbstractBehavior = null;
         switch(param1)
         {
            case StackActionEnum.MOVE:
               _loc3_ = new MoveBehavior();
               _loc3_.position = param2[0];
               break;
         }
         return _loc3_;
      }
      
      public var type:String;
      
      public var isAvailableToStart:Boolean = false;
      
      public var canBeStacked:Boolean = true;
      
      public var isActive:Boolean = true;
      
      public var position:MapPoint;
      
      public var error:Boolean = false;
      
      public var actionStarted:Boolean = false;
      
      public var sprite:Sprite;
      
      public var pendingMessage:Message;
      
      public function processInputMessage(param1:Message, param2:String) : Boolean
      {
         throw new AbstractMethodCallError();
      }
      
      public function processOutputMessage(param1:Message, param2:String) : Boolean
      {
         throw new AbstractMethodCallError();
      }
      
      public function processMessageToWorker() : void
      {
         Kernel.getWorker().process(this.pendingMessage);
         this.pendingMessage = null;
      }
      
      public function isAvailableToProcess(param1:Message) : Boolean
      {
         return true;
      }
      
      public function copy() : AbstractBehavior
      {
         throw new AbstractMethodCallError();
      }
      
      public function checkAvailability(param1:Message) : void
      {
      }
      
      public function reset() : void
      {
         this.pendingMessage = null;
         this.actionStarted = false;
      }
      
      public function getMapPoint() : MapPoint
      {
         return this.position;
      }
      
      public function remove() : void
      {
         this.sprite = null;
      }
      
      public function isMessageCatchable(param1:Message) : Boolean
      {
         return false;
      }
      
      public function addIcon() : void
      {
      }
      
      public function removeIcon() : void
      {
      }
      
      public function get canBeRemoved() : Boolean
      {
         return true;
      }
      
      public function get needToWait() : Boolean
      {
         return false;
      }
      
      public function getFakePosition() : MapPoint
      {
         return null;
      }
   }
}
