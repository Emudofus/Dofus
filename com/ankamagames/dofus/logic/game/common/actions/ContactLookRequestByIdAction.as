package com.ankamagames.dofus.logic.game.common.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ContactLookRequestByIdAction extends Object implements Action
   {
      
      public function ContactLookRequestByIdAction() {
         super();
      }
      
      public static function create(param1:uint, param2:uint) : ContactLookRequestByIdAction {
         var _loc3_:ContactLookRequestByIdAction = new ContactLookRequestByIdAction();
         _loc3_._contactType = param1;
         _loc3_._entityId = param2;
         return _loc3_;
      }
      
      private var _contactType:uint;
      
      public function get contactType() : uint {
         return this._contactType;
      }
      
      private var _entityId:uint;
      
      public function get entityId() : uint {
         return this._entityId;
      }
   }
}
