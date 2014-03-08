package com.ankamagames.dofus.logic.game.common.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class OpenSmileysAction extends Object implements Action
   {
      
      public function OpenSmileysAction() {
         super();
      }
      
      public static function create(pType:uint, pForceOpen:String="") : OpenSmileysAction {
         var a:OpenSmileysAction = new OpenSmileysAction();
         a.type = pType;
         a.forceOpen = pForceOpen;
         return a;
      }
      
      public var type:uint;
      
      public var forceOpen:String;
   }
}
