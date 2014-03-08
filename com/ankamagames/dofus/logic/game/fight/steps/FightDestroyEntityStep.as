package com.ankamagames.dofus.logic.game.fight.steps
{
   import com.ankamagames.atouin.types.sequences.DestroyEntityStep;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import com.ankamagames.dofus.logic.game.fight.miscs.FightEntitiesHolder;
   
   public class FightDestroyEntityStep extends DestroyEntityStep implements IFightStep
   {
      
      public function FightDestroyEntityStep(entity:IEntity) {
         super(entity);
         FightEntitiesHolder.getInstance().unholdEntity(entity.id);
      }
      
      public function get stepType() : String {
         return "destroyEntity";
      }
   }
}
