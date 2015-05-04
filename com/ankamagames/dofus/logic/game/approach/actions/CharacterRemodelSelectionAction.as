package com.ankamagames.dofus.logic.game.approach.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class CharacterRemodelSelectionAction extends Object implements Action
   {
      
      public function CharacterRemodelSelectionAction()
      {
         super();
      }
      
      public static function create(param1:int, param2:Boolean, param3:uint, param4:uint, param5:String, param6:Vector.<int>) : CharacterRemodelSelectionAction
      {
         var _loc7_:CharacterRemodelSelectionAction = new CharacterRemodelSelectionAction();
         _loc7_.id = param1;
         _loc7_.sex = param2;
         _loc7_.breed = param3;
         _loc7_.cosmeticId = param4;
         _loc7_.name = param5;
         _loc7_.colors = param6;
         return _loc7_;
      }
      
      public var id:int;
      
      public var sex:Boolean;
      
      public var breed:uint;
      
      public var cosmeticId:uint;
      
      public var name:String;
      
      public var colors:Vector.<int>;
   }
}
