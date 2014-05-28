package com.ankamagames.dofus.network.messages.game.context.mount
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class MountReleasedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function MountReleasedMessage() {
         super();
      }
      
      public static const protocolId:uint = 6308;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var mountId:Number = 0;
      
      override public function getMessageId() : uint {
         return 6308;
      }
      
      public function initMountReleasedMessage(mountId:Number = 0) : MountReleasedMessage {
         this.mountId = mountId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.mountId = 0;
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
         this.serializeAs_MountReleasedMessage(output);
      }
      
      public function serializeAs_MountReleasedMessage(output:IDataOutput) : void {
         output.writeDouble(this.mountId);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_MountReleasedMessage(input);
      }
      
      public function deserializeAs_MountReleasedMessage(input:IDataInput) : void {
         this.mountId = input.readDouble();
      }
   }
}
