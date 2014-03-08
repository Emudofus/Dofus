package com.ankamagames.dofus.internalDatacenter.people
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.dofus.network.types.game.friend.FriendSpouseInformations;
   import com.ankamagames.tiphon.types.look.TiphonEntityLook;
   import com.ankamagames.dofus.misc.EntityLookAdapter;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.dofus.network.types.game.friend.FriendSpouseOnlineInformations;
   
   public class SpouseWrapper extends Object implements IDataCenter
   {
      
      public function SpouseWrapper(param1:FriendSpouseInformations) {
         super();
         this._item = param1;
         this.name = param1.spouseName;
         this.id = param1.spouseId;
         this.entityLook = EntityLookAdapter.getRiderLook(param1.spouseEntityLook);
         this.level = param1.spouseLevel;
         this.breed = param1.breed;
         this.sex = param1.sex;
         if(param1.guildInfo.guildName == "#NONAME#")
         {
            this.guildName = I18n.getUiText("ui.guild.noName");
         }
         else
         {
            this.guildName = param1.guildInfo.guildName;
         }
         this.alignmentSide = param1.alignmentSide;
         if(param1 is FriendSpouseOnlineInformations)
         {
            this.mapId = FriendSpouseOnlineInformations(param1).mapId;
            this.subareaId = FriendSpouseOnlineInformations(param1).subAreaId;
            this.inFight = FriendSpouseOnlineInformations(param1).inFight;
            this.followSpouse = FriendSpouseOnlineInformations(param1).followSpouse;
            this.online = true;
         }
      }
      
      private var _item:FriendSpouseInformations;
      
      public var name:String;
      
      public var id:uint;
      
      public var entityLook:TiphonEntityLook;
      
      public var level:int;
      
      public var breed:uint;
      
      public var sex:int;
      
      public var online:Boolean = false;
      
      public var mapId:uint;
      
      public var subareaId:uint;
      
      public var inFight:Boolean;
      
      public var followSpouse:Boolean;
      
      public var guildName:String;
      
      public var alignmentSide:int;
   }
}
