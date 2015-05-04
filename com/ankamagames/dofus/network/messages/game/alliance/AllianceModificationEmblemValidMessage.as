package com.ankamagames.dofus.network.messages.game.alliance
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.guild.GuildEmblem;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class AllianceModificationEmblemValidMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function AllianceModificationEmblemValidMessage()
      {
         this.Alliancemblem = new GuildEmblem();
         super();
      }
      
      public static const protocolId:uint = 6447;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var Alliancemblem:GuildEmblem;
      
      override public function getMessageId() : uint
      {
         return 6447;
      }
      
      public function initAllianceModificationEmblemValidMessage(param1:GuildEmblem = null) : AllianceModificationEmblemValidMessage
      {
         this.Alliancemblem = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.Alliancemblem = new GuildEmblem();
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
         this.serializeAs_AllianceModificationEmblemValidMessage(param1);
      }
      
      public function serializeAs_AllianceModificationEmblemValidMessage(param1:ICustomDataOutput) : void
      {
         this.Alliancemblem.serializeAs_GuildEmblem(param1);
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_AllianceModificationEmblemValidMessage(param1);
      }
      
      public function deserializeAs_AllianceModificationEmblemValidMessage(param1:ICustomDataInput) : void
      {
         this.Alliancemblem = new GuildEmblem();
         this.Alliancemblem.deserialize(param1);
      }
   }
}
