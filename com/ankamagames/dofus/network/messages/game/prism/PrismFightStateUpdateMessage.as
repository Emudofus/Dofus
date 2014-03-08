package com.ankamagames.dofus.network.messages.game.prism
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class PrismFightStateUpdateMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function PrismFightStateUpdateMessage() {
         super();
      }
      
      public static const protocolId:uint = 6040;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var state:uint = 0;
      
      override public function getMessageId() : uint {
         return 6040;
      }
      
      public function initPrismFightStateUpdateMessage(state:uint=0) : PrismFightStateUpdateMessage {
         this.state = state;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
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
         this.serializeAs_PrismFightStateUpdateMessage(output);
      }
      
      public function serializeAs_PrismFightStateUpdateMessage(output:IDataOutput) : void {
         if(this.state < 0)
         {
            throw new Error("Forbidden value (" + this.state + ") on element state.");
         }
         else
         {
            output.writeByte(this.state);
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_PrismFightStateUpdateMessage(input);
      }
      
      public function deserializeAs_PrismFightStateUpdateMessage(input:IDataInput) : void {
         this.state = input.readByte();
         if(this.state < 0)
         {
            throw new Error("Forbidden value (" + this.state + ") on element of PrismFightStateUpdateMessage.state.");
         }
         else
         {
            return;
         }
      }
   }
}
