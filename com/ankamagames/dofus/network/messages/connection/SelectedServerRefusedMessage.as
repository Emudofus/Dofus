package com.ankamagames.dofus.network.messages.connection
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class SelectedServerRefusedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function SelectedServerRefusedMessage() {
         super();
      }
      
      public static const protocolId:uint = 41;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var serverId:int = 0;
      
      public var error:uint = 1;
      
      public var serverStatus:uint = 1;
      
      override public function getMessageId() : uint {
         return 41;
      }
      
      public function initSelectedServerRefusedMessage(param1:int=0, param2:uint=1, param3:uint=1) : SelectedServerRefusedMessage {
         this.serverId = param1;
         this.error = param2;
         this.serverStatus = param3;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.serverId = 0;
         this.error = 1;
         this.serverStatus = 1;
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
         this.serializeAs_SelectedServerRefusedMessage(param1);
      }
      
      public function serializeAs_SelectedServerRefusedMessage(param1:IDataOutput) : void {
         param1.writeShort(this.serverId);
         param1.writeByte(this.error);
         param1.writeByte(this.serverStatus);
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_SelectedServerRefusedMessage(param1);
      }
      
      public function deserializeAs_SelectedServerRefusedMessage(param1:IDataInput) : void {
         this.serverId = param1.readShort();
         this.error = param1.readByte();
         if(this.error < 0)
         {
            throw new Error("Forbidden value (" + this.error + ") on element of SelectedServerRefusedMessage.error.");
         }
         else
         {
            this.serverStatus = param1.readByte();
            if(this.serverStatus < 0)
            {
               throw new Error("Forbidden value (" + this.serverStatus + ") on element of SelectedServerRefusedMessage.serverStatus.");
            }
            else
            {
               return;
            }
         }
      }
   }
}
