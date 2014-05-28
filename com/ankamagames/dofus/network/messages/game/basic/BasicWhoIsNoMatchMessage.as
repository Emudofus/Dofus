package com.ankamagames.dofus.network.messages.game.basic
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class BasicWhoIsNoMatchMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function BasicWhoIsNoMatchMessage() {
         super();
      }
      
      public static const protocolId:uint = 179;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var search:String = "";
      
      override public function getMessageId() : uint {
         return 179;
      }
      
      public function initBasicWhoIsNoMatchMessage(search:String = "") : BasicWhoIsNoMatchMessage {
         this.search = search;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.search = "";
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
         this.serializeAs_BasicWhoIsNoMatchMessage(output);
      }
      
      public function serializeAs_BasicWhoIsNoMatchMessage(output:IDataOutput) : void {
         output.writeUTF(this.search);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_BasicWhoIsNoMatchMessage(input);
      }
      
      public function deserializeAs_BasicWhoIsNoMatchMessage(input:IDataInput) : void {
         this.search = input.readUTF();
      }
   }
}
