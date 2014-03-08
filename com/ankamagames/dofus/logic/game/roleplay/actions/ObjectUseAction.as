package com.ankamagames.dofus.logic.game.roleplay.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ObjectUseAction extends Object implements Action
   {
      
      public function ObjectUseAction() {
         super();
      }
      
      public static function create(param1:uint, param2:int=1, param3:Boolean=false) : ObjectUseAction {
         var _loc4_:ObjectUseAction = new ObjectUseAction();
         _loc4_.objectUID = param1;
         _loc4_.quantity = param2;
         _loc4_.useOnCell = param3;
         return _loc4_;
      }
      
      public var objectUID:uint;
      
      public var useOnCell:Boolean;
      
      public var quantity:int;
   }
}
