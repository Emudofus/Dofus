package com.ankamagames.dofus.network.messages.game.context.mount
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class MountFeedRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function MountFeedRequestMessage() {
         super();
      }
      
      public static const protocolId:uint = 6189;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var mountUid:Number = 0;
      
      public var mountLocation:int = 0;
      
      public var mountFoodUid:uint = 0;
      
      public var quantity:uint = 0;
      
      override public function getMessageId() : uint {
         return 6189;
      }
      
      public function initMountFeedRequestMessage(param1:Number=0, param2:int=0, param3:uint=0, param4:uint=0) : MountFeedRequestMessage {
         this.mountUid = param1;
         this.mountLocation = param2;
         this.mountFoodUid = param3;
         this.quantity = param4;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.mountUid = 0;
         this.mountLocation = 0;
         this.mountFoodUid = 0;
         this.quantity = 0;
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
         this.serializeAs_MountFeedRequestMessage(param1);
      }
      
      public function serializeAs_MountFeedRequestMessage(param1:IDataOutput) : void {
         if(this.mountUid < 0)
         {
            throw new Error("Forbidden value (" + this.mountUid + ") on element mountUid.");
         }
         else
         {
            param1.writeDouble(this.mountUid);
            param1.writeByte(this.mountLocation);
            if(this.mountFoodUid < 0)
            {
               throw new Error("Forbidden value (" + this.mountFoodUid + ") on element mountFoodUid.");
            }
            else
            {
               param1.writeInt(this.mountFoodUid);
               if(this.quantity < 0)
               {
                  throw new Error("Forbidden value (" + this.quantity + ") on element quantity.");
               }
               else
               {
                  param1.writeInt(this.quantity);
                  return;
               }
            }
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_MountFeedRequestMessage(param1);
      }
      
      public function deserializeAs_MountFeedRequestMessage(param1:IDataInput) : void {
         this.mountUid = param1.readDouble();
         if(this.mountUid < 0)
         {
            throw new Error("Forbidden value (" + this.mountUid + ") on element of MountFeedRequestMessage.mountUid.");
         }
         else
         {
            this.mountLocation = param1.readByte();
            this.mountFoodUid = param1.readInt();
            if(this.mountFoodUid < 0)
            {
               throw new Error("Forbidden value (" + this.mountFoodUid + ") on element of MountFeedRequestMessage.mountFoodUid.");
            }
            else
            {
               this.quantity = param1.readInt();
               if(this.quantity < 0)
               {
                  throw new Error("Forbidden value (" + this.quantity + ") on element of MountFeedRequestMessage.quantity.");
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
