package com.ankamagames.dofus.network.messages.game.context.roleplay.houses.guild
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class HouseGuildShareRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function HouseGuildShareRequestMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 5704;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var enable:Boolean = false;
      
      public var rights:uint = 0;
      
      override public function getMessageId() : uint
      {
         return 5704;
      }
      
      public function initHouseGuildShareRequestMessage(param1:Boolean = false, param2:uint = 0) : HouseGuildShareRequestMessage
      {
         this.enable = param1;
         this.rights = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.enable = false;
         this.rights = 0;
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
         this.serializeAs_HouseGuildShareRequestMessage(param1);
      }
      
      public function serializeAs_HouseGuildShareRequestMessage(param1:ICustomDataOutput) : void
      {
         param1.writeBoolean(this.enable);
         if(this.rights < 0)
         {
            throw new Error("Forbidden value (" + this.rights + ") on element rights.");
         }
         else
         {
            param1.writeVarInt(this.rights);
            return;
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_HouseGuildShareRequestMessage(param1);
      }
      
      public function deserializeAs_HouseGuildShareRequestMessage(param1:ICustomDataInput) : void
      {
         this.enable = param1.readBoolean();
         this.rights = param1.readVarUhInt();
         if(this.rights < 0)
         {
            throw new Error("Forbidden value (" + this.rights + ") on element of HouseGuildShareRequestMessage.rights.");
         }
         else
         {
            return;
         }
      }
   }
}
