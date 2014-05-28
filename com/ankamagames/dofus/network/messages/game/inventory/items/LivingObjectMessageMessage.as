package com.ankamagames.dofus.network.messages.game.inventory.items
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class LivingObjectMessageMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function LivingObjectMessageMessage() {
         super();
      }
      
      public static const protocolId:uint = 6065;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var msgId:uint = 0;
      
      public var timeStamp:uint = 0;
      
      public var owner:String = "";
      
      public var objectGenericId:uint = 0;
      
      override public function getMessageId() : uint {
         return 6065;
      }
      
      public function initLivingObjectMessageMessage(msgId:uint = 0, timeStamp:uint = 0, owner:String = "", objectGenericId:uint = 0) : LivingObjectMessageMessage {
         this.msgId = msgId;
         this.timeStamp = timeStamp;
         this.owner = owner;
         this.objectGenericId = objectGenericId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.msgId = 0;
         this.timeStamp = 0;
         this.owner = "";
         this.objectGenericId = 0;
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
         this.serializeAs_LivingObjectMessageMessage(output);
      }
      
      public function serializeAs_LivingObjectMessageMessage(output:IDataOutput) : void {
         if(this.msgId < 0)
         {
            throw new Error("Forbidden value (" + this.msgId + ") on element msgId.");
         }
         else
         {
            output.writeShort(this.msgId);
            if((this.timeStamp < 0) || (this.timeStamp > 4.294967295E9))
            {
               throw new Error("Forbidden value (" + this.timeStamp + ") on element timeStamp.");
            }
            else
            {
               output.writeUnsignedInt(this.timeStamp);
               output.writeUTF(this.owner);
               if((this.objectGenericId < 0) || (this.objectGenericId > 4.294967295E9))
               {
                  throw new Error("Forbidden value (" + this.objectGenericId + ") on element objectGenericId.");
               }
               else
               {
                  output.writeUnsignedInt(this.objectGenericId);
                  return;
               }
            }
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_LivingObjectMessageMessage(input);
      }
      
      public function deserializeAs_LivingObjectMessageMessage(input:IDataInput) : void {
         this.msgId = input.readShort();
         if(this.msgId < 0)
         {
            throw new Error("Forbidden value (" + this.msgId + ") on element of LivingObjectMessageMessage.msgId.");
         }
         else
         {
            this.timeStamp = input.readUnsignedInt();
            if((this.timeStamp < 0) || (this.timeStamp > 4.294967295E9))
            {
               throw new Error("Forbidden value (" + this.timeStamp + ") on element of LivingObjectMessageMessage.timeStamp.");
            }
            else
            {
               this.owner = input.readUTF();
               this.objectGenericId = input.readUnsignedInt();
               if((this.objectGenericId < 0) || (this.objectGenericId > 4.294967295E9))
               {
                  throw new Error("Forbidden value (" + this.objectGenericId + ") on element of LivingObjectMessageMessage.objectGenericId.");
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
