package com.ankamagames.dofus.network.messages.game.context.roleplay
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class TeleportOnSameMapMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function TeleportOnSameMapMessage() {
         super();
      }
      
      public static const protocolId:uint = 6048;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var targetId:int = 0;
      
      public var cellId:uint = 0;
      
      override public function getMessageId() : uint {
         return 6048;
      }
      
      public function initTeleportOnSameMapMessage(targetId:int = 0, cellId:uint = 0) : TeleportOnSameMapMessage {
         this.targetId = targetId;
         this.cellId = cellId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.targetId = 0;
         this.cellId = 0;
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
         this.serializeAs_TeleportOnSameMapMessage(output);
      }
      
      public function serializeAs_TeleportOnSameMapMessage(output:IDataOutput) : void {
         output.writeInt(this.targetId);
         if((this.cellId < 0) || (this.cellId > 559))
         {
            throw new Error("Forbidden value (" + this.cellId + ") on element cellId.");
         }
         else
         {
            output.writeShort(this.cellId);
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_TeleportOnSameMapMessage(input);
      }
      
      public function deserializeAs_TeleportOnSameMapMessage(input:IDataInput) : void {
         this.targetId = input.readInt();
         this.cellId = input.readShort();
         if((this.cellId < 0) || (this.cellId > 559))
         {
            throw new Error("Forbidden value (" + this.cellId + ") on element of TeleportOnSameMapMessage.cellId.");
         }
         else
         {
            return;
         }
      }
   }
}
