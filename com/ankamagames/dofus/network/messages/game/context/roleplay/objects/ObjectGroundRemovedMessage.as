package com.ankamagames.dofus.network.messages.game.context.roleplay.objects
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ObjectGroundRemovedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ObjectGroundRemovedMessage() {
         super();
      }
      
      public static const protocolId:uint = 3014;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var cell:uint = 0;
      
      override public function getMessageId() : uint {
         return 3014;
      }
      
      public function initObjectGroundRemovedMessage(cell:uint = 0) : ObjectGroundRemovedMessage {
         this.cell = cell;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.cell = 0;
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
         this.serializeAs_ObjectGroundRemovedMessage(output);
      }
      
      public function serializeAs_ObjectGroundRemovedMessage(output:IDataOutput) : void {
         if((this.cell < 0) || (this.cell > 559))
         {
            throw new Error("Forbidden value (" + this.cell + ") on element cell.");
         }
         else
         {
            output.writeShort(this.cell);
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ObjectGroundRemovedMessage(input);
      }
      
      public function deserializeAs_ObjectGroundRemovedMessage(input:IDataInput) : void {
         this.cell = input.readShort();
         if((this.cell < 0) || (this.cell > 559))
         {
            throw new Error("Forbidden value (" + this.cell + ") on element of ObjectGroundRemovedMessage.cell.");
         }
         else
         {
            return;
         }
      }
   }
}
