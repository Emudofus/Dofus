package com.ankamagames.dofus.network.messages.game.context.roleplay.houses.guild
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GuildInformations;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class HouseGuildRightsMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function HouseGuildRightsMessage() {
         this.guildInfo = new GuildInformations();
         super();
      }
      
      public static const protocolId:uint = 5703;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var houseId:uint = 0;
      
      public var guildInfo:GuildInformations;
      
      public var rights:uint = 0;
      
      override public function getMessageId() : uint {
         return 5703;
      }
      
      public function initHouseGuildRightsMessage(houseId:uint = 0, guildInfo:GuildInformations = null, rights:uint = 0) : HouseGuildRightsMessage {
         this.houseId = houseId;
         this.guildInfo = guildInfo;
         this.rights = rights;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.houseId = 0;
         this.guildInfo = new GuildInformations();
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
         this.serializeAs_HouseGuildRightsMessage(output);
      }
      
      public function serializeAs_HouseGuildRightsMessage(output:IDataOutput) : void {
         if(this.houseId < 0)
         {
            throw new Error("Forbidden value (" + this.houseId + ") on element houseId.");
         }
         else
         {
            output.writeShort(this.houseId);
            this.guildInfo.serializeAs_GuildInformations(output);
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
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_HouseGuildRightsMessage(input);
      }
      
      public function deserializeAs_HouseGuildRightsMessage(input:IDataInput) : void {
         this.houseId = input.readShort();
         if(this.houseId < 0)
         {
            throw new Error("Forbidden value (" + this.houseId + ") on element of HouseGuildRightsMessage.houseId.");
         }
         else
         {
            this.guildInfo = new GuildInformations();
            this.guildInfo.deserialize(input);
            this.rights = input.readUnsignedInt();
            if((this.rights < 0) || (this.rights > 4.294967295E9))
            {
               throw new Error("Forbidden value (" + this.rights + ") on element of HouseGuildRightsMessage.rights.");
            }
            else
            {
               return;
            }
         }
      }
   }
}
