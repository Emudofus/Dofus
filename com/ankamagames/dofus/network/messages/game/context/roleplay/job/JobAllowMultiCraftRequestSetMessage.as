package com.ankamagames.dofus.network.messages.game.context.roleplay.job
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class JobAllowMultiCraftRequestSetMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function JobAllowMultiCraftRequestSetMessage() {
         super();
      }
      
      public static const protocolId:uint = 5749;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var enabled:Boolean = false;
      
      override public function getMessageId() : uint {
         return 5749;
      }
      
      public function initJobAllowMultiCraftRequestSetMessage(enabled:Boolean = false) : JobAllowMultiCraftRequestSetMessage {
         this.enabled = enabled;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.enabled = false;
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
         this.serializeAs_JobAllowMultiCraftRequestSetMessage(output);
      }
      
      public function serializeAs_JobAllowMultiCraftRequestSetMessage(output:IDataOutput) : void {
         output.writeBoolean(this.enabled);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_JobAllowMultiCraftRequestSetMessage(input);
      }
      
      public function deserializeAs_JobAllowMultiCraftRequestSetMessage(input:IDataInput) : void {
         this.enabled = input.readBoolean();
      }
   }
}
