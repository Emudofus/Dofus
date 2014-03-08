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
      
      public function initSelectedServerRefusedMessage(serverId:int=0, error:uint=1, serverStatus:uint=1) : SelectedServerRefusedMessage {
         this.serverId = serverId;
         this.error = error;
         this.serverStatus = serverStatus;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.serverId = 0;
         this.error = 1;
         this.serverStatus = 1;
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
         this.serializeAs_SelectedServerRefusedMessage(output);
      }
      
      public function serializeAs_SelectedServerRefusedMessage(output:IDataOutput) : void {
         output.writeShort(this.serverId);
         output.writeByte(this.error);
         output.writeByte(this.serverStatus);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_SelectedServerRefusedMessage(input);
      }
      
      public function deserializeAs_SelectedServerRefusedMessage(input:IDataInput) : void {
         this.serverId = input.readShort();
         this.error = input.readByte();
         if(this.error < 0)
         {
            throw new Error("Forbidden value (" + this.error + ") on element of SelectedServerRefusedMessage.error.");
         }
         else
         {
            this.serverStatus = input.readByte();
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
