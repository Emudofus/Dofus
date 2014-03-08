package com.ankamagames.dofus.network.messages.game.context
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ShowCellMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ShowCellMessage() {
         super();
      }
      
      public static const protocolId:uint = 5612;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var sourceId:int = 0;
      
      public var cellId:uint = 0;
      
      override public function getMessageId() : uint {
         return 5612;
      }
      
      public function initShowCellMessage(sourceId:int=0, cellId:uint=0) : ShowCellMessage {
         this.sourceId = sourceId;
         this.cellId = cellId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.sourceId = 0;
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
         this.serializeAs_ShowCellMessage(output);
      }
      
      public function serializeAs_ShowCellMessage(output:IDataOutput) : void {
         output.writeInt(this.sourceId);
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
         this.deserializeAs_ShowCellMessage(input);
      }
      
      public function deserializeAs_ShowCellMessage(input:IDataInput) : void {
         this.sourceId = input.readInt();
         this.cellId = input.readShort();
         if((this.cellId < 0) || (this.cellId > 559))
         {
            throw new Error("Forbidden value (" + this.cellId + ") on element of ShowCellMessage.cellId.");
         }
         else
         {
            return;
         }
      }
   }
}
