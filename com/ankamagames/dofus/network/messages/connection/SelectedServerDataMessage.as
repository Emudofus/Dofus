package com.ankamagames.dofus.network.messages.connection
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class SelectedServerDataMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function SelectedServerDataMessage() {
         super();
      }
      
      public static const protocolId:uint = 42;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var serverId:int = 0;
      
      public var address:String = "";
      
      public var port:uint = 0;
      
      public var canCreateNewCharacter:Boolean = false;
      
      public var ticket:String = "";
      
      override public function getMessageId() : uint {
         return 42;
      }
      
      public function initSelectedServerDataMessage(param1:int=0, param2:String="", param3:uint=0, param4:Boolean=false, param5:String="") : SelectedServerDataMessage {
         this.serverId = param1;
         this.address = param2;
         this.port = param3;
         this.canCreateNewCharacter = param4;
         this.ticket = param5;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.serverId = 0;
         this.address = "";
         this.port = 0;
         this.canCreateNewCharacter = false;
         this.ticket = "";
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
         this.serializeAs_SelectedServerDataMessage(param1);
      }
      
      public function serializeAs_SelectedServerDataMessage(param1:IDataOutput) : void {
         param1.writeShort(this.serverId);
         param1.writeUTF(this.address);
         if(this.port < 0 || this.port > 65535)
         {
            throw new Error("Forbidden value (" + this.port + ") on element port.");
         }
         else
         {
            param1.writeShort(this.port);
            param1.writeBoolean(this.canCreateNewCharacter);
            param1.writeUTF(this.ticket);
            return;
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_SelectedServerDataMessage(param1);
      }
      
      public function deserializeAs_SelectedServerDataMessage(param1:IDataInput) : void {
         this.serverId = param1.readShort();
         this.address = param1.readUTF();
         this.port = param1.readUnsignedShort();
         if(this.port < 0 || this.port > 65535)
         {
            throw new Error("Forbidden value (" + this.port + ") on element of SelectedServerDataMessage.port.");
         }
         else
         {
            this.canCreateNewCharacter = param1.readBoolean();
            this.ticket = param1.readUTF();
            return;
         }
      }
   }
}
