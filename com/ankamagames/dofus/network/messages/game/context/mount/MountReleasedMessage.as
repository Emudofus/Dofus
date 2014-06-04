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
         if((this.mountId < -9.007199254740992E15) || (this.mountId > 9.007199254740992E15))
         {
            throw new Error("Forbidden value (" + this.mountId + ") on element mountId.");
         }
         else
         {
            output.writeDouble(this.mountId);
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_MountReleasedMessage(input);
      }
      
      public function deserializeAs_MountReleasedMessage(input:IDataInput) : void {
         this.mountId = input.readDouble();
         if((this.mountId < -9.007199254740992E15) || (this.mountId > 9.007199254740992E15))
         {
            throw new Error("Forbidden value (" + this.mountId + ") on element of MountReleasedMessage.mountId.");
         }
         else
         {
            return;
         }
      }
   }
}
