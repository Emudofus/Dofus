package com.ankamagames.dofus.network.messages.authorized
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class AdminCommandMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function AdminCommandMessage() {
         super();
      }
      
      public static const protocolId:uint = 76;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var content:String = "";
      
      override public function getMessageId() : uint {
         return 76;
      }
      
      public function initAdminCommandMessage(content:String="") : AdminCommandMessage {
         this.content = content;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.content = "";
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
         this.serializeAs_AdminCommandMessage(output);
      }
      
      public function serializeAs_AdminCommandMessage(output:IDataOutput) : void {
         output.writeUTF(this.content);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_AdminCommandMessage(input);
      }
      
      public function deserializeAs_AdminCommandMessage(input:IDataInput) : void {
         this.content = input.readUTF();
      }
   }
}
