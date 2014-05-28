package com.ankamagames.dofus.network.messages.game.guild.tax
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class TaxCollectorStateUpdateMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function TaxCollectorStateUpdateMessage() {
         super();
      }
      
      public static const protocolId:uint = 6455;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var uniqueId:int = 0;
      
      public var state:int = 0;
      
      override public function getMessageId() : uint {
         return 6455;
      }
      
      public function initTaxCollectorStateUpdateMessage(uniqueId:int = 0, state:int = 0) : TaxCollectorStateUpdateMessage {
         this.uniqueId = uniqueId;
         this.state = state;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.uniqueId = 0;
         this.state = 0;
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
         this.serializeAs_TaxCollectorStateUpdateMessage(output);
      }
      
      public function serializeAs_TaxCollectorStateUpdateMessage(output:IDataOutput) : void {
         output.writeInt(this.uniqueId);
         output.writeByte(this.state);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_TaxCollectorStateUpdateMessage(input);
      }
      
      public function deserializeAs_TaxCollectorStateUpdateMessage(input:IDataInput) : void {
         this.uniqueId = input.readInt();
         this.state = input.readByte();
      }
   }
}
