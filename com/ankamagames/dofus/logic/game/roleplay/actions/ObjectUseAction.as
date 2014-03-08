package com.ankamagames.dofus.logic.game.roleplay.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ObjectUseAction extends Object implements Action
   {
      
      public function ObjectUseAction() {
         super();
      }
      
      public static function create(objectUID:uint, quantity:int=1, useOnCell:Boolean=false) : ObjectUseAction {
         var a:ObjectUseAction = new ObjectUseAction();
         a.objectUID = objectUID;
         a.quantity = quantity;
         a.useOnCell = useOnCell;
         return a;
      }
      
      public var objectUID:uint;
      
      public var useOnCell:Boolean;
      
      public var quantity:int;
   }
}
