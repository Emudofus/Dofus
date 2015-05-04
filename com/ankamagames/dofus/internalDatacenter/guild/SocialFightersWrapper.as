package com.ankamagames.dofus.internalDatacenter.guild
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.dofus.network.types.game.character.CharacterMinimalPlusLookInformations;
   import com.ankamagames.dofus.misc.EntityLookAdapter;
   import com.ankamagames.tiphon.types.look.TiphonEntityLook;
   
   public class SocialFightersWrapper extends Object implements IDataCenter
   {
      
      public function SocialFightersWrapper()
      {
         super();
      }
      
      public static function create(param1:uint, param2:CharacterMinimalPlusLookInformations) : SocialFightersWrapper
      {
         var _loc3_:SocialFightersWrapper = new SocialFightersWrapper();
         _loc3_.ally = param1;
         _loc3_.playerCharactersInformations = param2;
         if(param2.entityLook != null)
         {
            _loc3_.entityLook = EntityLookAdapter.getRiderLook(param2.entityLook);
         }
         return _loc3_;
      }
      
      public var ally:uint;
      
      public var playerCharactersInformations:CharacterMinimalPlusLookInformations;
      
      public var entityLook:TiphonEntityLook;
      
      public function update(param1:uint, param2:CharacterMinimalPlusLookInformations) : void
      {
         this.ally = param1;
         this.playerCharactersInformations = param2;
         if(param2.entityLook != null)
         {
            this.entityLook = EntityLookAdapter.getRiderLook(param2.entityLook);
         }
      }
   }
}
