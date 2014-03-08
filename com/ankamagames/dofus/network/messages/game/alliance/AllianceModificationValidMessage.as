package com.ankamagames.dofus.network.messages.game.alliance
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.guild.GuildEmblem;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class AllianceModificationValidMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function AllianceModificationValidMessage() {
         this.Alliancemblem = new GuildEmblem();
         super();
      }
      
      public static const protocolId:uint = 6450;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var allianceName:String = "";
      
      public var allianceTag:String = "";
      
      public var Alliancemblem:GuildEmblem;
      
      override public function getMessageId() : uint {
         return 6450;
      }
      
      public function initAllianceModificationValidMessage(param1:String="", param2:String="", param3:GuildEmblem=null) : AllianceModificationValidMessage {
         this.allianceName = param1;
         this.allianceTag = param2;
         this.Alliancemblem = param3;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.allianceName = "";
         this.allianceTag = "";
         this.Alliancemblem = new GuildEmblem();
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
         this.serializeAs_AllianceModificationValidMessage(param1);
      }
      
      public function serializeAs_AllianceModificationValidMessage(param1:IDataOutput) : void {
         param1.writeUTF(this.allianceName);
         param1.writeUTF(this.allianceTag);
         this.Alliancemblem.serializeAs_GuildEmblem(param1);
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_AllianceModificationValidMessage(param1);
      }
      
      public function deserializeAs_AllianceModificationValidMessage(param1:IDataInput) : void {
         this.allianceName = param1.readUTF();
         this.allianceTag = param1.readUTF();
         this.Alliancemblem = new GuildEmblem();
         this.Alliancemblem.deserialize(param1);
      }
   }
}
