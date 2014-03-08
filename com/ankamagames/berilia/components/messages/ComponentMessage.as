package com.ankamagames.berilia.components.messages
{
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import flash.display.InteractiveObject;
   import flash.display.DisplayObject;
   import com.ankamagames.jerakine.handlers.messages.InvalidCancelError;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ComponentMessage extends Object implements Message
   {
      
      public function ComponentMessage(param1:InteractiveObject) {
         super();
         this._target = param1;
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(ComponentMessage));
      
      protected var _target:InteractiveObject;
      
      private var _canceled:Boolean;
      
      private var _actions:Array;
      
      public var bubbling:Boolean;
      
      public function get target() : DisplayObject {
         return this._target;
      }
      
      public function get canceled() : Boolean {
         return this._canceled;
      }
      
      public function set canceled(param1:Boolean) : void {
         if(this.bubbling)
         {
            throw new InvalidCancelError("Can\'t cancel a bubbling message.");
         }
         else
         {
            if((this._canceled) && !param1)
            {
               throw new InvalidCancelError("Can\'t uncancel a canceled message.");
            }
            else
            {
               this._canceled = param1;
               return;
            }
         }
      }
      
      public function get actions() : Array {
         return this._actions;
      }
      
      public function addAction(param1:Action) : void {
         if(this._actions == null)
         {
            this._actions = new Array();
         }
         this._actions.push(param1);
      }
   }
}
