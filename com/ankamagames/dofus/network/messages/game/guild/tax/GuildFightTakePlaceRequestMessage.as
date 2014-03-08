package com.ankamagames.dofus.network.messages.game.guild.tax
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class GuildFightTakePlaceRequestMessage extends GuildFightJoinRequestMessage implements INetworkMessage
   {
      
      public function GuildFightTakePlaceRequestMessage() {
         super();
      }
      
      public static const protocolId:uint = 6235;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var replacedCharacterId:int = 0;
      
      override public function getMessageId() : uint {
         return 6235;
      }
      
      public function initGuildFightTakePlaceRequestMessage(param1:int=0, param2:int=0) : GuildFightTakePlaceRequestMessage {
         super.initGuildFightJoinRequestMessage(param1);
         this.replacedCharacterId = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.replacedCharacterId = 0;
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
      
      override public function serialize(param1:IDataOutput) : void {
         this.serializeAs_GuildFightTakePlaceRequestMessage(param1);
      }
      
      public function serializeAs_GuildFightTakePlaceRequestMessage(param1:IDataOutput) : void {
         super.serializeAs_GuildFightJoinRequestMessage(param1);
         param1.writeInt(this.replacedCharacterId);
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_GuildFightTakePlaceRequestMessage(param1);
      }
      
      public function deserializeAs_GuildFightTakePlaceRequestMessage(param1:IDataInput) : void {
         super.deserialize(param1);
         this.replacedCharacterId = param1.readInt();
      }
   }
}
