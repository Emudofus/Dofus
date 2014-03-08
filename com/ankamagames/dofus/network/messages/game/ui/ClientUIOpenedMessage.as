package com.ankamagames.dofus.network.messages.game.ui
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ClientUIOpenedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ClientUIOpenedMessage() {
         super();
      }
      
      public static const protocolId:uint = 6459;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var type:uint = 0;
      
      override public function getMessageId() : uint {
         return 6459;
      }
      
      public function initClientUIOpenedMessage(type:uint=0) : ClientUIOpenedMessage {
         this.type = type;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.type = 0;
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
         this.serializeAs_ClientUIOpenedMessage(output);
      }
      
      public function serializeAs_ClientUIOpenedMessage(output:IDataOutput) : void {
         output.writeByte(this.type);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ClientUIOpenedMessage(input);
      }
      
      public function deserializeAs_ClientUIOpenedMessage(input:IDataInput) : void {
         this.type = input.readByte();
         if(this.type < 0)
         {
            throw new Error("Forbidden value (" + this.type + ") on element of ClientUIOpenedMessage.type.");
         }
         else
         {
            return;
         }
      }
   }
}
