package com.ankamagames.dofus.network.messages.game.atlas.compass
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.context.MapCoordinates;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   
   public class CompassUpdateMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function CompassUpdateMessage()
      {
         this.coords = new MapCoordinates();
         super();
      }
      
      public static const protocolId:uint = 5591;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var type:uint = 0;
      
      public var coords:MapCoordinates;
      
      override public function getMessageId() : uint
      {
         return 5591;
      }
      
      public function initCompassUpdateMessage(param1:uint = 0, param2:MapCoordinates = null) : CompassUpdateMessage
      {
         this.type = param1;
         this.coords = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.type = 0;
         this.coords = new MapCoordinates();
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
         this.serializeAs_CompassUpdateMessage(param1);
      }
      
      public function serializeAs_CompassUpdateMessage(param1:ICustomDataOutput) : void
      {
         param1.writeByte(this.type);
         param1.writeShort(this.coords.getTypeId());
         this.coords.serialize(param1);
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_CompassUpdateMessage(param1);
      }
      
      public function deserializeAs_CompassUpdateMessage(param1:ICustomDataInput) : void
      {
         this.type = param1.readByte();
         if(this.type < 0)
         {
            throw new Error("Forbidden value (" + this.type + ") on element of CompassUpdateMessage.type.");
         }
         else
         {
            var _loc2_:uint = param1.readUnsignedShort();
            this.coords = ProtocolTypeManager.getInstance(MapCoordinates,_loc2_);
            this.coords.deserialize(param1);
            return;
         }
      }
   }
}
