package com.ankamagames.dofus.network.messages.connection.register
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class NicknameRefusedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function NicknameRefusedMessage() {
         super();
      }
      
      public static const protocolId:uint = 5638;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var reason:uint = 99;
      
      override public function getMessageId() : uint {
         return 5638;
      }
      
      public function initNicknameRefusedMessage(reason:uint=99) : NicknameRefusedMessage {
         this.reason = reason;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.reason = 99;
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
         this.serializeAs_NicknameRefusedMessage(output);
      }
      
      public function serializeAs_NicknameRefusedMessage(output:IDataOutput) : void {
         output.writeByte(this.reason);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_NicknameRefusedMessage(input);
      }
      
      public function deserializeAs_NicknameRefusedMessage(input:IDataInput) : void {
         this.reason = input.readByte();
         if(this.reason < 0)
         {
            throw new Error("Forbidden value (" + this.reason + ") on element of NicknameRefusedMessage.reason.");
         }
         else
         {
            return;
         }
      }
   }
}
