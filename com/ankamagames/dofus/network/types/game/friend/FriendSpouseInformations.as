package com.ankamagames.dofus.network.types.game.friend
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import com.ankamagames.dofus.network.types.game.context.roleplay.BasicGuildInformations;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class FriendSpouseInformations extends Object implements INetworkType
   {
      
      public function FriendSpouseInformations()
      {
         this.spouseEntityLook = new EntityLook();
         this.guildInfo = new BasicGuildInformations();
         super();
      }
      
      public static const protocolId:uint = 77;
      
      public var spouseAccountId:uint = 0;
      
      public var spouseId:uint = 0;
      
      public var spouseName:String = "";
      
      public var spouseLevel:uint = 0;
      
      public var breed:int = 0;
      
      public var sex:int = 0;
      
      public var spouseEntityLook:EntityLook;
      
      public var guildInfo:BasicGuildInformations;
      
      public var alignmentSide:int = 0;
      
      public function getTypeId() : uint
      {
         return 77;
      }
      
      public function initFriendSpouseInformations(param1:uint = 0, param2:uint = 0, param3:String = "", param4:uint = 0, param5:int = 0, param6:int = 0, param7:EntityLook = null, param8:BasicGuildInformations = null, param9:int = 0) : FriendSpouseInformations
      {
         this.spouseAccountId = param1;
         this.spouseId = param2;
         this.spouseName = param3;
         this.spouseLevel = param4;
         this.breed = param5;
         this.sex = param6;
         this.spouseEntityLook = param7;
         this.guildInfo = param8;
         this.alignmentSide = param9;
         return this;
      }
      
      public function reset() : void
      {
         this.spouseAccountId = 0;
         this.spouseId = 0;
         this.spouseName = "";
         this.spouseLevel = 0;
         this.breed = 0;
         this.sex = 0;
         this.spouseEntityLook = new EntityLook();
      }
      
      public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_FriendSpouseInformations(param1);
      }
      
      public function serializeAs_FriendSpouseInformations(param1:ICustomDataOutput) : void
      {
         if(this.spouseAccountId < 0)
         {
            throw new Error("Forbidden value (" + this.spouseAccountId + ") on element spouseAccountId.");
         }
         else
         {
            param1.writeInt(this.spouseAccountId);
            if(this.spouseId < 0)
            {
               throw new Error("Forbidden value (" + this.spouseId + ") on element spouseId.");
            }
            else
            {
               param1.writeVarInt(this.spouseId);
               param1.writeUTF(this.spouseName);
               if(this.spouseLevel < 1 || this.spouseLevel > 200)
               {
                  throw new Error("Forbidden value (" + this.spouseLevel + ") on element spouseLevel.");
               }
               else
               {
                  param1.writeByte(this.spouseLevel);
                  param1.writeByte(this.breed);
                  param1.writeByte(this.sex);
                  this.spouseEntityLook.serializeAs_EntityLook(param1);
                  this.guildInfo.serializeAs_BasicGuildInformations(param1);
                  param1.writeByte(this.alignmentSide);
                  return;
               }
            }
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_FriendSpouseInformations(param1);
      }
      
      public function deserializeAs_FriendSpouseInformations(param1:ICustomDataInput) : void
      {
         this.spouseAccountId = param1.readInt();
         if(this.spouseAccountId < 0)
         {
            throw new Error("Forbidden value (" + this.spouseAccountId + ") on element of FriendSpouseInformations.spouseAccountId.");
         }
         else
         {
            this.spouseId = param1.readVarUhInt();
            if(this.spouseId < 0)
            {
               throw new Error("Forbidden value (" + this.spouseId + ") on element of FriendSpouseInformations.spouseId.");
            }
            else
            {
               this.spouseName = param1.readUTF();
               this.spouseLevel = param1.readUnsignedByte();
               if(this.spouseLevel < 1 || this.spouseLevel > 200)
               {
                  throw new Error("Forbidden value (" + this.spouseLevel + ") on element of FriendSpouseInformations.spouseLevel.");
               }
               else
               {
                  this.breed = param1.readByte();
                  this.sex = param1.readByte();
                  this.spouseEntityLook = new EntityLook();
                  this.spouseEntityLook.deserialize(param1);
                  this.guildInfo = new BasicGuildInformations();
                  this.guildInfo.deserialize(param1);
                  this.alignmentSide = param1.readByte();
                  return;
               }
            }
         }
      }
   }
}
