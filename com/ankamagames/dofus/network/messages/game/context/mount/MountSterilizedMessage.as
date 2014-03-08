package com.ankamagames.dofus.network.messages.game.context.mount
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class MountSterilizedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function MountSterilizedMessage() {
         super();
      }
      
      public static const protocolId:uint = 5977;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var mountId:Number = 0;
      
      override public function getMessageId() : uint {
         return 5977;
      }
      
      public function initMountSterilizedMessage(mountId:Number=0) : MountSterilizedMessage {
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
         this.serializeAs_MountSterilizedMessage(output);
      }
      
      public function serializeAs_MountSterilizedMessage(output:IDataOutput) : void {
         output.writeDouble(this.mountId);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_MountSterilizedMessage(input);
      }
      
      public function deserializeAs_MountSterilizedMessage(input:IDataInput) : void {
         this.mountId = input.readDouble();
      }
   }
}
