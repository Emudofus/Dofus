package com.ankamagames.dofus.network.messages.common.basic
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class BasicStatMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function BasicStatMessage() {
         super();
      }
      
      public static const protocolId:uint = 6530;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var statId:uint = 0;
      
      override public function getMessageId() : uint {
         return 6530;
      }
      
      public function initBasicStatMessage(statId:uint = 0) : BasicStatMessage {
         this.statId = statId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.statId = 0;
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
         this.serializeAs_BasicStatMessage(output);
      }
      
      public function serializeAs_BasicStatMessage(output:IDataOutput) : void {
         output.writeUnsignedInt(this.statId);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_BasicStatMessage(input);
      }
      
      public function deserializeAs_BasicStatMessage(input:IDataInput) : void {
         this.statId = input.readUnsignedInt();
         if((this.statId < 0) || (this.statId > 4.294967295E9))
         {
            throw new Error("Forbidden value (" + this.statId + ") on element of BasicStatMessage.statId.");
         }
         else
         {
            return;
         }
      }
   }
}
