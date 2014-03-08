package com.ankamagames.dofus.logic.game.fight.steps
{
   import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
   import com.ankamagames.tiphon.display.TiphonSprite;
   
   public class FightRemoveCarriedEntityStep extends FightRemoveSubEntityStep
   {
      
      public function FightRemoveCarriedEntityStep(param1:int, param2:int, param3:uint, param4:uint) {
         this._carriedId = param2;
         super(param1,param3,param4);
      }
      
      private var _carriedId:int;
      
      override public function get stepType() : String {
         return "removeCarriedEntity";
      }
      
      override public function start() : void {
         var _loc1_:TiphonSprite = DofusEntities.getEntity(this._carriedId) as TiphonSprite;
         var _loc2_:TiphonSprite = _loc1_.parentSprite;
         if((_loc1_) && (_loc2_))
         {
            _loc2_.removeSubEntity(_loc1_);
         }
         super.start();
      }
   }
}
