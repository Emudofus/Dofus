package com.ankamagames.dofus.network.messages.game.interactive
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class InteractiveUseErrorMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function InteractiveUseErrorMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 6384;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var elemId:uint = 0;
      
      public var skillInstanceUid:uint = 0;
      
      override public function getMessageId() : uint
      {
         return 6384;
      }
      
      public function initInteractiveUseErrorMessage(param1:uint = 0, param2:uint = 0) : InteractiveUseErrorMessage
      {
         this.elemId = param1;
         this.skillInstanceUid = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.elemId = 0;
         this.skillInstanceUid = 0;
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
         this.serializeAs_InteractiveUseErrorMessage(param1);
      }
      
      public function serializeAs_InteractiveUseErrorMessage(param1:ICustomDataOutput) : void
      {
         if(this.elemId < 0)
         {
            throw new Error("Forbidden value (" + this.elemId + ") on element elemId.");
         }
         else
         {
            param1.writeVarInt(this.elemId);
            if(this.skillInstanceUid < 0)
            {
               throw new Error("Forbidden value (" + this.skillInstanceUid + ") on element skillInstanceUid.");
            }
            else
            {
               param1.writeVarInt(this.skillInstanceUid);
               return;
            }
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_InteractiveUseErrorMessage(param1);
      }
      
      public function deserializeAs_InteractiveUseErrorMessage(param1:ICustomDataInput) : void
      {
         this.elemId = param1.readVarUhInt();
         if(this.elemId < 0)
         {
            throw new Error("Forbidden value (" + this.elemId + ") on element of InteractiveUseErrorMessage.elemId.");
         }
         else
         {
            this.skillInstanceUid = param1.readVarUhInt();
            if(this.skillInstanceUid < 0)
            {
               throw new Error("Forbidden value (" + this.skillInstanceUid + ") on element of InteractiveUseErrorMessage.skillInstanceUid.");
            }
            else
            {
               return;
            }
         }
      }
   }
}
