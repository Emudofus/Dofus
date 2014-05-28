package com.ankamagames.dofus.network.types.game.friend
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import com.ankamagames.dofus.network.types.game.context.roleplay.BasicGuildInformations;
   import flash.utils.IDataOutput;
   import com.ankamagames.jerakine.network.utils.BooleanByteWrapper;
   import flash.utils.IDataInput;
   
   public class FriendSpouseOnlineInformations extends FriendSpouseInformations implements INetworkType
   {
      
      public function FriendSpouseOnlineInformations() {
         super();
      }
      
      public static const protocolId:uint = 93;
      
      public var mapId:uint = 0;
      
      public var subAreaId:uint = 0;
      
      public var inFight:Boolean = false;
      
      public var followSpouse:Boolean = false;
      
      override public function getTypeId() : uint {
         return 93;
      }
      
      public function initFriendSpouseOnlineInformations(spouseAccountId:uint = 0, spouseId:uint = 0, spouseName:String = "", spouseLevel:uint = 0, breed:int = 0, sex:int = 0, spouseEntityLook:EntityLook = null, guildInfo:BasicGuildInformations = null, alignmentSide:int = 0, mapId:uint = 0, subAreaId:uint = 0, inFight:Boolean = false, followSpouse:Boolean = false) : FriendSpouseOnlineInformations {
         super.initFriendSpouseInformations(spouseAccountId,spouseId,spouseName,spouseLevel,breed,sex,spouseEntityLook,guildInfo,alignmentSide);
         this.mapId = mapId;
         this.subAreaId = subAreaId;
         this.inFight = inFight;
         this.followSpouse = followSpouse;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.mapId = 0;
         this.subAreaId = 0;
         this.inFight = false;
         this.followSpouse = false;
      }
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_FriendSpouseOnlineInformations(output);
      }
      
      public function serializeAs_FriendSpouseOnlineInformations(output:IDataOutput) : void {
         super.serializeAs_FriendSpouseInformations(output);
         var _box0:uint = 0;
         _box0 = BooleanByteWrapper.setFlag(_box0,0,this.inFight);
         _box0 = BooleanByteWrapper.setFlag(_box0,1,this.followSpouse);
         output.writeByte(_box0);
         if(this.mapId < 0)
         {
            throw new Error("Forbidden value (" + this.mapId + ") on element mapId.");
         }
         else
         {
            output.writeInt(this.mapId);
            if(this.subAreaId < 0)
            {
               throw new Error("Forbidden value (" + this.subAreaId + ") on element subAreaId.");
            }
            else
            {
               output.writeShort(this.subAreaId);
               return;
            }
         }
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_FriendSpouseOnlineInformations(input);
      }
      
      public function deserializeAs_FriendSpouseOnlineInformations(input:IDataInput) : void {
         super.deserialize(input);
         var _box0:uint = input.readByte();
         this.inFight = BooleanByteWrapper.getFlag(_box0,0);
         this.followSpouse = BooleanByteWrapper.getFlag(_box0,1);
         this.mapId = input.readInt();
         if(this.mapId < 0)
         {
            throw new Error("Forbidden value (" + this.mapId + ") on element of FriendSpouseOnlineInformations.mapId.");
         }
         else
         {
            this.subAreaId = input.readShort();
            if(this.subAreaId < 0)
            {
               throw new Error("Forbidden value (" + this.subAreaId + ") on element of FriendSpouseOnlineInformations.subAreaId.");
            }
            else
            {
               return;
            }
         }
      }
   }
}
