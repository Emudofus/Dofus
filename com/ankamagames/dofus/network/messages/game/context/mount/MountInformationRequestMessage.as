package com.ankamagames.dofus.network.messages.game.context.mount
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class MountInformationRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function MountInformationRequestMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 5972;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var id:Number = 0;
      
      public var time:Number = 0;
      
      override public function getMessageId() : uint
      {
         return 5972;
      }
      
      public function initMountInformationRequestMessage(param1:Number = 0, param2:Number = 0) : MountInformationRequestMessage
      {
         this.id = param1;
         this.time = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.id = 0;
         this.time = 0;
         this._isInitialized = false;
      }
      
      override public function pack(param1:ICustomDataOutput) : void
      {
         var _loc2_:ByteArray = new ByteArray();
         this.serialize(new CustomDataWrapper(_loc2_));
         writePacket(param1,this.getMessageId(),_loc2_);
      }
      
      override public function unpack(param1:ICustomDataInput, param2:uint) : void
      {
         this.deserialize(param1);
      }
      
      public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_MountInformationRequestMessage(param1);
      }
      
      public function serializeAs_MountInformationRequestMessage(param1:ICustomDataOutput) : void
      {
         if(this.id < -9.007199254740992E15 || this.id > 9.007199254740992E15)
         {
            throw new Error("Forbidden value (" + this.id + ") on element id.");
         }
         else
         {
            param1.writeDouble(this.id);
            if(this.time < -9.007199254740992E15 || this.time > 9.007199254740992E15)
            {
               throw new Error("Forbidden value (" + this.time + ") on element time.");
            }
            else
            {
               param1.writeDouble(this.time);
               return;
            }
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_MountInformationRequestMessage(param1);
      }
      
      public function deserializeAs_MountInformationRequestMessage(param1:ICustomDataInput) : void
      {
         this.id = param1.readDouble();
         if(this.id < -9.007199254740992E15 || this.id > 9.007199254740992E15)
         {
            throw new Error("Forbidden value (" + this.id + ") on element of MountInformationRequestMessage.id.");
         }
         else
         {
            this.time = param1.readDouble();
            if(this.time < -9.007199254740992E15 || this.time > 9.007199254740992E15)
            {
               throw new Error("Forbidden value (" + this.time + ") on element of MountInformationRequestMessage.time.");
            }
            else
            {
               return;
            }
         }
      }
   }
}
