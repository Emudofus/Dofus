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
      
      public function initBasicWhoIsNoMatchMessage(param1:String="") : BasicWhoIsNoMatchMessage {
         this.search = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.search = "";
         this._isInitialized = false;
      }
      
      override public function pack(param1:IDataOutput) : void {
         var _loc2_:ByteArray = new ByteArray();
         this.serialize(_loc2_);
         writePacket(param1,this.getMessageId(),_loc2_);
      }
      
      override public function unpack(param1:IDataInput, param2:uint) : void {
         this.deserialize(param1);
      }
      
      public function serialize(param1:IDataOutput) : void {
         this.serializeAs_BasicWhoIsNoMatchMessage(param1);
      }
      
      public function serializeAs_BasicWhoIsNoMatchMessage(param1:IDataOutput) : void {
         param1.writeUTF(this.search);
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_BasicWhoIsNoMatchMessage(param1);
      }
      
      public function deserializeAs_BasicWhoIsNoMatchMessage(param1:IDataInput) : void {
         this.search = param1.readUTF();
      }
   }
}
