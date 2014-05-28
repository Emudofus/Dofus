package com.ankamagames.dofus.network.messages.game.friend
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class IgnoredAddRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function IgnoredAddRequestMessage() {
         super();
      }
      
      public static const protocolId:uint = 5673;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var name:String = "";
      
      public var session:Boolean = false;
      
      override public function getMessageId() : uint {
         return 5673;
      }
      
      public function initIgnoredAddRequestMessage(name:String = "", session:Boolean = false) : IgnoredAddRequestMessage {
         this.name = name;
         this.session = session;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.name = "";
         this.session = false;
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
         this.serializeAs_IgnoredAddRequestMessage(output);
      }
      
      public function serializeAs_IgnoredAddRequestMessage(output:IDataOutput) : void {
         output.writeUTF(this.name);
         output.writeBoolean(this.session);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_IgnoredAddRequestMessage(input);
      }
      
      public function deserializeAs_IgnoredAddRequestMessage(input:IDataInput) : void {
         this.name = input.readUTF();
         this.session = input.readBoolean();
      }
   }
}
