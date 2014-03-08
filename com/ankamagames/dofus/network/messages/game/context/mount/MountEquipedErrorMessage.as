package com.ankamagames.dofus.network.messages.game.context.mount
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class MountEquipedErrorMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function MountEquipedErrorMessage() {
         super();
      }
      
      public static const protocolId:uint = 5963;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var errorType:uint = 0;
      
      override public function getMessageId() : uint {
         return 5963;
      }
      
      public function initMountEquipedErrorMessage(errorType:uint=0) : MountEquipedErrorMessage {
         this.errorType = errorType;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.errorType = 0;
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
         this.serializeAs_MountEquipedErrorMessage(output);
      }
      
      public function serializeAs_MountEquipedErrorMessage(output:IDataOutput) : void {
         output.writeByte(this.errorType);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_MountEquipedErrorMessage(input);
      }
      
      public function deserializeAs_MountEquipedErrorMessage(input:IDataInput) : void {
         this.errorType = input.readByte();
         if(this.errorType < 0)
         {
            throw new Error("Forbidden value (" + this.errorType + ") on element of MountEquipedErrorMessage.errorType.");
         }
         else
         {
            return;
         }
      }
   }
}
