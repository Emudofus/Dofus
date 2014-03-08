package com.ankamagames.dofus.network.messages.game.alliance
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.guild.GuildEmblem;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class AllianceModificationEmblemValidMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function AllianceModificationEmblemValidMessage() {
         this.Alliancemblem = new GuildEmblem();
         super();
      }
      
      public static const protocolId:uint = 6447;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var Alliancemblem:GuildEmblem;
      
      override public function getMessageId() : uint {
         return 6447;
      }
      
      public function initAllianceModificationEmblemValidMessage(Alliancemblem:GuildEmblem=null) : AllianceModificationEmblemValidMessage {
         this.Alliancemblem = Alliancemblem;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.Alliancemblem = new GuildEmblem();
         this._isInitialized = false;
      }
      
      override public function pack(output:IDataOutput) : void {
         var data:ByteArray = new ByteArray();
         this.serialize(data);
         writePacket(output,this.getMessageId(),data);
      }
      
      override public function unpack(input:IDataInput, length:uint) : void {
         this.deserialize(input);
      }
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_AllianceModificationEmblemValidMessage(output);
      }
      
      public function serializeAs_AllianceModificationEmblemValidMessage(output:IDataOutput) : void {
         this.Alliancemblem.serializeAs_GuildEmblem(output);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_AllianceModificationEmblemValidMessage(input);
      }
      
      public function deserializeAs_AllianceModificationEmblemValidMessage(input:IDataInput) : void {
         this.Alliancemblem = new GuildEmblem();
         this.Alliancemblem.deserialize(input);
      }
   }
}
