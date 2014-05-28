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
      
      public function initGuildChangeMemberParametersMessage(memberId:uint = 0, rank:uint = 0, experienceGivenPercent:uint = 0, rights:uint = 0) : GuildChangeMemberParametersMessage {
         this.memberId = memberId;
         this.rank = rank;
         this.experienceGivenPercent = experienceGivenPercent;
         this.rights = rights;
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
      
      override public function pack(output:IDataOutput) : void {
         var data:ByteArray = new ByteArray();
         this.serialize(data);
         writePacket(output,this.getMessageId(),data);
      }
      
      override public function unpack(input:IDataInput, length:uint) : void {
         this.deserialize(input);
      }
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_GuildChangeMemberParametersMessage(output);
      }
      
      public function serializeAs_GuildChangeMemberParametersMessage(output:IDataOutput) : void {
         if(this.memberId < 0)
         {
            throw new Error("Forbidden value (" + this.memberId + ") on element memberId.");
         }
         else
         {
            output.writeInt(this.memberId);
            if(this.rank < 0)
            {
               throw new Error("Forbidden value (" + this.rank + ") on element rank.");
            }
            else
            {
               output.writeShort(this.rank);
               if((this.experienceGivenPercent < 0) || (this.experienceGivenPercent > 100))
               {
                  throw new Error("Forbidden value (" + this.experienceGivenPercent + ") on element experienceGivenPercent.");
               }
               else
               {
                  output.writeByte(this.experienceGivenPercent);
                  if((this.rights < 0) || (this.rights > 4.294967295E9))
                  {
                     throw new Error("Forbidden value (" + this.rights + ") on element rights.");
                  }
                  else
                  {
                     output.writeUnsignedInt(this.rights);
                     return;
                  }
               }
            }
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GuildChangeMemberParametersMessage(input);
      }
      
      public function deserializeAs_GuildChangeMemberParametersMessage(input:IDataInput) : void {
         this.memberId = input.readInt();
         if(this.memberId < 0)
         {
            throw new Error("Forbidden value (" + this.memberId + ") on element of GuildChangeMemberParametersMessage.memberId.");
         }
         else
         {
            this.rank = input.readShort();
            if(this.rank < 0)
            {
               throw new Error("Forbidden value (" + this.rank + ") on element of GuildChangeMemberParametersMessage.rank.");
            }
            else
            {
               this.experienceGivenPercent = input.readByte();
               if((this.experienceGivenPercent < 0) || (this.experienceGivenPercent > 100))
               {
                  throw new Error("Forbidden value (" + this.experienceGivenPercent + ") on element of GuildChangeMemberParametersMessage.experienceGivenPercent.");
               }
               else
               {
                  this.rights = input.readUnsignedInt();
                  if((this.rights < 0) || (this.rights > 4.294967295E9))
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
