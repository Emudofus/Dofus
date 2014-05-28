package com.ankamagames.dofus.network.messages.game.interactive.zaap
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class TeleportRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function TeleportRequestMessage() {
         super();
      }
      
      public static const protocolId:uint = 5961;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var teleporterType:uint = 0;
      
      public var mapId:uint = 0;
      
      override public function getMessageId() : uint {
         return 5961;
      }
      
      public function initTeleportRequestMessage(teleporterType:uint = 0, mapId:uint = 0) : TeleportRequestMessage {
         this.teleporterType = teleporterType;
         this.mapId = mapId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.teleporterType = 0;
         this.mapId = 0;
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
         this.serializeAs_TeleportRequestMessage(output);
      }
      
      public function serializeAs_TeleportRequestMessage(output:IDataOutput) : void {
         output.writeByte(this.teleporterType);
         if(this.mapId < 0)
         {
            throw new Error("Forbidden value (" + this.mapId + ") on element mapId.");
         }
         else
         {
            output.writeInt(this.mapId);
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_TeleportRequestMessage(input);
      }
      
      public function deserializeAs_TeleportRequestMessage(input:IDataInput) : void {
         this.teleporterType = input.readByte();
         if(this.teleporterType < 0)
         {
            throw new Error("Forbidden value (" + this.teleporterType + ") on element of TeleportRequestMessage.teleporterType.");
         }
         else
         {
            this.mapId = input.readInt();
            if(this.mapId < 0)
            {
               throw new Error("Forbidden value (" + this.mapId + ") on element of TeleportRequestMessage.mapId.");
            }
            else
            {
               return;
            }
         }
      }
   }
}
