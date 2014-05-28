package com.ankamagames.dofus.network.types.game.friend
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import com.ankamagames.dofus.network.types.game.context.roleplay.BasicGuildInformations;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class FriendSpouseInformations extends Object implements INetworkType
   {
      
      public function FriendSpouseInformations() {
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
      
      public function getTypeId() : uint {
         return 77;
      }
      
      public function initFriendSpouseInformations(spouseAccountId:uint = 0, spouseId:uint = 0, spouseName:String = "", spouseLevel:uint = 0, breed:int = 0, sex:int = 0, spouseEntityLook:EntityLook = null, guildInfo:BasicGuildInformations = null, alignmentSide:int = 0) : FriendSpouseInformations {
         this.spouseAccountId = spouseAccountId;
         this.spouseId = spouseId;
         this.spouseName = spouseName;
         this.spouseLevel = spouseLevel;
         this.breed = breed;
         this.sex = sex;
         this.spouseEntityLook = spouseEntityLook;
         this.guildInfo = guildInfo;
         this.alignmentSide = alignmentSide;
         return this;
      }
      
      public function reset() : void {
         this.spouseAccountId = 0;
         this.spouseId = 0;
         this.spouseName = "";
         this.spouseLevel = 0;
         this.breed = 0;
         this.sex = 0;
         this.spouseEntityLook = new EntityLook();
      }
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_FriendSpouseInformations(output);
      }
      
      public function serializeAs_FriendSpouseInformations(output:IDataOutput) : void {
         if(this.spouseAccountId < 0)
         {
            throw new Error("Forbidden value (" + this.spouseAccountId + ") on element spouseAccountId.");
         }
         else
         {
            output.writeInt(this.spouseAccountId);
            if(this.spouseId < 0)
            {
               throw new Error("Forbidden value (" + this.spouseId + ") on element spouseId.");
            }
            else
            {
               output.writeInt(this.spouseId);
               output.writeUTF(this.spouseName);
               if((this.spouseLevel < 1) || (this.spouseLevel > 200))
               {
                  throw new Error("Forbidden value (" + this.spouseLevel + ") on element spouseLevel.");
               }
               else
               {
                  output.writeByte(this.spouseLevel);
                  output.writeByte(this.breed);
                  output.writeByte(this.sex);
                  this.spouseEntityLook.serializeAs_EntityLook(output);
                  this.guildInfo.serializeAs_BasicGuildInformations(output);
                  output.writeByte(this.alignmentSide);
                  return;
               }
            }
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_FriendSpouseInformations(input);
      }
      
      public function deserializeAs_FriendSpouseInformations(input:IDataInput) : void {
         this.spouseAccountId = input.readInt();
         if(this.spouseAccountId < 0)
         {
            throw new Error("Forbidden value (" + this.spouseAccountId + ") on element of FriendSpouseInformations.spouseAccountId.");
         }
         else
         {
            this.spouseId = input.readInt();
            if(this.spouseId < 0)
            {
               throw new Error("Forbidden value (" + this.spouseId + ") on element of FriendSpouseInformations.spouseId.");
            }
            else
            {
               this.spouseName = input.readUTF();
               this.spouseLevel = input.readUnsignedByte();
               if((this.spouseLevel < 1) || (this.spouseLevel > 200))
               {
                  throw new Error("Forbidden value (" + this.spouseLevel + ") on element of FriendSpouseInformations.spouseLevel.");
               }
               else
               {
                  this.breed = input.readByte();
                  this.sex = input.readByte();
                  this.spouseEntityLook = new EntityLook();
                  this.spouseEntityLook.deserialize(input);
                  this.guildInfo = new BasicGuildInformations();
                  this.guildInfo.deserialize(input);
                  this.alignmentSide = input.readByte();
                  return;
               }
            }
         }
      }
   }
}
