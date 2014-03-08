package com.ankamagames.dofus.logic.game.common.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class OpenSmileysAction extends Object implements Action
   {
      
      public function OpenSmileysAction() {
         super();
      }
      
      public static function create(param1:uint, param2:String="") : OpenSmileysAction {
         var _loc3_:OpenSmileysAction = new OpenSmileysAction();
         _loc3_.type = param1;
         _loc3_.forceOpen = param2;
         return _loc3_;
      }
      
      public var type:uint;
      
      public var forceOpen:String;
   }
}
