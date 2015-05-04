package com.ankamagames.dofus.network.messages.game.interactive.zaap
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class TeleportRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function TeleportRequestMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 5961;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var teleporterType:uint = 0;
      
      public var mapId:uint = 0;
      
      override public function getMessageId() : uint
      {
         return 5961;
      }
      
      public function initTeleportRequestMessage(param1:uint = 0, param2:uint = 0) : TeleportRequestMessage
      {
         this.teleporterType = param1;
         this.mapId = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.teleporterType = 0;
         this.mapId = 0;
         this._isInitialized = false;
      }
      
      override public function pack(param1:ICustomDataOutput) : void
      {
         var _loc2_:ByteArray = new ByteArray();
         this.serialize(new CustomDataWrapper(_loc2_));
         writePacket(param1,this.getMessageId(),_loc2_);
      }
      
      override public function unpack(param1:ICustomDataInput, param2:uint) : void
      {
         this.deserialize(param1);
      }
      
      public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_TeleportRequestMessage(param1);
      }
      
      public function serializeAs_TeleportRequestMessage(param1:ICustomDataOutput) : void
      {
         param1.writeByte(this.teleporterType);
         if(this.mapId < 0)
         {
            throw new Error("Forbidden value (" + this.mapId + ") on element mapId.");
         }
         else
         {
            param1.writeInt(this.mapId);
            return;
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_TeleportRequestMessage(param1);
      }
      
      public function deserializeAs_TeleportRequestMessage(param1:ICustomDataInput) : void
      {
         this.teleporterType = param1.readByte();
         if(this.teleporterType < 0)
         {
            throw new Error("Forbidden value (" + this.teleporterType + ") on element of TeleportRequestMessage.teleporterType.");
         }
         else
         {
            this.mapId = param1.readInt();
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
