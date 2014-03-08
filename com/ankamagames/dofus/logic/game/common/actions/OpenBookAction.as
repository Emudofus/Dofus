package com.ankamagames.dofus.logic.game.common.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class OpenBookAction extends Object implements Action
   {
      
      public function OpenBookAction() {
         super();
      }
      
      public static function create(param1:String=null, param2:Object=null) : OpenBookAction {
         var _loc3_:OpenBookAction = new OpenBookAction();
         _loc3_.value = param1;
         _loc3_.param = param2;
         return _loc3_;
      }
      
      private var _name:String;
      
      public var value:String;
      
      public var param:Object;
   }
}
