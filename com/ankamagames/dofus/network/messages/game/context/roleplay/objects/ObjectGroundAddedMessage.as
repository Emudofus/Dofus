package com.ankamagames.dofus.network.messages.game.context.roleplay.objects
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ObjectGroundAddedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ObjectGroundAddedMessage() {
         super();
      }
      
      public static const protocolId:uint = 3017;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var cellId:uint = 0;
      
      public var objectGID:uint = 0;
      
      override public function getMessageId() : uint {
         return 3017;
      }
      
      public function initObjectGroundAddedMessage(cellId:uint=0, objectGID:uint=0) : ObjectGroundAddedMessage {
         this.cellId = cellId;
         this.objectGID = objectGID;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.cellId = 0;
         this.objectGID = 0;
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
         this.serializeAs_ObjectGroundAddedMessage(output);
      }
      
      public function serializeAs_ObjectGroundAddedMessage(output:IDataOutput) : void {
         if((this.cellId < 0) || (this.cellId > 559))
         {
            throw new Error("Forbidden value (" + this.cellId + ") on element cellId.");
         }
         else
         {
            output.writeShort(this.cellId);
            if(this.objectGID < 0)
            {
               throw new Error("Forbidden value (" + this.objectGID + ") on element objectGID.");
            }
            else
            {
               output.writeShort(this.objectGID);
               return;
            }
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ObjectGroundAddedMessage(input);
      }
      
      public function deserializeAs_ObjectGroundAddedMessage(input:IDataInput) : void {
         this.cellId = input.readShort();
         if((this.cellId < 0) || (this.cellId > 559))
         {
            throw new Error("Forbidden value (" + this.cellId + ") on element of ObjectGroundAddedMessage.cellId.");
         }
         else
         {
            this.objectGID = input.readShort();
            if(this.objectGID < 0)
            {
               throw new Error("Forbidden value (" + this.objectGID + ") on element of ObjectGroundAddedMessage.objectGID.");
            }
            else
            {
               return;
            }
         }
      }
   }
}
