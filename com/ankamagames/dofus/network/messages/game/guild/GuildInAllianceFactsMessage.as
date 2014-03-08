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
      
      public function initGuildInAllianceFactsMessage(param1:GuildFactSheetInformations=null, param2:uint=0, param3:uint=0, param4:Boolean=false, param5:Vector.<CharacterMinimalInformations>=null, param6:BasicNamedAllianceInformations=null) : GuildInAllianceFactsMessage {
         super.initGuildFactsMessage(param1,param2,param3,param4,param5);
         this.allianceInfos = param6;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.allianceInfos = new BasicNamedAllianceInformations();
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
         this.serializeAs_GuildInAllianceFactsMessage(param1);
      }
      
      public function serializeAs_GuildInAllianceFactsMessage(param1:IDataOutput) : void {
         super.serializeAs_GuildFactsMessage(param1);
         this.allianceInfos.serializeAs_BasicNamedAllianceInformations(param1);
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_GuildInAllianceFactsMessage(param1);
      }
      
      public function deserializeAs_GuildInAllianceFactsMessage(param1:IDataInput) : void {
         super.deserialize(param1);
         this.allianceInfos = new BasicNamedAllianceInformations();
         this.allianceInfos.deserialize(param1);
      }
   }
}
