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
      
      public function initMountFeedRequestMessage(mountUid:Number=0, mountLocation:int=0, mountFoodUid:uint=0, quantity:uint=0) : MountFeedRequestMessage {
         this.mountUid = mountUid;
         this.mountLocation = mountLocation;
         this.mountFoodUid = mountFoodUid;
         this.quantity = quantity;
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
      
      override public function pack(output:IDataOutput) : void {
         var data:ByteArray = new ByteArray();
         this.serialize(data);
         writePacket(output,this.getMessageId(),data);
      }
      
      override public function unpack(input:IDataInput, length:uint) : void {
         this.deserialize(input);
      }
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_MountFeedRequestMessage(output);
      }
      
      public function serializeAs_MountFeedRequestMessage(output:IDataOutput) : void {
         if(this.mountUid < 0)
         {
            throw new Error("Forbidden value (" + this.mountUid + ") on element mountUid.");
         }
         else
         {
            output.writeDouble(this.mountUid);
            output.writeByte(this.mountLocation);
            if(this.mountFoodUid < 0)
            {
               throw new Error("Forbidden value (" + this.mountFoodUid + ") on element mountFoodUid.");
            }
            else
            {
               output.writeInt(this.mountFoodUid);
               if(this.quantity < 0)
               {
                  throw new Error("Forbidden value (" + this.quantity + ") on element quantity.");
               }
               else
               {
                  output.writeInt(this.quantity);
                  return;
               }
            }
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_MountFeedRequestMessage(input);
      }
      
      public function deserializeAs_MountFeedRequestMessage(input:IDataInput) : void {
         this.mountUid = input.readDouble();
         if(this.mountUid < 0)
         {
            throw new Error("Forbidden value (" + this.mountUid + ") on element of MountFeedRequestMessage.mountUid.");
         }
         else
         {
            this.mountLocation = input.readByte();
            this.mountFoodUid = input.readInt();
            if(this.mountFoodUid < 0)
            {
               throw new Error("Forbidden value (" + this.mountFoodUid + ") on element of MountFeedRequestMessage.mountFoodUid.");
            }
            else
            {
               this.quantity = input.readInt();
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
