package com.ankamagames.dofus.network.messages.game.guild
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.context.roleplay.BasicNamedAllianceInformations;
   import com.ankamagames.dofus.network.types.game.social.GuildFactSheetInformations;
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.network.types.game.character.CharacterMinimalInformations;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class GuildInAllianceFactsMessage extends GuildFactsMessage implements INetworkMessage
   {
      
      public function GuildInAllianceFactsMessage() {
         this.allianceInfos = new BasicNamedAllianceInformations();
         super();
      }
      
      public static const protocolId:uint = 6422;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var allianceInfos:BasicNamedAllianceInformations;
      
      override public function getMessageId() : uint {
         return 6422;
      }
      
      public function initGuildInAllianceFactsMessage(infos:GuildFactSheetInformations=null, creationDate:uint=0, nbTaxCollectors:uint=0, enabled:Boolean=false, members:Vector.<CharacterMinimalInformations>=null, allianceInfos:BasicNamedAllianceInformations=null) : GuildInAllianceFactsMessage {
         super.initGuildFactsMessage(infos,creationDate,nbTaxCollectors,enabled,members);
         this.allianceInfos = allianceInfos;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.allianceInfos = new BasicNamedAllianceInformations();
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
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_GuildInAllianceFactsMessage(output);
      }
      
      public function serializeAs_GuildInAllianceFactsMessage(output:IDataOutput) : void {
         super.serializeAs_GuildFactsMessage(output);
         this.allianceInfos.serializeAs_BasicNamedAllianceInformations(output);
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GuildInAllianceFactsMessage(input);
      }
      
      public function deserializeAs_GuildInAllianceFactsMessage(input:IDataInput) : void {
         super.deserialize(input);
         this.allianceInfos = new BasicNamedAllianceInformations();
         this.allianceInfos.deserialize(input);
      }
   }
}
