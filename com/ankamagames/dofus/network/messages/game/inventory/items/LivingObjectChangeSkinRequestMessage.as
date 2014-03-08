package com.ankamagames.dofus.network.messages.game.inventory.items
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class LivingObjectChangeSkinRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function LivingObjectChangeSkinRequestMessage() {
         super();
      }
      
      public static const protocolId:uint = 5725;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var livingUID:uint = 0;
      
      public var livingPosition:uint = 0;
      
      public var skinId:uint = 0;
      
      override public function getMessageId() : uint {
         return 5725;
      }
      
      public function initLivingObjectChangeSkinRequestMessage(livingUID:uint=0, livingPosition:uint=0, skinId:uint=0) : LivingObjectChangeSkinRequestMessage {
         this.livingUID = livingUID;
         this.livingPosition = livingPosition;
         this.skinId = skinId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.livingUID = 0;
         this.livingPosition = 0;
         this.skinId = 0;
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
         this.serializeAs_LivingObjectChangeSkinRequestMessage(output);
      }
      
      public function serializeAs_LivingObjectChangeSkinRequestMessage(output:IDataOutput) : void {
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
               if(this.skinId < 0)
               {
                  throw new Error("Forbidden value (" + this.skinId + ") on element skinId.");
               }
               else
               {
                  output.writeInt(this.skinId);
                  return;
               }
            }
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_LivingObjectChangeSkinRequestMessage(input);
      }
      
      public function deserializeAs_LivingObjectChangeSkinRequestMessage(input:IDataInput) : void {
         this.livingUID = input.readInt();
         if(this.livingUID < 0)
         {
            throw new Error("Forbidden value (" + this.livingUID + ") on element of LivingObjectChangeSkinRequestMessage.livingUID.");
         }
         else
         {
            this.livingPosition = input.readUnsignedByte();
            if((this.livingPosition < 0) || (this.livingPosition > 255))
            {
               throw new Error("Forbidden value (" + this.livingPosition + ") on element of LivingObjectChangeSkinRequestMessage.livingPosition.");
            }
            else
            {
               this.skinId = input.readInt();
               if(this.skinId < 0)
               {
                  throw new Error("Forbidden value (" + this.skinId + ") on element of LivingObjectChangeSkinRequestMessage.skinId.");
               }
               else
               {
                  return;
               }
            }
         }
      }
   }
}
