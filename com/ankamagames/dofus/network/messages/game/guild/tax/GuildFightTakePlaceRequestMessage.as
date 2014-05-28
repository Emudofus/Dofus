package com.ankamagames.dofus.network.messages.game.guild.tax
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class GuildFightTakePlaceRequestMessage extends GuildFightJoinRequestMessage implements INetworkMessage
   {
      
      public function GuildFightTakePlaceRequestMessage() {
         super();
      }
      
      public static const protocolId:uint = 6235;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var replacedCharacterId:int = 0;
      
      override public function getMessageId() : uint {
         return 6235;
      }
      
      public function initGuildFightTakePlaceRequestMessage(taxCollectorId:int = 0, replacedCharacterId:int = 0) : GuildFightTakePlaceRequestMessage {
         super.initGuildFightJoinRequestMessage(taxCollectorId);
         this.replacedCharacterId = replacedCharacterId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.replacedCharacterId = 0;
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
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_GuildFightTakePlaceRequestMessage(output);
      }
      
      public function serializeAs_GuildFightTakePlaceRequestMessage(output:IDataOutput) : void {
         super.serializeAs_GuildFightJoinRequestMessage(output);
         output.writeInt(this.replacedCharacterId);
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GuildFightTakePlaceRequestMessage(input);
      }
      
      public function deserializeAs_GuildFightTakePlaceRequestMessage(input:IDataInput) : void {
         super.deserialize(input);
         this.replacedCharacterId = input.readInt();
      }
   }
}
