package com.ankamagames.dofus.network.messages.game.guild.tax
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class GuildFightJoinRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GuildFightJoinRequestMessage() {
         super();
      }
      
      public static const protocolId:uint = 5717;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var taxCollectorId:int = 0;
      
      override public function getMessageId() : uint {
         return 5717;
      }
      
      public function initGuildFightJoinRequestMessage(taxCollectorId:int = 0) : GuildFightJoinRequestMessage {
         this.taxCollectorId = taxCollectorId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.taxCollectorId = 0;
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
         this.serializeAs_GuildFightJoinRequestMessage(output);
      }
      
      public function serializeAs_GuildFightJoinRequestMessage(output:IDataOutput) : void {
         output.writeInt(this.taxCollectorId);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GuildFightJoinRequestMessage(input);
      }
      
      public function deserializeAs_GuildFightJoinRequestMessage(input:IDataInput) : void {
         this.taxCollectorId = input.readInt();
      }
   }
}
