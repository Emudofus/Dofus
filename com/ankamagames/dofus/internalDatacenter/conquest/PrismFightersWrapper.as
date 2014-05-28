package com.ankamagames.dofus.internalDatacenter.conquest
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.dofus.network.types.game.character.CharacterMinimalPlusLookInformations;
   import com.ankamagames.dofus.misc.EntityLookAdapter;
   import com.ankamagames.tiphon.types.look.TiphonEntityLook;
   
   public class PrismFightersWrapper extends Object implements IDataCenter
   {
      
      public function PrismFightersWrapper() {
         super();
      }
      
      public static function create(pFightersInformations:CharacterMinimalPlusLookInformations) : PrismFightersWrapper {
         var item:PrismFightersWrapper = new PrismFightersWrapper();
         item.playerCharactersInformations = pFightersInformations;
         if(pFightersInformations.entityLook != null)
         {
            item.entityLook = EntityLookAdapter.getRiderLook(pFightersInformations.entityLook);
         }
         return item;
      }
      
      public var playerCharactersInformations:CharacterMinimalPlusLookInformations;
      
      public var entityLook:TiphonEntityLook;
   }
}
