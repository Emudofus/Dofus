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
      
      public function initLivingObjectDissociateMessage(param1:uint=0, param2:uint=0) : LivingObjectDissociateMessage {
         this.livingUID = param1;
         this.livingPosition = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.livingUID = 0;
         this.livingPosition = 0;
         this._isInitialized = false;
      }
      
      override public function pack(param1:IDataOutput) : void {
         var _loc2_:ByteArray = new ByteArray();
         this.serialize(_loc2_);
         writePacket(param1,this.getMessageId(),_loc2_);
      }
      
      override public function unpack(param1:IDataInput, param2:uint) : void {
         this.deserialize(param1);
      }
      
      public function serialize(param1:IDataOutput) : void {
         this.serializeAs_LivingObjectDissociateMessage(param1);
      }
      
      public function serializeAs_LivingObjectDissociateMessage(param1:IDataOutput) : void {
         if(this.livingUID < 0)
         {
            throw new Error("Forbidden value (" + this.livingUID + ") on element livingUID.");
         }
         else
         {
            param1.writeInt(this.livingUID);
            if(this.livingPosition < 0 || this.livingPosition > 255)
            {
               throw new Error("Forbidden value (" + this.livingPosition + ") on element livingPosition.");
            }
            else
            {
               param1.writeByte(this.livingPosition);
               return;
            }
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_LivingObjectDissociateMessage(param1);
      }
      
      public function deserializeAs_LivingObjectDissociateMessage(param1:IDataInput) : void {
         this.livingUID = param1.readInt();
         if(this.livingUID < 0)
         {
            throw new Error("Forbidden value (" + this.livingUID + ") on element of LivingObjectDissociateMessage.livingUID.");
         }
         else
         {
            this.livingPosition = param1.readUnsignedByte();
            if(this.livingPosition < 0 || this.livingPosition > 255)
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
