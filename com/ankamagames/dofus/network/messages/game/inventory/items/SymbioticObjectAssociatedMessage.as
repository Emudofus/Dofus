package com.ankamagames.dofus.network.messages.game.inventory.items
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class SymbioticObjectAssociatedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function SymbioticObjectAssociatedMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 6527;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var hostUID:uint = 0;
      
      override public function getMessageId() : uint
      {
         return 6527;
      }
      
      public function initSymbioticObjectAssociatedMessage(param1:uint = 0) : SymbioticObjectAssociatedMessage
      {
         this.hostUID = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.hostUID = 0;
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
         this.serializeAs_SymbioticObjectAssociatedMessage(param1);
      }
      
      public function serializeAs_SymbioticObjectAssociatedMessage(param1:ICustomDataOutput) : void
      {
         if(this.hostUID < 0)
         {
            throw new Error("Forbidden value (" + this.hostUID + ") on element hostUID.");
         }
         else
         {
            param1.writeVarInt(this.hostUID);
            return;
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_SymbioticObjectAssociatedMessage(param1);
      }
      
      public function deserializeAs_SymbioticObjectAssociatedMessage(param1:ICustomDataInput) : void
      {
         this.hostUID = param1.readVarUhInt();
         if(this.hostUID < 0)
         {
            throw new Error("Forbidden value (" + this.hostUID + ") on element of SymbioticObjectAssociatedMessage.hostUID.");
         }
         else
         {
            return;
         }
      }
   }
}
