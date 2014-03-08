package com.ankamagames.dofus.network.messages.game.guild
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.network.types.game.house.HouseInformationsForGuild;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class GuildHousesInformationMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GuildHousesInformationMessage() {
         this.housesInformations = new Vector.<HouseInformationsForGuild>();
         super();
      }
      
      public static const protocolId:uint = 5919;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var housesInformations:Vector.<HouseInformationsForGuild>;
      
      override public function getMessageId() : uint {
         return 5919;
      }
      
      public function initGuildHousesInformationMessage(param1:Vector.<HouseInformationsForGuild>=null) : GuildHousesInformationMessage {
         this.housesInformations = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.housesInformations = new Vector.<HouseInformationsForGuild>();
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
         this.serializeAs_GuildHousesInformationMessage(param1);
      }
      
      public function serializeAs_GuildHousesInformationMessage(param1:IDataOutput) : void {
         param1.writeShort(this.housesInformations.length);
         var _loc2_:uint = 0;
         while(_loc2_ < this.housesInformations.length)
         {
            (this.housesInformations[_loc2_] as HouseInformationsForGuild).serializeAs_HouseInformationsForGuild(param1);
            _loc2_++;
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_GuildHousesInformationMessage(param1);
      }
      
      public function deserializeAs_GuildHousesInformationMessage(param1:IDataInput) : void {
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
