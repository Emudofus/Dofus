package com.ankamagames.dofus.network.messages.game.packs
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class PackRestrictedSubAreaMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function PackRestrictedSubAreaMessage() {
         super();
      }
      
      public static const protocolId:uint = 6186;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var subAreaId:uint = 0;
      
      override public function getMessageId() : uint {
         return 6186;
      }
      
      public function initPackRestrictedSubAreaMessage(subAreaId:uint = 0) : PackRestrictedSubAreaMessage {
         this.subAreaId = subAreaId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.subAreaId = 0;
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
         this.serializeAs_PackRestrictedSubAreaMessage(output);
      }
      
      public function serializeAs_PackRestrictedSubAreaMessage(output:IDataOutput) : void {
         if(this.subAreaId < 0)
         {
            throw new Error("Forbidden value (" + this.subAreaId + ") on element subAreaId.");
         }
         else
         {
            output.writeInt(this.subAreaId);
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_PackRestrictedSubAreaMessage(input);
      }
      
      public function deserializeAs_PackRestrictedSubAreaMessage(input:IDataInput) : void {
         this.subAreaId = input.readInt();
         if(this.subAreaId < 0)
         {
            throw new Error("Forbidden value (" + this.subAreaId + ") on element of PackRestrictedSubAreaMessage.subAreaId.");
         }
         else
         {
            return;
         }
      }
   }
}
