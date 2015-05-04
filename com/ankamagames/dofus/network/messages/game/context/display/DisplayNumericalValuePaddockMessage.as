package com.ankamagames.dofus.network.messages.game.context.display
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class DisplayNumericalValuePaddockMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function DisplayNumericalValuePaddockMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 6563;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var rideId:int = 0;
      
      public var value:int = 0;
      
      public var type:uint = 0;
      
      override public function getMessageId() : uint
      {
         return 6563;
      }
      
      public function initDisplayNumericalValuePaddockMessage(param1:int = 0, param2:int = 0, param3:uint = 0) : DisplayNumericalValuePaddockMessage
      {
         this.rideId = param1;
         this.value = param2;
         this.type = param3;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.rideId = 0;
         this.value = 0;
         this.type = 0;
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
         this.serializeAs_DisplayNumericalValuePaddockMessage(param1);
      }
      
      public function serializeAs_DisplayNumericalValuePaddockMessage(param1:ICustomDataOutput) : void
      {
         param1.writeInt(this.rideId);
         param1.writeInt(this.value);
         param1.writeByte(this.type);
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_DisplayNumericalValuePaddockMessage(param1);
      }
      
      public function deserializeAs_DisplayNumericalValuePaddockMessage(param1:ICustomDataInput) : void
      {
         this.rideId = param1.readInt();
         this.value = param1.readInt();
         this.type = param1.readByte();
         if(this.type < 0)
         {
            throw new Error("Forbidden value (" + this.type + ") on element of DisplayNumericalValuePaddockMessage.type.");
         }
         else
         {
            return;
         }
      }
   }
}
