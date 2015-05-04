package com.ankamagames.dofus.network.messages.game.guild
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.house.HouseInformationsForGuild;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class GuildHousesInformationMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GuildHousesInformationMessage()
      {
         this.housesInformations = new Vector.<HouseInformationsForGuild>();
         super();
      }
      
      public static const protocolId:uint = 5919;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var housesInformations:Vector.<HouseInformationsForGuild>;
      
      override public function getMessageId() : uint
      {
         return 5919;
      }
      
      public function initGuildHousesInformationMessage(param1:Vector.<HouseInformationsForGuild> = null) : GuildHousesInformationMessage
      {
         this.housesInformations = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.housesInformations = new Vector.<HouseInformationsForGuild>();
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
         this.serializeAs_GuildHousesInformationMessage(param1);
      }
      
      public function serializeAs_GuildHousesInformationMessage(param1:ICustomDataOutput) : void
      {
         param1.writeShort(this.housesInformations.length);
         var _loc2_:uint = 0;
         while(_loc2_ < this.housesInformations.length)
         {
            (this.housesInformations[_loc2_] as HouseInformationsForGuild).serializeAs_HouseInformationsForGuild(param1);
            _loc2_++;
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_GuildHousesInformationMessage(param1);
      }
      
      public function deserializeAs_GuildHousesInformationMessage(param1:ICustomDataInput) : void
      {
         var _loc4_:HouseInformationsForGuild = null;
         var _loc2_:uint = param1.readUnsignedShort();
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = new HouseInformationsForGuild();
            _loc4_.deserialize(param1);
            this.housesInformations.push(_loc4_);
            _loc3_++;
         }
      }
   }
}
