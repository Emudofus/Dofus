package com.ankamagames.dofus.network.messages.game.atlas.compass
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.context.MapCoordinates;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   
   public class CompassUpdateMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function CompassUpdateMessage() {
         this.coords = new MapCoordinates();
         super();
      }
      
      public static const protocolId:uint = 5591;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var type:uint = 0;
      
      public var coords:MapCoordinates;
      
      override public function getMessageId() : uint {
         return 5591;
      }
      
      public function initCompassUpdateMessage(type:uint = 0, coords:MapCoordinates = null) : CompassUpdateMessage {
         this.type = type;
         this.coords = coords;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.type = 0;
         this.coords = new MapCoordinates();
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
         this.serializeAs_CompassUpdateMessage(output);
      }
      
      public function serializeAs_CompassUpdateMessage(output:IDataOutput) : void {
         output.writeByte(this.type);
         output.writeShort(this.coords.getTypeId());
         this.coords.serialize(output);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_CompassUpdateMessage(input);
      }
      
      public function deserializeAs_CompassUpdateMessage(input:IDataInput) : void {
         this.type = input.readByte();
         if(this.type < 0)
         {
            throw new Error("Forbidden value (" + this.type + ") on element of CompassUpdateMessage.type.");
         }
         else
         {
            _id2 = input.readUnsignedShort();
            this.coords = ProtocolTypeManager.getInstance(MapCoordinates,_id2);
            this.coords.deserialize(input);
            return;
         }
      }
   }
}
