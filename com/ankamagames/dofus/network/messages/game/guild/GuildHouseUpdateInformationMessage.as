package com.ankamagames.dofus.network.messages.game.guild
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.house.HouseInformationsForGuild;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class GuildHouseUpdateInformationMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GuildHouseUpdateInformationMessage() {
         this.housesInformations = new HouseInformationsForGuild();
         super();
      }
      
      public static const protocolId:uint = 6181;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var housesInformations:HouseInformationsForGuild;
      
      override public function getMessageId() : uint {
         return 6181;
      }
      
      public function initGuildHouseUpdateInformationMessage(housesInformations:HouseInformationsForGuild = null) : GuildHouseUpdateInformationMessage {
         this.housesInformations = housesInformations;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.housesInformations = new HouseInformationsForGuild();
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
         this.serializeAs_GuildHouseUpdateInformationMessage(output);
      }
      
      public function serializeAs_GuildHouseUpdateInformationMessage(output:IDataOutput) : void {
         this.housesInformations.serializeAs_HouseInformationsForGuild(output);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GuildHouseUpdateInformationMessage(input);
      }
      
      public function deserializeAs_GuildHouseUpdateInformationMessage(input:IDataInput) : void {
         this.housesInformations = new HouseInformationsForGuild();
         this.housesInformations.deserialize(input);
      }
   }
}
