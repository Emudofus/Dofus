package com.ankamagames.dofus.internalDatacenter.guild
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.dofus.network.types.game.paddock.PaddockInformations;
   import com.ankamagames.dofus.network.types.game.paddock.PaddockBuyableInformations;
   import com.ankamagames.dofus.network.types.game.paddock.PaddockAbandonnedInformations;
   import com.ankamagames.dofus.network.types.game.paddock.PaddockPrivateInformations;
   
   public class PaddockWrapper extends Object implements IDataCenter
   {
      
      public function PaddockWrapper() {
         super();
      }
      
      public static function create(paddockInformations:PaddockInformations) : PaddockWrapper {
         var pbi:PaddockBuyableInformations = null;
         var pai:PaddockAbandonnedInformations = null;
         var ppi:PaddockPrivateInformations = null;
         var paddock:PaddockWrapper = new PaddockWrapper();
         paddock.maxOutdoorMount = paddockInformations.maxOutdoorMount;
         paddock.maxItems = paddockInformations.maxItems;
         if(paddockInformations is PaddockBuyableInformations)
         {
            pbi = paddockInformations as PaddockBuyableInformations;
            paddock.price = pbi.price;
            paddock.isSaleLocked = pbi.locked;
         }
         if(paddockInformations is PaddockAbandonnedInformations)
         {
            pai = paddockInformations as PaddockAbandonnedInformations;
            paddock.guildId = pai.guildId;
            paddock.isAbandonned = true;
         }
         if(paddockInformations is PaddockPrivateInformations)
         {
            ppi = paddockInformations as PaddockPrivateInformations;
            paddock.guildIdentity = GuildWrapper.create(ppi.guildInfo.guildId,ppi.guildInfo.guildName,ppi.guildInfo.guildEmblem,0,true);
         }
         return paddock;
      }
      
      public var maxOutdoorMount:uint;
      
      public var maxItems:uint;
      
      public var price:uint = 0;
      
      public var guildId:int = 0;
      
      public var guildIdentity:GuildWrapper;
      
      public var isSaleLocked:Boolean;
      
      public var isAbandonned:Boolean;
   }
}
