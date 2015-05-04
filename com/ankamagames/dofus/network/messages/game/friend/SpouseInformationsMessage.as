package com.ankamagames.dofus.network.messages.game.friend
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.friend.FriendSpouseInformations;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   
   public class SpouseInformationsMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function SpouseInformationsMessage()
      {
         this.spouse = new FriendSpouseInformations();
         super();
      }
      
      public static const protocolId:uint = 6356;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var spouse:FriendSpouseInformations;
      
      override public function getMessageId() : uint
      {
         return 6356;
      }
      
      public function initSpouseInformationsMessage(param1:FriendSpouseInformations = null) : SpouseInformationsMessage
      {
         this.spouse = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.spouse = new FriendSpouseInformations();
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
         this.serializeAs_SpouseInformationsMessage(param1);
      }
      
      public function serializeAs_SpouseInformationsMessage(param1:ICustomDataOutput) : void
      {
         param1.writeShort(this.spouse.getTypeId());
         this.spouse.serialize(param1);
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_SpouseInformationsMessage(param1);
      }
      
      public function deserializeAs_SpouseInformationsMessage(param1:ICustomDataInput) : void
      {
         var _loc2_:uint = param1.readUnsignedShort();
         this.spouse = ProtocolTypeManager.getInstance(FriendSpouseInformations,_loc2_);
         this.spouse.deserialize(param1);
      }
   }
}
