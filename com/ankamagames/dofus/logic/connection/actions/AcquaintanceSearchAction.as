package com.ankamagames.dofus.logic.connection.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class AcquaintanceSearchAction extends Object implements Action
   {
      
      public function AcquaintanceSearchAction() {
         super();
      }
      
      public static function create(friendName:String) : AcquaintanceSearchAction {
         var a:AcquaintanceSearchAction = new AcquaintanceSearchAction();
         a.friendName = friendName;
         return a;
      }
      
      public var friendName:String;
   }
}
