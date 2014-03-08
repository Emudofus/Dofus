package com.ankamagames.dofus.network.messages.game.guild.tax
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class TaxCollectorMovementRemoveMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function TaxCollectorMovementRemoveMessage() {
         super();
      }
      
      public static const protocolId:uint = 5915;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var collectorId:int = 0;
      
      override public function getMessageId() : uint {
         return 5915;
      }
      
      public function initTaxCollectorMovementRemoveMessage(collectorId:int=0) : TaxCollectorMovementRemoveMessage {
         this.collectorId = collectorId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.collectorId = 0;
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
         this.serializeAs_TaxCollectorMovementRemoveMessage(output);
      }
      
      public function serializeAs_TaxCollectorMovementRemoveMessage(output:IDataOutput) : void {
         output.writeInt(this.collectorId);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_TaxCollectorMovementRemoveMessage(input);
      }
      
      public function deserializeAs_TaxCollectorMovementRemoveMessage(input:IDataInput) : void {
         this.collectorId = input.readInt();
      }
   }
}
