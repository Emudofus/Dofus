package com.ankamagames.dofus.network.messages.authorized
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ConsoleMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ConsoleMessage() {
         super();
      }
      
      public static const protocolId:uint = 75;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var type:uint = 0;
      
      public var content:String = "";
      
      override public function getMessageId() : uint {
         return 75;
      }
      
      public function initConsoleMessage(type:uint = 0, content:String = "") : ConsoleMessage {
         this.type = type;
         this.content = content;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.type = 0;
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
         this.serializeAs_ConsoleMessage(output);
      }
      
      public function serializeAs_ConsoleMessage(output:IDataOutput) : void {
         output.writeByte(this.type);
         output.writeUTF(this.content);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ConsoleMessage(input);
      }
      
      public function deserializeAs_ConsoleMessage(input:IDataInput) : void {
         this.type = input.readByte();
         if(this.type < 0)
         {
            throw new Error("Forbidden value (" + this.type + ") on element of ConsoleMessage.type.");
         }
         else
         {
            this.content = input.readUTF();
            return;
         }
      }
   }
}
