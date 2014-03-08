package com.ankamagames.dofus.network.messages.game.guild
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class GuildChangeMemberParametersMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GuildChangeMemberParametersMessage() {
         super();
      }
      
      public static const protocolId:uint = 5549;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var memberId:uint = 0;
      
      public var rank:uint = 0;
      
      public var experienceGivenPercent:uint = 0;
      
      public var rights:uint = 0;
      
      override public function getMessageId() : uint {
         return 5549;
      }
      
      public function initGuildChangeMemberParametersMessage(param1:uint=0, param2:uint=0, param3:uint=0, param4:uint=0) : GuildChangeMemberParametersMessage {
         this.memberId = param1;
         this.rank = param2;
         this.experienceGivenPercent = param3;
         this.rights = param4;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.memberId = 0;
         this.rank = 0;
         this.experienceGivenPercent = 0;
         this.rights = 0;
         this._isInitialized = false;
      }
      
      override public function pack(param1:IDataOutput) : void {
         var _loc2_:ByteArray = new ByteArray();
         this.serialize(_loc2_);
         writePacket(param1,this.getMessageId(),_loc2_);
      }
      
      override public function unpack(param1:IDataInput, param2:uint) : void {
         this.deserialize(param1);
      }
      
      public function serialize(param1:IDataOutput) : void {
         this.serializeAs_GuildChangeMemberParametersMessage(param1);
      }
      
      public function serializeAs_GuildChangeMemberParametersMessage(param1:IDataOutput) : void {
         if(this.memberId < 0)
         {
            throw new Error("Forbidden value (" + this.memberId + ") on element memberId.");
         }
         else
         {
            param1.writeInt(this.memberId);
            if(this.rank < 0)
            {
               throw new Error("Forbidden value (" + this.rank + ") on element rank.");
            }
            else
            {
               param1.writeShort(this.rank);
               if(this.experienceGivenPercent < 0 || this.experienceGivenPercent > 100)
               {
                  throw new Error("Forbidden value (" + this.experienceGivenPercent + ") on element experienceGivenPercent.");
               }
               else
               {
                  param1.writeByte(this.experienceGivenPercent);
                  if(this.rights < 0 || this.rights > 4.294967295E9)
                  {
                     throw new Error("Forbidden value (" + this.rights + ") on element rights.");
                  }
                  else
                  {
                     param1.writeUnsignedInt(this.rights);
                     return;
                  }
               }
            }
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_GuildChangeMemberParametersMessage(param1);
      }
      
      public function deserializeAs_GuildChangeMemberParametersMessage(param1:IDataInput) : void {
         this.memberId = param1.readInt();
         if(this.memberId < 0)
         {
            throw new Error("Forbidden value (" + this.memberId + ") on element of GuildChangeMemberParametersMessage.memberId.");
         }
         else
         {
            this.rank = param1.readShort();
            if(this.rank < 0)
            {
               throw new Error("Forbidden value (" + this.rank + ") on element of GuildChangeMemberParametersMessage.rank.");
            }
            else
            {
               this.experienceGivenPercent = param1.readByte();
               if(this.experienceGivenPercent < 0 || this.experienceGivenPercent > 100)
               {
                  throw new Error("Forbidden value (" + this.experienceGivenPercent + ") on element of GuildChangeMemberParametersMessage.experienceGivenPercent.");
               }
               else
               {
                  this.rights = param1.readUnsignedInt();
                  if(this.rights < 0 || this.rights > 4.294967295E9)
                  {
                     throw new Error("Forbidden value (" + this.rights + ") on element of GuildChangeMemberParametersMessage.rights.");
                  }
                  else
                  {
                     return;
                  }
               }
            }
         }
      }
   }
}
