package com.ankamagames.dofus.logic.game.fight.steps
{
   import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
   import com.ankamagames.tiphon.display.TiphonSprite;
   
   public class FightRemoveCarriedEntityStep extends FightRemoveSubEntityStep
   {
      
      public function FightRemoveCarriedEntityStep(fighterId:int, carriedId:int, category:uint, slot:uint) {
         this._carriedId = carriedId;
         super(fighterId,category,slot);
      }
      
      private var _carriedId:int;
      
      override public function get stepType() : String {
         return "removeCarriedEntity";
      }
      
      override public function start() : void {
         var carriedEntity:TiphonSprite = DofusEntities.getEntity(this._carriedId) as TiphonSprite;
         var parentSprite:TiphonSprite = carriedEntity.parentSprite;
         if((carriedEntity) && (parentSprite))
         {
            parentSprite.removeSubEntity(carriedEntity);
         }
         super.start();
      }
   }
}
