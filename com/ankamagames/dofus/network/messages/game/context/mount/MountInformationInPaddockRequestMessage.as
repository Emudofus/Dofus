package com.ankamagames.dofus.network.messages.game.context.mount
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class MountInformationInPaddockRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function MountInformationInPaddockRequestMessage() {
         super();
      }
      
      public static const protocolId:uint = 5975;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var mapRideId:int = 0;
      
      override public function getMessageId() : uint {
         return 5975;
      }
      
      public function initMountInformationInPaddockRequestMessage(mapRideId:int=0) : MountInformationInPaddockRequestMessage {
         this.mapRideId = mapRideId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.mapRideId = 0;
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
         this.serializeAs_MountInformationInPaddockRequestMessage(output);
      }
      
      public function serializeAs_MountInformationInPaddockRequestMessage(output:IDataOutput) : void {
         output.writeInt(this.mapRideId);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_MountInformationInPaddockRequestMessage(input);
      }
      
      public function deserializeAs_MountInformationInPaddockRequestMessage(input:IDataInput) : void {
         this.mapRideId = input.readInt();
      }
   }
}
