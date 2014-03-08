package com.ankamagames.dofus.network.messages.security
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ClientKeyMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ClientKeyMessage() {
         super();
      }
      
      public static const protocolId:uint = 5607;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var key:String = "";
      
      override public function getMessageId() : uint {
         return 5607;
      }
      
      public function initClientKeyMessage(key:String="") : ClientKeyMessage {
         this.key = key;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.key = "";
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
         this.serializeAs_ClientKeyMessage(output);
      }
      
      public function serializeAs_ClientKeyMessage(output:IDataOutput) : void {
         output.writeUTF(this.key);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ClientKeyMessage(input);
      }
      
      public function deserializeAs_ClientKeyMessage(input:IDataInput) : void {
         this.key = input.readUTF();
      }
   }
}
