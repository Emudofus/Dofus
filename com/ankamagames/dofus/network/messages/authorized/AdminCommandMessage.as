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
      
      public function initAdminCommandMessage(param1:String="") : AdminCommandMessage {
         this.content = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.content = "";
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
         this.serializeAs_AdminCommandMessage(param1);
      }
      
      public function serializeAs_AdminCommandMessage(param1:IDataOutput) : void {
         param1.writeUTF(this.content);
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_AdminCommandMessage(param1);
      }
      
      public function deserializeAs_AdminCommandMessage(param1:IDataInput) : void {
         this.content = param1.readUTF();
      }
   }
}
