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
      
      public static function create(param1:PaddockInformations) : PaddockWrapper {
         var _loc3_:PaddockBuyableInformations = null;
         var _loc4_:PaddockAbandonnedInformations = null;
         var _loc5_:PaddockPrivateInformations = null;
         var _loc2_:PaddockWrapper = new PaddockWrapper();
         _loc2_.maxOutdoorMount = param1.maxOutdoorMount;
         _loc2_.maxItems = param1.maxItems;
         if(param1 is PaddockBuyableInformations)
         {
            _loc3_ = param1 as PaddockBuyableInformations;
            _loc2_.price = _loc3_.price;
            _loc2_.isSaleLocked = _loc3_.locked;
         }
         if(param1 is PaddockAbandonnedInformations)
         {
            _loc4_ = param1 as PaddockAbandonnedInformations;
            _loc2_.guildId = _loc4_.guildId;
            _loc2_.isAbandonned = true;
         }
         if(param1 is PaddockPrivateInformations)
         {
            _loc5_ = param1 as PaddockPrivateInformations;
            _loc2_.guildIdentity = GuildWrapper.create(_loc5_.guildInfo.guildId,_loc5_.guildInfo.guildName,_loc5_.guildInfo.guildEmblem,0,true);
         }
         return _loc2_;
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
