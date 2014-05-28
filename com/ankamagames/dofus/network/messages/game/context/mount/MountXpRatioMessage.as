package com.ankamagames.dofus.network.messages.game.context.mount
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class MountXpRatioMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function MountXpRatioMessage() {
         super();
      }
      
      public static const protocolId:uint = 5970;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var ratio:uint = 0;
      
      override public function getMessageId() : uint {
         return 5970;
      }
      
      public function initMountXpRatioMessage(ratio:uint = 0) : MountXpRatioMessage {
         this.ratio = ratio;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.ratio = 0;
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
         this.serializeAs_MountXpRatioMessage(output);
      }
      
      public function serializeAs_MountXpRatioMessage(output:IDataOutput) : void {
         if(this.ratio < 0)
         {
            throw new Error("Forbidden value (" + this.ratio + ") on element ratio.");
         }
         else
         {
            output.writeByte(this.ratio);
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_MountXpRatioMessage(input);
      }
      
      public function deserializeAs_MountXpRatioMessage(input:IDataInput) : void {
         this.ratio = input.readByte();
         if(this.ratio < 0)
         {
            throw new Error("Forbidden value (" + this.ratio + ") on element of MountXpRatioMessage.ratio.");
         }
         else
         {
            return;
         }
      }
   }
}
