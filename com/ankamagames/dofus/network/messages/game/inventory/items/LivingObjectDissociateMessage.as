package com.ankamagames.dofus.network.messages.game.inventory.items
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class LivingObjectDissociateMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function LivingObjectDissociateMessage() {
         super();
      }
      
      public static const protocolId:uint = 5723;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var livingUID:uint = 0;
      
      public var livingPosition:uint = 0;
      
      override public function getMessageId() : uint {
         return 5723;
      }
      
      public function initLivingObjectDissociateMessage(livingUID:uint=0, livingPosition:uint=0) : LivingObjectDissociateMessage {
         this.livingUID = livingUID;
         this.livingPosition = livingPosition;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.livingUID = 0;
         this.livingPosition = 0;
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
         this.serializeAs_LivingObjectDissociateMessage(output);
      }
      
      public function serializeAs_LivingObjectDissociateMessage(output:IDataOutput) : void {
         if(this.livingUID < 0)
         {
            throw new Error("Forbidden value (" + this.livingUID + ") on element livingUID.");
         }
         else
         {
            output.writeInt(this.livingUID);
            if((this.livingPosition < 0) || (this.livingPosition > 255))
            {
               throw new Error("Forbidden value (" + this.livingPosition + ") on element livingPosition.");
            }
            else
            {
               output.writeByte(this.livingPosition);
               return;
            }
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_LivingObjectDissociateMessage(input);
      }
      
      public function deserializeAs_LivingObjectDissociateMessage(input:IDataInput) : void {
         this.livingUID = input.readInt();
         if(this.livingUID < 0)
         {
            throw new Error("Forbidden value (" + this.livingUID + ") on element of LivingObjectDissociateMessage.livingUID.");
         }
         else
         {
            this.livingPosition = input.readUnsignedByte();
            if((this.livingPosition < 0) || (this.livingPosition > 255))
            {
               throw new Error("Forbidden value (" + this.livingPosition + ") on element of LivingObjectDissociateMessage.livingPosition.");
            }
            else
            {
               return;
            }
         }
      }
   }
}
