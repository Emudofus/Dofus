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
      
      public function SpouseWrapper(o:FriendSpouseInformations) {
         super();
         this._item = o;
         this.name = o.spouseName;
         this.id = o.spouseId;
         this.entityLook = EntityLookAdapter.getRiderLook(o.spouseEntityLook);
         this.level = o.spouseLevel;
         this.breed = o.breed;
         this.sex = o.sex;
         if(o.guildInfo.guildName == "#NONAME#")
         {
            this.guildName = I18n.getUiText("ui.guild.noName");
         }
         else
         {
            this.guildName = o.guildInfo.guildName;
         }
         this.alignmentSide = o.alignmentSide;
         if(o is FriendSpouseOnlineInformations)
         {
            this.mapId = FriendSpouseOnlineInformations(o).mapId;
            this.subareaId = FriendSpouseOnlineInformations(o).subAreaId;
            this.inFight = FriendSpouseOnlineInformations(o).inFight;
            this.followSpouse = FriendSpouseOnlineInformations(o).followSpouse;
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
