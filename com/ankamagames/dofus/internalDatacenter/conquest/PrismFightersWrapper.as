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
      
      public static function create(param1:CharacterMinimalPlusLookInformations) : PrismFightersWrapper {
         var _loc2_:PrismFightersWrapper = new PrismFightersWrapper();
         _loc2_.playerCharactersInformations = param1;
         if(param1.entityLook != null)
         {
            _loc2_.entityLook = EntityLookAdapter.getRiderLook(param1.entityLook);
         }
         return _loc2_;
      }
      
      public var playerCharactersInformations:CharacterMinimalPlusLookInformations;
      
      public var entityLook:TiphonEntityLook;
   }
}
