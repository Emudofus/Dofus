package com.ankamagames.dofus.internalDatacenter.guild
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.dofus.network.types.game.character.CharacterMinimalPlusLookInformations;
   import com.ankamagames.dofus.misc.EntityLookAdapter;
   import com.ankamagames.tiphon.types.look.TiphonEntityLook;


   public class TaxCollectorFightersWrapper extends Object implements IDataCenter
   {
         

      public function TaxCollectorFightersWrapper() {
         super();
      }

      public static function create(pAlly:uint, pFightersInformations:CharacterMinimalPlusLookInformations) : TaxCollectorFightersWrapper {
         var item:TaxCollectorFightersWrapper = new TaxCollectorFightersWrapper();
         item.ally=pAlly;
         item.playerCharactersInformations=pFightersInformations;
         if(pFightersInformations.entityLook!=null)
         {
            item.entityLook=EntityLookAdapter.getRiderLook(pFightersInformations.entityLook);
         }
         else
         {
            trace("Le entityLook est null :(");
         }
         return item;
      }

      public var ally:uint;

      public var playerCharactersInformations:CharacterMinimalPlusLookInformations;

      public var entityLook:TiphonEntityLook;

      public function update(pAlly:uint, pFightersInformations:CharacterMinimalPlusLookInformations) : void {
         this.ally=pAlly;
         this.playerCharactersInformations=pFightersInformations;
         if(pFightersInformations.entityLook!=null)
         {
            this.entityLook=EntityLookAdapter.getRiderLook(pFightersInformations.entityLook);
         }
         else
         {
            trace("Le entityLook est null :(");
         }
      }
   }

}